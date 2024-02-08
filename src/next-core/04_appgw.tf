module "integration_appgateway_snet" {
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.50.0"
  name                                      = format("%s-integration-appgateway-snet", local.product_region)
  resource_group_name                       = data.azurerm_resource_group.rg_vnet_integration.name
  virtual_network_name                      = data.azurerm_virtual_network.vnet_integration.name
  address_prefixes                          = var.cidr_subnet_appgateway_integration
  private_endpoint_network_policies_enabled = true

}

resource "azurerm_user_assigned_identity" "appgateway" {
  resource_group_name = data.azurerm_resource_group.sec_rg.name
  location            = data.azurerm_resource_group.sec_rg.location
  name                = format("%s-appgateway-identity", local.product_region)

  tags = var.tags
}

resource "azurerm_public_ip" "integration_appgateway_public_ip" {
  name                = "${local.product_region}-integration-appgateway-pip"
  resource_group_name = data.azurerm_resource_group.rg_vnet_integration.name
  location            = data.azurerm_resource_group.rg_vnet_integration.location
  sku                 = "Standard"
  allocation_method   = "Static"

  tags = var.tags
}

module "app_gw_integration" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//app_gateway?ref=v7.50.0"

  resource_group_name = data.azurerm_virtual_network.vnet_integration.resource_group_name
  location            = var.location
  name                = "${local.product_region}-integration-app-gw"

  # SKU
  sku_name = var.app_gateway_sku_name
  sku_tier = var.app_gateway_sku_tier

  # WAF
  waf_enabled = var.app_gateway_waf_enabled


  # Networking
  subnet_id          = module.integration_appgateway_snet.id
  public_ip_id       = azurerm_public_ip.integration_appgateway_public_ip.id
  private_ip_address = local.integration_appgateway_private_ip
  zones              = [1, 2, 3]

  # Configure backends
  backends = {
    apim = {
      protocol                    = "Https"
      host                        = format("api.%s.%s", var.dns_zone_prefix, var.external_domain)
      port                        = 443
      ip_addresses                = module.apimv2.private_ip_addresses
      fqdns                       = [format("api.%s.%s.", var.dns_zone_prefix, var.external_domain)]
      probe                       = "/status-0123456789abcdef"
      probe_name                  = "probe-apim"
      request_timeout             = 60
      pick_host_name_from_backend = false
    }


  }

  ssl_profiles = [
    {
      name                             = format("%s-ssl-profile", local.product_region)
      trusted_client_certificate_names = null
      verify_client_cert_issuer_dn     = false
      ssl_policy = {
        disabled_protocols = []
        policy_type        = "Custom"
        policy_name        = ""
        # with Custom type set empty policy_name (not required by the provider)
        cipher_suites = [
          "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256",
          "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384",
          "TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA",
          "TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA"
        ]
        min_protocol_version = "TLSv1_2"
      }
    }
  ]

  trusted_client_certificates = [
  ]

  # Configure listeners
  listeners = {
    api = {
      protocol           = "Https"
      host               = format("api.%s.%s", var.dns_zone_prefix, var.external_domain)
      port               = 443
      ssl_profile_name   = format("%s-ssl-profile", local.product_region)
      firewall_policy_id = null
      type               = "Private"

      certificate = {
        name = var.app_gateway_api_certificate_name
        id = trimsuffix(
          data.azurerm_key_vault_certificate.app_gw_platform.secret_id,
          data.azurerm_key_vault_certificate.app_gw_platform.version
        )
      }
    }


  }

  # maps listener to backend
  routes = {

    api = {
      listener              = "api"
      backend               = "apim"
      rewrite_rule_set_name = null
      priority              = 10

    }

  }

  rewrite_rule_sets = [
  ]

  # TLS
  identity_ids = [azurerm_user_assigned_identity.appgateway.id]

  # Scaling
  app_gateway_min_capacity = var.app_gateway_min_capacity
  app_gateway_max_capacity = var.app_gateway_max_capacity

  alerts_enabled = var.app_gateway_alerts_enabled

  action = [
    {
      action_group_id    = data.azurerm_monitor_action_group.slack.id
      webhook_properties = null
    },
    {
      action_group_id    = data.azurerm_monitor_action_group.email.id
      webhook_properties = null
    }
  ]

  # metrics docs
  # https://docs.microsoft.com/en-us/azure/azure-monitor/essentials/metrics-supported#microsoftnetworkapplicationgateways
  monitor_metric_alert_criteria = {

    compute_units_usage = {
      description   = "Abnormal compute units usage, probably an high traffic peak"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 2
      auto_mitigate = true

      criteria = []
      dynamic_criteria = [
        {
          aggregation       = "Average"
          metric_name       = "ComputeUnits"
          operator          = "GreaterOrLessThan"
          alert_sensitivity = "Low"
          # todo after api app migration change to High
          evaluation_total_count   = 2
          evaluation_failure_count = 2
          dimension                = []
        }
      ]
    }

    backend_pools_status = {
      description   = "One or more backend pools are down, check Backend Health on Azure portal"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 0
      auto_mitigate = true

      criteria = [
        {
          aggregation = "Average"
          metric_name = "UnhealthyHostCount"
          operator    = "GreaterThan"
          threshold   = 0
          dimension   = []
        }
      ]
      dynamic_criteria = []
    }

    total_requests = {
      description   = "Traffic is raising"
      frequency     = "PT5M"
      window_size   = "PT15M"
      severity      = 3
      auto_mitigate = true

      criteria = []
      dynamic_criteria = [
        {
          aggregation              = "Total"
          metric_name              = "TotalRequests"
          operator                 = "GreaterThan"
          alert_sensitivity        = "Medium"
          evaluation_total_count   = 1
          evaluation_failure_count = 1
          dimension                = []
        }
      ]
    }

    failed_requests = {
      description   = "Abnormal failed requests"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 1
      auto_mitigate = true

      criteria = []
      dynamic_criteria = [
        {
          aggregation              = "Total"
          metric_name              = "FailedRequests"
          operator                 = "GreaterThan"
          alert_sensitivity        = "Medium"
          evaluation_total_count   = 2
          evaluation_failure_count = 2
          dimension                = []
        }
      ]
    }

  }

  tags = var.tags
}
