module "integration_appgateway_snet" {
  source                            = "./.terraform/modules/__v4__/subnet"
  name                              = "${local.product_region}-integration-appgateway-snet"
  resource_group_name               = azurerm_resource_group.rg_vnet.name
  virtual_network_name              = module.vnet_integration.name
  address_prefixes                  = var.cidr_subnet_appgateway_integration
  private_endpoint_network_policies = "Enabled"
}

resource "azurerm_user_assigned_identity" "appgateway" {
  resource_group_name = azurerm_resource_group.sec_rg.name
  location            = azurerm_resource_group.sec_rg.location
  name                = "${local.product_region}-integration-appgateway-identity"

  tags = module.tag_config.tags
}

resource "azurerm_key_vault_access_policy" "app_gateway_policy" {
  key_vault_id            = module.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = azurerm_user_assigned_identity.appgateway.principal_id
  key_permissions         = ["Get", "List"]
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List", "Purge"]
  storage_permissions     = []
}

resource "azurerm_public_ip" "integration_appgateway_public_ip" {
  name                = "${local.product_region}-integration-appgateway-pip"
  resource_group_name = azurerm_resource_group.rg_vnet.name
  location            = azurerm_resource_group.rg_vnet.location
  sku                 = "Standard"
  allocation_method   = "Static"
  zones               = var.integration_appgateway_zones

  tags = module.tag_config.tags
}

locals {
  listeners_apiprf = {
    apiprf = {
      protocol           = "Https"
      host               = "api.${var.dns_zone_prefix_prf}.${var.external_domain}"
      port               = 443
      ssl_profile_name   = "${local.product_region}-ssl-profile"
      firewall_policy_id = null
      type               = "Private"
      certificate = {
        name = var.integration_app_gateway_prf_certificate_name
        id = var.integration_app_gateway_prf_certificate_name == "" ? null : replace(
          data.azurerm_key_vault_certificate.app_gw_platform_prf[0].secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_platform_prf[0].version}",
          ""
        )
      }
    }
  }

  backends = {
    apim = {
      protocol                    = "Https"
      host                        = "api.${var.dns_zone_prefix}.${var.external_domain}"
      port                        = 443
      ip_addresses                = module.apim[0].private_ip_addresses
      fqdns                       = ["api.${var.dns_zone_prefix}.${var.external_domain}."]
      probe                       = "/status-0123456789abcdef"
      probe_name                  = "probe-apim"
      request_timeout             = 120
      pick_host_name_from_backend = false
    }
  }

  backends_prf = {
    apimprf = {
      protocol                    = "Https"
      host                        = "api.${var.dns_zone_prefix_prf}.${var.external_domain}"
      port                        = 443
      ip_addresses                = module.apim[0].private_ip_addresses
      fqdns                       = ["api.${var.dns_zone_prefix_prf}.${var.external_domain}."]
      probe                       = "/status-0123456789abcdef"
      probe_name                  = "probe-apimprf"
      request_timeout             = 120
      pick_host_name_from_backend = false
    }
  }

  routes = {
    api = {
      listener              = "api"
      backend               = "apim"
      rewrite_rule_set_name = null
      priority              = 10
    }
  }

  routes_prf = {
    apiprf = {
      listener              = "apiprf"
      backend               = "apimprf"
      rewrite_rule_set_name = null
      priority              = 20
    }
  }

  listeners = {
    api = {
      protocol           = "Https"
      host               = "api.${var.dns_zone_prefix}.${var.external_domain}"
      port               = 443
      ssl_profile_name   = "${local.product_region}-ssl-profile"
      firewall_policy_id = null
      type               = "Private"

      certificate = {
        name = var.integration_app_gateway_api_certificate_name
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_platform.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_platform.version}",
          ""
        )
      }
    }

    portal = {
      protocol           = "Https"
      host               = "portal.${var.dns_zone_prefix}.${var.external_domain}"
      port               = 443
      ssl_profile_name   = "${local.product_region}-ssl-profile"
      firewall_policy_id = null
      type               = "Private"

      certificate = {
        name = var.integration_app_gateway_portal_certificate_name
        id = replace(
          data.azurerm_key_vault_certificate.portal_platform.secret_id,
          "/${data.azurerm_key_vault_certificate.portal_platform.version}",
          ""
        )
      }
    }

    management = {
      protocol           = "Https"
      host               = "management.${var.dns_zone_prefix}.${var.external_domain}"
      port               = 443
      ssl_profile_name   = "${local.product_region}-ssl-profile"
      firewall_policy_id = null
      type               = "Private"

      certificate = {
        name = var.integration_app_gateway_management_certificate_name
        id = replace(
          data.azurerm_key_vault_certificate.management_platform.secret_id,
          "/${data.azurerm_key_vault_certificate.management_platform.version}",
          ""
        )
      }
    }
  }
}

#
#  APP GW Integration
#
module "app_gw_integration" {
  source = "./.terraform/modules/__v4__/app_gateway"

  resource_group_name = module.vnet_integration.resource_group_name
  location            = var.location
  name                = "${local.product_region}-integration-app-gw"

  # SKU
  sku_name = var.integration_app_gateway_sku_name
  sku_tier = var.integration_app_gateway_sku_tier

  # WAF
  waf_enabled = var.integration_app_gateway_waf_enabled

  # Networking
  subnet_id          = module.integration_appgateway_snet.id
  public_ip_id       = azurerm_public_ip.integration_appgateway_public_ip.id
  private_ip_address = [var.integration_appgateway_private_ip]
  zones              = var.integration_appgateway_zones

  # Configure backends
  backends = merge(
    local.backends,
    var.dns_zone_prefix_prf != "" ? local.backends_prf : {}
  )

  ssl_profiles = [
    {
      name                             = "${local.product_region}-ssl-profile"
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

  trusted_client_certificates = []

  # Configure listeners
  listeners = merge(
    local.listeners,
    var.dns_zone_prefix_prf != "" ? local.listeners_apiprf : {}
  )

  # maps listener to backend
  routes = merge(
    local.routes,
    var.dns_zone_prefix_prf != "" ? local.routes_prf : {}
  )

  rewrite_rule_sets = []

  # TLS
  identity_ids = [azurerm_user_assigned_identity.appgateway.id]

  # Scaling
  app_gateway_min_capacity = var.integration_app_gateway_min_capacity
  app_gateway_max_capacity = var.integration_app_gateway_max_capacity

  alerts_enabled = var.integration_app_gateway_alerts_enabled

  # takes a list and replaces any elements that are lists with a
  # flattened sequence of the list contents.
  # In this case, we enable OpsGenie only on prod env
  action = flatten([
    [
      {
        action_group_id    = azurerm_monitor_action_group.slack.id
        webhook_properties = null
      },
      {
        action_group_id    = azurerm_monitor_action_group.email.id
        webhook_properties = null
      }
    ],
    (var.env == "prod" ? [
      {
        action_group_id    = azurerm_monitor_action_group.infra_opsgenie.0.id
        webhook_properties = null
      }
    ] : [])
  ])

  # metrics docs
  # https://docs.microsoft.com/en-us/azure/azure-monitor/essentials/metrics-supported#microsoftnetworkapplicationgateways
  monitor_metric_alert_criteria = {

    compute_units_usage_critical = {
      description   = "${module.app_gw_integration.name} Critical compute units usage, probably an high traffic peak"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 1
      auto_mitigate = true

      criteria = [
        {
          aggregation = "Average"
          metric_name = "ComputeUnits"
          operator    = "GreaterThan"
          threshold   = floor(var.integration_app_gateway_max_capacity * 90 / 100)
          dimension   = []
        }
      ]
      dynamic_criteria = []
    }

    compute_units_usage = {
      description   = "${module.app_gw.name} Abnormal compute units usage, probably an high traffic peak"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 2
      auto_mitigate = true

      criteria = []
      dynamic_criteria = [
        {
          aggregation              = "Average"
          metric_name              = "ComputeUnits"
          operator                 = "GreaterOrLessThan"
          alert_sensitivity        = "Low" # todo after api app migration change to High
          evaluation_total_count   = 2
          evaluation_failure_count = 2
          dimension                = []
        }
      ]
    }

    backend_pools_status = {
      description   = "${module.app_gw_integration.name} One or more backend pools are down, check Backend Health on Azure portal"
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
      description   = "${module.app_gw_integration.name} Traffic is raising"
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
      description   = "${module.app_gw_integration.name} Abnormal failed requests"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 2
      auto_mitigate = true

      criteria = []
      dynamic_criteria = [
        {
          aggregation              = "Total"
          metric_name              = "FailedRequests"
          operator                 = "GreaterThan"
          alert_sensitivity        = "Medium"
          evaluation_total_count   = 4
          evaluation_failure_count = 4
          dimension                = []
        }
      ]
    }

  }

  tags = module.tag_config.tags
}
