## Application gateway public ip ##
resource "azurerm_public_ip" "appgateway_public_ip" {
  name                = format("%s-appgateway-pip", local.project)
  resource_group_name = azurerm_resource_group.rg_vnet.name
  location            = azurerm_resource_group.rg_vnet.location
  sku                 = "Standard"
  allocation_method   = "Static"

  tags = var.tags
}

# Subnet to host the application gateway
module "appgateway_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                 = format("%s-appgateway-snet", local.project)
  address_prefixes     = var.cidr_subnet_appgateway
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = module.vnet.name
}

## Application gateway ##
# Since these variables are re-used - a locals block makes this more maintainable
locals {
  backend_address_pool_name       = format("%s-appgw-be-address-pool", local.project)
  frontend_http_port_name         = format("%s-appgw-fe-http-port", local.project)
  frontend_https_port_name        = format("%s-appgw-fe-https-port", local.project)
  frontend_ip_configuration_name  = format("%s-appgw-fe-ip-configuration", local.project)
  http_setting_name               = format("%s-appgw-be-http-settings", local.project)
  http_listener_name              = format("%s-appgw-fe-http-settings", local.project)
  https_listener_name             = format("%s-appgw-fe-https-settings", local.project)
  http_request_routing_rule_name  = format("%s-appgw-http-reqs-routing-rule", local.project)
  https_request_routing_rule_name = format("%s-appgw-https-reqs-routing-rule", local.project)
  acme_le_ssl_cert_name           = format("%s-appgw-acme-le-ssl-cert", local.project)
  http_to_https_redirect_rule     = format("%s-appgw-http-to-https-redirect-rule", local.project)
}

# Application gateway: Multilistener configuraiton
module "app_gw" {
  source = "git::https://github.com/pagopa/azurerm.git//app_gateway?ref=v1.0.87"

  resource_group_name = azurerm_resource_group.rg_vnet.name
  location            = azurerm_resource_group.rg_vnet.location
  name                = format("%s-app-gw", local.project)

  # SKU
  sku_name = "WAF_v2"
  sku_tier = "WAF_v2"

  # Networking
  subnet_id    = module.appgateway_snet.id
  public_ip_id = azurerm_public_ip.appgateway_public_ip.id

  # Configure backends
  backends = {
    apim = {
      protocol                    = "Https"
      host                        = trim(azurerm_dns_a_record.dns_a_api.fqdn, ".")
      port                        = 443
      ip_addresses                = module.apim.private_ip_addresses
      fqdns                       = [azurerm_dns_a_record.dns_a_api.fqdn]
      probe                       = "/status-0123456789abcdef"
      probe_name                  = "probe-apim"
      request_timeout             = 8
      pick_host_name_from_backend = false
    }

    portal = {
      protocol                    = "Https"
      host                        = trim(azurerm_dns_a_record.dns_a_portal.fqdn, ".")
      port                        = 443
      ip_addresses                = module.apim.private_ip_addresses
      fqdns                       = [azurerm_dns_a_record.dns_a_portal.fqdn]
      probe                       = "/signin"
      probe_name                  = "probe-portal"
      request_timeout             = 8
      pick_host_name_from_backend = false
    }

    management = {
      protocol     = "Https"
      host         = trim(azurerm_dns_a_record.dns_a_management.fqdn, ".")
      port         = 443
      ip_addresses = module.apim.private_ip_addresses
      fqdns        = [azurerm_dns_a_record.dns_a_management.fqdn]

      probe                       = "/ServiceStatus"
      probe_name                  = "probe-management"
      request_timeout             = 8
      pick_host_name_from_backend = false
    }
  }

  ssl_profiles = [{
    name                             = format("%s-ssl-profile", local.project)
    trusted_client_certificate_names = null
    verify_client_cert_issuer_dn     = false
    ssl_policy = {
      disabled_protocols = []
      policy_type        = "Custom"
      policy_name        = "" # with Custom type set empty policy_name (not required by the provider)
      cipher_suites = [
        "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256",
        "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384",
        "TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA",
        "TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA"
      ]
      min_protocol_version = "TLSv1_2"
    }
  }]

  trusted_client_certificates = []

  # Configure listeners
  listeners = {

    api = {
      protocol           = "Https"
      host               = format("api.%s.%s", var.dns_zone_prefix, var.external_domain)
      port               = 443
      ssl_profile_name   = format("%s-ssl-profile", local.project)
      firewall_policy_id = null

      certificate = {
        name = var.app_gateway_api_certificate_name
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_platform.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_platform.version}",
          ""
        )
      }
    }

    portal = {
      protocol           = "Https"
      host               = format("portal.%s.%s", var.dns_zone_prefix, var.external_domain)
      port               = 443
      ssl_profile_name   = format("%s-ssl-profile", local.project)
      firewall_policy_id = null

      certificate = {
        name = var.app_gateway_portal_certificate_name
        id = replace(
          data.azurerm_key_vault_certificate.portal_platform.secret_id,
          "/${data.azurerm_key_vault_certificate.portal_platform.version}",
          ""
        )
      }
    }

    management = {
      protocol           = "Https"
      host               = format("management.%s.%s", var.dns_zone_prefix, var.external_domain)
      port               = 443
      ssl_profile_name   = format("%s-ssl-profile", local.project)
      firewall_policy_id = null

      certificate = {
        name = var.app_gateway_management_certificate_name
        id = replace(
          data.azurerm_key_vault_certificate.management_platform.secret_id,
          "/${data.azurerm_key_vault_certificate.management_platform.version}",
          ""
        )
      }
    }
  }

  # maps listener to backend
  routes = {
    api = {
      listener              = "api"
      backend               = "apim"
      rewrite_rule_set_name = "rewrite-rule-set-api"
    }

    portal = {
      listener              = "portal"
      backend               = "portal"
      rewrite_rule_set_name = null
    }

    mangement = {
      listener              = "management"
      backend               = "management"
      rewrite_rule_set_name = null
    }
  }

  rewrite_rule_sets = [
    {
      name = "rewrite-rule-set-api"
      rewrite_rules = [{
        name          = "http-headers-api"
        rule_sequence = 100
        condition     = null
        request_header_configurations = [
          {
            header_name  = "X-Forwarded-For"
            header_value = "{var_client_ip}"
          },
          {
            header_name  = "X-Client-Ip"
            header_value = "{var_client_ip}"
          },
        ]
        response_header_configurations = []
      }]
    }
  ]
  # TLS
  identity_ids = [azurerm_user_assigned_identity.appgateway.id]

  # Scaling
  app_gateway_min_capacity = var.app_gateway_min_capacity
  app_gateway_max_capacity = var.app_gateway_max_capacity

  # Logs
  sec_log_analytics_workspace_id = var.env_short == "p" ? data.azurerm_key_vault_secret.sec_workspace_id[0].value : null
  sec_storage_id                 = var.env_short == "p" ? data.azurerm_key_vault_secret.sec_storage_id[0].value : null

  alerts_enabled = var.app_gateway_alerts_enabled

  action = [
    {
      action_group_id    = azurerm_monitor_action_group.slack.id
      webhook_properties = null
    },
    {
      action_group_id    = azurerm_monitor_action_group.email.id
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
      description   = "One or more backend pools are down, check Backend Health on Azure portal"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 0
      auto_mitigate = true

      criteria = [
        {
          aggregation              = "Average"
          metric_name              = "UnhealthyHostCount"
          operator                 = "GreaterThan"
          threshold                = 0
          dimension                = []
        }
      ]
      dynamic_criteria = []
    }

    response_time = {
      description   = "Backends response time is too high"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 2
      auto_mitigate = true
      
      criteria = []
      dynamic_criteria = [
        {
          aggregation              = "Average"
          metric_name              = "BackendLastByteResponseTime"
          operator                 = "GreaterThan"
          alert_sensitivity        = "High"
          evaluation_total_count   = 2
          evaluation_failure_count = 2
          dimension                = []
        }
      ]
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
          alert_sensitivity        = "High"
          evaluation_total_count   = 2
          evaluation_failure_count = 2
          dimension                = []
        }
      ]
    }

  }

  tags = var.tags
}
