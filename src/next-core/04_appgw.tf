
locals {

  # 1.listeners
  public_listeners = {
    api = {
      protocol           = "Https"
      host               = format("api.%s.%s", var.dns_zone_prefix, var.external_domain)
      port               = 443
      ssl_profile_name   = format("%s-ssl-profile", local.product)
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
      ssl_profile_name   = format("%s-ssl-profile", local.product)
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
      ssl_profile_name   = format("%s-ssl-profile", local.product)
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

    wisp2 = {
      protocol           = "Https"
      host               = format("%s.%s", var.dns_zone_wisp2, var.external_domain)
      port               = 443
      ssl_profile_name   = format("%s-ssl-profile", local.product)
      firewall_policy_id = null

      certificate = {
        name = var.app_gateway_wisp2_certificate_name
        id = replace(
          data.azurerm_key_vault_certificate.wisp2.secret_id,
          "/${data.azurerm_key_vault_certificate.wisp2.version}",
          ""
        )
      }
    }


  }
  public_listeners_apiprf = {
    apiprf = {
      protocol           = "Https"
      host               = format("api.%s.%s", var.dns_zone_prefix_prf, var.external_domain)
      port               = 443
      ssl_profile_name   = format("%s-ssl-profile", local.product)
      firewall_policy_id = null
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

  public_listeners_wisp2govit = {
    wisp2govit = {
      protocol           = "Https"
      host               = format("%s.%s", var.dns_zone_wisp2, "pagopa.gov.it")
      port               = 443
      ssl_profile_name   = format("%s-ssl-profile", local.product)
      firewall_policy_id = null
      certificate = {
        name = var.app_gateway_wisp2govit_certificate_name
        id = var.app_gateway_wisp2govit_certificate_name == "" ? null : replace(
          data.azurerm_key_vault_certificate.wisp2govit[0].secret_id,
          "/${data.azurerm_key_vault_certificate.wisp2govit[0].version}",
          ""
        )
      }
    }
  }

  public_listeners_wfespgovit = {
    wfespgovit = {
      protocol           = "Https"
      host               = format("%s.%s", var.dns_zone_wfesp, "pagopa.gov.it")
      port               = 443
      ssl_profile_name   = format("%s-ssl-profile", local.product)
      firewall_policy_id = null
      certificate = {
        name = var.app_gateway_wfespgovit_certificate_name
        id = var.app_gateway_wfespgovit_certificate_name == "" ? null : replace(
          data.azurerm_key_vault_certificate.wfespgovit[0].secret_id,
          "/${data.azurerm_key_vault_certificate.wfespgovit[0].version}",
          ""
        )
      }
    }
  }

  public_listeners_apiupload = {
    upload = {
      protocol           = "Https"
      host               = format("upload.%s.%s", var.dns_zone_prefix, var.external_domain)
      port               = 443
      ssl_profile_name   = format("%s-ssl-profile", local.product)
      firewall_policy_id = null

      certificate = {
        name = var.app_gateway_upload_certificate_name
        id = replace(
          data.azurerm_key_vault_certificate.app_gw_platform_upload.secret_id,
          "/${data.azurerm_key_vault_certificate.app_gw_platform_upload.version}",
          ""
        )
      }
    }
  }

  # 2.routes

  public_routes = {
    api = {
      listener              = "api"
      backend               = "apim"
      rewrite_rule_set_name = "rewrite-rule-set-api"
      priority              = 30
    }

    portal = {
      listener              = "portal"
      backend               = "portal"
      rewrite_rule_set_name = null
      priority              = 50
    }

    mangement = {
      listener              = "management"
      backend               = "management"
      rewrite_rule_set_name = null
      priority              = 80
    }

    wisp2 = {
      listener              = "wisp2"
      backend               = "apim"
      rewrite_rule_set_name = "rewrite-rule-set-api"
      priority              = 60
    }


  }

  public_routes_apiprf = {
    apiprf = {
      listener              = "apiprf"
      backend               = "apim"
      rewrite_rule_set_name = "rewrite-rule-set-api"
      priority              = 90
    }
  }

  public_routes_wisp2govit = {
    wisp2govit = {
      listener              = "wisp2govit"
      backend               = "apim"
      rewrite_rule_set_name = "rewrite-rule-set-api"
      priority              = 20
    }
  }

  public_routes_wfespgovit = {
    wfespgovit = {
      listener              = "wfespgovit"
      backend               = "apim"
      rewrite_rule_set_name = "rewrite-rule-set-api"
      priority              = 70
    }
  }

  public_routes_apiupload = {
    upload = {
      listener              = "upload"
      backend               = "apimupload"
      rewrite_rule_set_name = "rewrite-rule-set-api"
      priority              = 10
    }
  }

  # 3.backends

  public_backends = {
    apim = {
      protocol                    = "Https"
      host                        = trim(azurerm_dns_a_record.dns_a_api.fqdn, ".")
      port                        = 443
      ip_addresses                = module.apim[0].private_ip_addresses
      fqdns                       = [azurerm_dns_a_record.dns_a_api.fqdn]
      probe                       = "/status-0123456789abcdef"
      probe_name                  = "probe-apim"
      request_timeout             = 120
      pick_host_name_from_backend = false
    }

    portal = {
      protocol                    = "Https"
      host                        = trim(azurerm_dns_a_record.dns_a_portal.fqdn, ".")
      port                        = 443
      ip_addresses                = module.apim[0].private_ip_addresses
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
      ip_addresses = module.apim[0].private_ip_addresses
      fqdns        = [azurerm_dns_a_record.dns_a_management.fqdn]

      probe                       = "/ServiceStatus"
      probe_name                  = "probe-management"
      request_timeout             = 8
      pick_host_name_from_backend = false
    }


  }

  public_backends_upload = {
    apimupload = {
      protocol                    = "Https"
      host                        = trim(var.upload_endpoint_enabled ? azurerm_dns_a_record.dns_a_api.fqdn : "", ".")
      port                        = 443
      ip_addresses                = module.apim[0].private_ip_addresses
      fqdns                       = var.upload_endpoint_enabled ? [azurerm_dns_a_record.dns_a_api.fqdn] : []
      probe                       = "/status-0123456789abcdef"
      probe_name                  = "probe-apimupload"
      request_timeout             = 300 # long timeout for heavy api request ( ex. FDR flow managment, GPD upload, ... )
      pick_host_name_from_backend = false
    }
  }

  ## rewrite rule sets

  rewrite_rule_set = [
    {
      name = "rewrite-rule-set-api"
      rewrite_rules = [
        {
          name          = "http-deny-path"
          rule_sequence = 1
          conditions = [{
            variable    = "var_uri_path"
            pattern     = join("|", var.app_gateway_deny_paths)
            ignore_case = true
            negate      = false
          }]
          request_header_configurations  = []
          response_header_configurations = []
          url = {
            path         = "notfound"
            query_string = null
          }
        },
        {
          name          = "http-deny-path2"
          rule_sequence = 2
          conditions = [{
            variable    = "var_uri_path"
            pattern     = join("|", var.app_gateway_deny_paths_2)
            ignore_case = true
            negate      = false
          }]
          request_header_configurations  = []
          response_header_configurations = []
          url = {
            path         = "notfound"
            query_string = null
          }
        },
        {
          name          = "http-allow-pagopa-onprem-only"
          rule_sequence = 3
          conditions = [{
            variable    = "var_uri_path"
            pattern     = join("|", var.app_gateway_allowed_paths_pagopa_onprem_only.paths)
            ignore_case = true
            negate      = false
            },
            {
              variable    = "var_client_ip"
              pattern     = join("|", var.app_gateway_allowed_paths_pagopa_onprem_only.ips)
              ignore_case = true
              negate      = true
          }]
          request_header_configurations  = []
          response_header_configurations = []
          url = {
            path         = "notfound"
            query_string = null
          }
        },
        {
          name          = "http-headers-api"
          rule_sequence = 100
          conditions    = []
          request_header_configurations = [
            {
              header_name  = "X-Forwarded-For"
              header_value = "{var_client_ip}"
            },
            {
              header_name  = "X-Client-Ip"
              header_value = "{var_client_ip}"
            },
            {
              header_name  = "X-Orginal-Host-For"
              header_value = "{var_host}"
            },
            {
              header_name  = "X-Environment"
              header_value = lower(module.tag_config.tags["Environment"])
            },
          ]
          response_header_configurations = []
          url                            = null
        },
        {
          name          = "http-deny-path-only-to-upload-allowed-path"
          rule_sequence = 4
          conditions = [
            {
              variable    = "var_host"
              pattern     = format("upload.%s.%s", var.dns_zone_prefix, var.external_domain)
              ignore_case = true
              negate      = false
            },
            {
              variable    = "var_uri_path"
              pattern     = join("|", var.app_gateway_allowed_paths_upload)
              ignore_case = true
              negate      = true
            },
          ]
          request_header_configurations  = []
          response_header_configurations = []
          url = {
            path         = "notfound"
            query_string = null
          }
        },
        {
          name          = "http-deny-path-only-upload-soap-fdr"
          rule_sequence = 4
          conditions = [
            {
              variable    = "var_host"
              pattern     = format("upload.%s.%s", var.dns_zone_prefix, var.external_domain)
              ignore_case = true
              negate      = false
            },
            {
              variable    = "http_req_Content-Type"
              pattern     = "application/xml"
              ignore_case = true
              negate      = false
            },
            {
              variable    = "http_req_SOAPAction"
              pattern     = join("|", var.app_gateway_allowed_fdr_soap_action)
              ignore_case = true
              negate      = true
            },
          ]
          request_header_configurations  = []
          response_header_configurations = []
          url = {
            path         = "notfound"
            query_string = null
          }
        },
      ]
    }
  ]
}

data "azurerm_user_assigned_identity" "public_appgateway" {
  resource_group_name = azurerm_resource_group.sec_rg.name
  name                = format("%s-appgateway-identity", local.product)

}

## Application gateway public ip ##
resource "azurerm_public_ip" "appgateway_public_ip" {
  name                = format("%s-appgateway-pip", local.product)
  resource_group_name = azurerm_resource_group.rg_vnet.name
  location            = azurerm_resource_group.rg_vnet.location
  sku                 = "Standard"
  allocation_method   = "Static"
  zones               = [1, 2, 3]

  tags = module.tag_config.tags
}

# Subnet to host the application gateway
module "appgateway_snet" {
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v8.8.0"
  name                                      = format("%s-appgateway-snet", local.product)
  address_prefixes                          = var.cidr_subnet_appgateway
  resource_group_name                       = azurerm_resource_group.rg_vnet.name
  virtual_network_name                      = module.vnet.name
  private_endpoint_network_policies_enabled = true
}

# Application gateway: Multilistener configuraiton
module "app_gw" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//app_gateway?ref=v8.8.0"

  resource_group_name = azurerm_resource_group.rg_vnet.name
  location            = azurerm_resource_group.rg_vnet.location
  name                = format("%s-app-gw", local.product)

  # SKU
  sku_name = var.app_gateway_sku_name
  sku_tier = var.app_gateway_sku_tier

  zones = var.env_short == "p" ? [1, 2, 3] : null

  # WAF
  waf_enabled = var.app_gateway_waf_enabled

  # Networking
  subnet_id    = module.appgateway_snet.id
  public_ip_id = azurerm_public_ip.appgateway_public_ip.id

  # Configure 3.backends
  backends = merge(
    local.public_backends,
    var.upload_endpoint_enabled ? local.public_backends_upload : {}
  )

  ssl_profiles = [{
    name                             = format("%s-ssl-profile", local.product)
    trusted_client_certificate_names = null
    verify_client_cert_issuer_dn     = false
    ssl_policy = {
      disabled_protocols = []
      policy_type        = "Custom"
      policy_name        = "" # with Custom type set empty policy_name (not required by the provider)
      cipher_suites = [
        "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256",
        "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384",
      ]
      min_protocol_version = "TLSv1_2"
    }
  }]

  trusted_client_certificates = []

  # Configure listeners
  listeners = merge(
    local.public_listeners,
    var.dns_zone_prefix_prf != "" ? local.public_listeners_apiprf : {},
    var.app_gateway_wisp2govit_certificate_name != "" ? local.public_listeners_wisp2govit : {},
    var.app_gateway_wfespgovit_certificate_name != "" ? local.public_listeners_wfespgovit : {},
    var.upload_endpoint_enabled ? local.public_listeners_apiupload : {},
  )

  # maps listener to backend
  routes = merge(
    local.public_routes,
    var.dns_zone_prefix_prf != "" ? local.public_routes_apiprf : {},
    var.app_gateway_wisp2govit_certificate_name != "" ? local.public_routes_wisp2govit : {},
    var.app_gateway_wfespgovit_certificate_name != "" ? local.public_routes_wfespgovit : {},
    var.upload_endpoint_enabled ? local.public_routes_apiupload : {},
  )

  rewrite_rule_sets = concat(
    local.rewrite_rule_set,
  )

  # TLS
  identity_ids = [data.azurerm_user_assigned_identity.public_appgateway.id]

  # Scaling
  app_gateway_min_capacity = var.app_gateway_min_capacity
  app_gateway_max_capacity = var.app_gateway_max_capacity

  alerts_enabled = var.app_gateway_alerts_enabled

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
          operator    = "GreaterThanOrEqual"
          threshold   = floor(var.app_gateway_max_capacity * 90 / 100)
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
      description   = "${module.app_gw.name} One or more backend pools are down, check Backend Health on Azure portal"
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
      description   = "${module.app_gw.name} Traffic is raising"
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
      description   = "${module.app_gw.name} Abnormal failed requests"
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
          alert_sensitivity        = "High"
          evaluation_total_count   = 4
          evaluation_failure_count = 4
          dimension                = []
        }
      ]
    }

  }

  tags = module.tag_config.tags
}
