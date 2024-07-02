
locals {

  # 1.listeners
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

    wisp2 = {
      protocol           = "Https"
      host               = format("%s.%s", var.dns_zone_wisp2, var.external_domain)
      port               = 443
      ssl_profile_name   = format("%s-ssl-profile", local.project)
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

    kibana = {
      protocol           = "Https"
      host               = format("kibana.%s.%s", var.dns_zone_prefix, var.external_domain)
      port               = 443
      ssl_profile_name   = format("%s-ssl-profile", local.project)
      firewall_policy_id = null

      certificate = {
        name = var.app_gateway_kibana_certificate_name
        id = replace(
          data.azurerm_key_vault_certificate.kibana.secret_id,
          "/${data.azurerm_key_vault_certificate.kibana.version}",
          ""
        )
      }
    }
  }
  listeners_apiprf = {
    apiprf = {
      protocol           = "Https"
      host               = format("api.%s.%s", var.dns_zone_prefix_prf, var.external_domain)
      port               = 443
      ssl_profile_name   = format("%s-ssl-profile", local.project)
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


  listeners_wisp2govit = {
    wisp2govit = {
      protocol           = "Https"
      host               = format("%s.%s", var.dns_zone_wisp2, "pagopa.gov.it")
      port               = 443
      ssl_profile_name   = format("%s-ssl-profile", local.project)
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

  listeners_wfespgovit = {
    wfespgovit = {
      protocol           = "Https"
      host               = format("%s.%s", var.dns_zone_wfesp, "pagopa.gov.it")
      port               = 443
      ssl_profile_name   = format("%s-ssl-profile", local.project)
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

  listeners_apiupload = {
    upload = {
      protocol           = "Https"
      host               = format("upload.%s.%s", var.dns_zone_prefix, var.external_domain)
      port               = 443
      ssl_profile_name   = format("%s-ssl-profile", local.project)
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

    wisp2 = {
      listener              = "wisp2"
      backend               = "apim"
      rewrite_rule_set_name = "rewrite-rule-set-api"
    }

    kibana = {
      listener              = "kibana"
      backend               = "kibana"
      rewrite_rule_set_name = "rewrite-rule-set-kibana"
    }
  }

  routes_apiprf = {
    apiprf = {
      listener              = "apiprf"
      backend               = "apim"
      rewrite_rule_set_name = "rewrite-rule-set-api"
    }
  }

  routes_wisp2govit = {
    wisp2govit = {
      listener              = "wisp2govit"
      backend               = "apim"
      rewrite_rule_set_name = "rewrite-rule-set-api"
    }
  }

  routes_wfespgovit = {
    wfespgovit = {
      listener              = "wfespgovit"
      backend               = "apim"
      rewrite_rule_set_name = "rewrite-rule-set-api"
    }
  }

  routes_apiupload = {
    upload = {
      listener              = "upload"
      backend               = "apimupload"
      rewrite_rule_set_name = "rewrite-rule-set-api"
    }
  }

  # 3.backends

  backends = {
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

    kibana = {
      protocol                    = "Https"
      host                        = var.env == "prod" ? "weu${var.env}.kibana.internal.platform.pagopa.it" : "weu${var.env}.kibana.internal.${var.env}.platform.pagopa.it"
      port                        = 443
      ip_addresses                = [var.ingress_elk_load_balancer_ip]
      fqdns                       = [var.env == "prod" ? "weu${var.env}.kibana.internal.platform.pagopa.it" : "weu${var.env}.kibana.internal.${var.env}.platform.pagopa.it"]
      probe                       = "/kibana"
      probe_name                  = "probe-kibana"
      request_timeout             = 10
      pick_host_name_from_backend = false
    }
  }

  backends_upload = {
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

}

## Application gateway public ip ##
resource "azurerm_public_ip" "appgateway_public_ip" {
  name                = format("%s-appgateway-pip", local.project)
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  location            = data.azurerm_resource_group.rg_vnet.location
  sku                 = "Standard"
  allocation_method   = "Static"

  tags = var.tags
}

# Subnet to host the application gateway
module "appgateway_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.90"
  name                 = format("%s-appgateway-snet", local.project)
  address_prefixes     = var.cidr_subnet_appgateway
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = data.azurerm_virtual_network.vnet_core.name
}

# Application gateway: Multilistener configuraiton
module "app_gw" {
  source = "git::https://github.com/pagopa/azurerm.git//app_gateway?ref=v2.20.0"

  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  location            = data.azurerm_resource_group.rg_vnet.location
  name                = format("%s-app-gw", local.project)

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
    local.backends,
    var.upload_endpoint_enabled ? local.backends_upload : {},
  )

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
      ]
      min_protocol_version = "TLSv1_2"
    }
  }]

  trusted_client_certificates = []

  # Configure listeners
  listeners = merge(
    local.listeners,
    var.dns_zone_prefix_prf != "" ? local.listeners_apiprf : {},
    var.app_gateway_wisp2govit_certificate_name != "" ? local.listeners_wisp2govit : {},
    var.app_gateway_wfespgovit_certificate_name != "" ? local.listeners_wfespgovit : {},
    var.upload_endpoint_enabled ? local.listeners_apiupload : {},
  )

  # maps listener to backend
  routes = merge(
    local.routes,
    var.dns_zone_prefix_prf != "" ? local.routes_apiprf : {},
    var.app_gateway_wisp2govit_certificate_name != "" ? local.routes_wisp2govit : {},
    var.app_gateway_wfespgovit_certificate_name != "" ? local.routes_wfespgovit : {},
    var.upload_endpoint_enabled ? local.routes_apiupload : {},
  )

  rewrite_rule_sets = [
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
              header_value = lower(var.tags["Environment"])
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
    },
    {
      name = "rewrite-rule-set-kibana"
      rewrite_rules = [
        {
          name          = "http-kibana-deny-path"
          rule_sequence = 1
          conditions = [{
            variable    = "var_uri_path"
            pattern     = join("|", var.app_gateway_kibana_deny_paths)
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
      ]
    },

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
