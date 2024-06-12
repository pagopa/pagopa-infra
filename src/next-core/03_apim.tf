# APIM v2 subnet
module "apimv2_snet" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.50.0"
  name                 = "${local.project}-apimv2-snet"
  resource_group_name  = data.azurerm_resource_group.rg_vnet_integration.name
  virtual_network_name = data.azurerm_virtual_network.vnet_integration.name
  address_prefixes     = var.cidr_subnet_apim

  service_endpoints = ["Microsoft.Web"]
}


resource "azurerm_network_security_group" "apimv2_snet_nsg" {
  name                = "${local.project}-apimv2-snet-nsg"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg_vnet_integration.name
}

resource "azurerm_network_security_rule" "apimv2_snet_nsg_rules" {
  count = length(var.apim_v2_subnet_nsg_security_rules)

  network_security_group_name = azurerm_network_security_group.apimv2_snet_nsg.name
  name                        = var.apim_v2_subnet_nsg_security_rules[count.index].name
  resource_group_name         = data.azurerm_resource_group.rg_vnet_integration.name
  priority                    = var.apim_v2_subnet_nsg_security_rules[count.index].priority
  direction                   = var.apim_v2_subnet_nsg_security_rules[count.index].direction
  access                      = var.apim_v2_subnet_nsg_security_rules[count.index].access
  protocol                    = var.apim_v2_subnet_nsg_security_rules[count.index].protocol
  source_port_range           = var.apim_v2_subnet_nsg_security_rules[count.index].source_port_range
  destination_port_range      = var.apim_v2_subnet_nsg_security_rules[count.index].destination_port_range
  source_address_prefix       = var.apim_v2_subnet_nsg_security_rules[count.index].source_address_prefix
  destination_address_prefix  = var.apim_v2_subnet_nsg_security_rules[count.index].destination_address_prefix
}

resource "azurerm_subnet_network_security_group_association" "apim_stv2_snet" {
  subnet_id                 = module.apimv2_snet.id
  network_security_group_id = azurerm_network_security_group.apimv2_snet_nsg.id
}


resource "azurerm_public_ip" "apimv2_public_ip" {
  name                = "${local.product}-apim-pip"
  resource_group_name = data.azurerm_resource_group.rg_vnet_integration.name
  location            = data.azurerm_resource_group.rg_vnet_integration.location
  sku                 = "Standard"
  domain_name_label   = "apim-${var.env_short}-pagopa"
  allocation_method   = "Static"

  zones = var.apim_v2_zones

  tags = var.tags
}

locals {
  apim_cert_name_proxy_endpoint   = format("%s-proxy-endpoint-cert", local.project)
  portal_cert_name_proxy_endpoint = format("%s-proxy-endpoint-cert", "portal")

  api_domain        = format("api.%s.%s", var.dns_zone_prefix, var.external_domain)
  prf_domain        = format("api.%s.%s", var.dns_zone_prefix_prf, var.external_domain)
  portal_domain     = format("portal.%s.%s", var.dns_zone_prefix, var.external_domain)
  management_domain = format("management.%s.%s", var.dns_zone_prefix, var.external_domain)

  redis_connection_string = var.create_redis_multiaz ? module.redis[0].primary_connection_string : data.azurerm_redis_cache.redis.primary_connection_string
  redis_cache_id          = var.create_redis_multiaz ? module.redis[0].id : data.azurerm_redis_cache.redis.id
}

module "apimv2" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management?ref=v7.67.1"
  depends_on          = [azurerm_subnet_network_security_group_association.apim_stv2_snet]
  subnet_id           = module.apimv2_snet.id
  location            = data.azurerm_resource_group.rg_api.location
  name                = "${local.project}-apim-v2"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  publisher_name      = var.apim_v2_publisher_name
  publisher_email     = data.azurerm_key_vault_secret.apim_publisher_email.value
  sku_name            = var.apim_v2_sku

  public_ip_address_id = azurerm_public_ip.apimv2_public_ip.id

  virtual_network_type = "Internal"

  redis_cache_enabled     = var.redis_cache_enabled
  redis_connection_string = var.redis_cache_enabled ? local.redis_connection_string : null
  redis_cache_id          = var.redis_cache_enabled ? local.redis_cache_id : null

  application_insights = {
    enabled             = true
    instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key
  }
  zones = startswith(var.apim_v2_sku, "Premium") ? var.apim_v2_zones : null



  # This enables the Username and Password Identity Provider
  sign_up_enabled = false

  lock_enable = false

  # sign_up_terms_of_service = {
  #   consent_required = false
  #   enabled          = false
  #   text             = ""
  # }


  xml_content = templatefile("./api/base_policy.tpl", {
    portal-domain         = local.portal_domain
    management-api-domain = local.management_domain
    apim-name             = "${local.project}-apim-v2"
    old-apim-name         = "${local.product}-apim"
  })

  autoscale = var.apim_v2_autoscale

  alerts_enabled = var.apim_v2_alerts_enabled

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
  # https://docs.microsoft.com/en-us/azure/azure-monitor/essentials/metrics-supported#microsoftapimanagementservice
  metric_alerts = {
    capacity = {
      description   = "Apim used capacity is too high"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 1
      auto_mitigate = true

      criteria = [{
        metric_namespace       = "Microsoft.ApiManagement/service"
        metric_name            = "Capacity"
        aggregation            = "Average"
        operator               = "GreaterThan"
        threshold              = 50
        skip_metric_validation = false
        dimension              = []
      }]
      dynamic_criteria = []
    }

    duration = {
      description   = "Apim abnormal response time"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 2
      auto_mitigate = true

      criteria = []

      dynamic_criteria = [{
        metric_namespace         = "Microsoft.ApiManagement/service"
        metric_name              = "Duration"
        aggregation              = "Average"
        operator                 = "GreaterThan"
        alert_sensitivity        = "High"
        evaluation_total_count   = 2
        evaluation_failure_count = 2
        skip_metric_validation   = false
        ignore_data_before       = "2021-01-01T00:00:00Z" # sample data
        dimension                = []
      }]
    }

    requests_failed = {
      description   = "Apim abnormal failed requests"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 2
      auto_mitigate = true

      criteria = []

      dynamic_criteria = [{
        metric_namespace         = "Microsoft.ApiManagement/service"
        metric_name              = "Requests"
        aggregation              = "Total"
        operator                 = "GreaterThan"
        alert_sensitivity        = "High"
        evaluation_total_count   = 2
        evaluation_failure_count = 2
        skip_metric_validation   = false
        ignore_data_before       = "2021-01-01T00:00:00Z" # sample data
        dimension = [{
          name     = "BackendResponseCode"
          operator = "Include"
          values   = ["5xx"]
        }]
      }]
    }
  }

  tags = var.tags

  #  depends_on = [
  #    azurerm_application_insights.application_insights
  #  ]
}

# ## api management policy ##
resource "azurerm_key_vault_access_policy" "api_management_policy" {
  key_vault_id = data.azurerm_key_vault.kv_core.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.apimv2.principal_id

  key_permissions         = []
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}


resource "azurerm_api_management_group" "readonly" {
  name                = "read-only"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = module.apimv2.name
  display_name        = "Read Only"
}

resource "azurerm_api_management_group" "checkout_rate_no_limit" {
  name                = "checkout-rate-no-limit"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = module.apimv2.name
  display_name        = "Checkout rate no limit"
}

resource "azurerm_api_management_group" "checkout_rate_limit_300" {
  name                = "checkout-rate-limit-300"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = module.apimv2.name
  display_name        = "Checkout rate limit 300"
}

resource "azurerm_api_management_group" "client_io" {
  name                = "client-io"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = module.apimv2.name
  display_name        = "Client IO"
}

resource "azurerm_api_management_group" "centro_stella" {
  name                = "centro-stella"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = module.apimv2.name
  display_name        = "Centro Stella"
}

resource "azurerm_api_management_group" "piattaforma_notifiche" {
  name                = "piattaforma-notifiche"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = module.apimv2.name
  display_name        = "Piattaforma notifiche"
}

resource "azurerm_api_management_group" "payment_manager" {
  name                = "payment-manager"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = module.apimv2.name
  display_name        = "Payment Manager"
}

resource "azurerm_api_management_group" "ecommerce" {
  name                = "ecommerce"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = module.apimv2.name
  display_name        = "Ecommerce pagoPA"
}

resource "azurerm_api_management_group" "pda" {
  name                = "client-pda"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = module.apimv2.name
  display_name        = "Client PDA"
}
resource "azurerm_api_management_group" "gps_grp" {
  name                = "gps-spontaneous-payments"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = module.apimv2.name
  display_name        = "GPS Spontaneous Payments for ECs"
}
resource "azurerm_api_management_group" "afm_calculator" {
  name                = "afm-calculator"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = module.apimv2.name
  display_name        = "AFM Calculator for Node"
}

#################
## NAMED VALUE ##
#################

resource "azurerm_api_management_named_value" "pagopa_fn_checkout_url_value" {
  count               = var.checkout_enabled ? 1 : 0
  name                = "pagopa-fn-checkout-url"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "pagopa-fn-checkout-url"
  value               = format("https://pagopa-%s-fn-checkout.azurewebsites.net", var.env_short)
}

resource "azurerm_api_management_named_value" "brokerlist_value" {
  name                = "brokerlist"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "brokerlist"
  value               = var.nodo_pagamenti_psp
}

resource "azurerm_api_management_named_value" "ecblacklist_value" {
  name                = "ecblacklist"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "ecblacklist"
  value               = var.nodo_pagamenti_ec
}

# don't use it in policy -> schema_ip_nexi
resource "azurerm_api_management_named_value" "urlnodo_value" {
  name                = "urlnodo"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "urlnodo"
  value               = var.nodo_pagamenti_url
}

# don't use it in policy -> schema_ip_nexi
resource "azurerm_api_management_named_value" "ip_nodo_value" { # TEMP used only for onPrem shall be replace with "aks_lb_nexi"
  name                = "ip-nodo"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "ip-nodo"
  value               = var.ip_nodo
}

# don't use it in policy -> schema_ip_nexi
resource "azurerm_api_management_named_value" "aks_lb_nexi" {
  name                = "aks-lb-nexi"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "aks-lb-nexi"
  value               = var.lb_aks
}

resource "azurerm_api_management_named_value" "base_path_nodo_oncloud" {
  name                = "base-path-nodo-oncloud"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "base-path-nodo-oncloud"
  value               = var.base_path_nodo_oncloud
}

# 7. schema://IP Nexi
# it replaces http://{{aks-lb-nexi}}, https://{{ip-nodo}}
resource "azurerm_api_management_named_value" "schema_ip_nexi" {
  name                = "schema-ip-nexi"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "schema-ip-nexi"
  value               = var.schema_ip_nexi
}

# 8. Nodo PagoPA
resource "azurerm_api_management_named_value" "schema_ip_nodo_pagopa" {
  name                = "schema-ip-nodo-pagopa"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "schema-ip-nodo-pagopa"
  value               = var.env_short == "p" ? "https://weu${var.env}.nodo.internal.platform.pagopa.it/${local.soap_basepath_nodo_postgres_pagopa}" : "https://weu${var.env}.nodo.internal.${var.env}.platform.pagopa.it/${local.soap_basepath_nodo_postgres_pagopa}"
}

# DEFAULT NODO CONFIGURATION
resource "azurerm_api_management_named_value" "default_nodo_backend" {
  name                = "default-nodo-backend"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "default-nodo-backend"
  # in PROD Nodo have not the context-path
  value = var.env_short == "p" ? azurerm_api_management_named_value.schema_ip_nexi.value : "${azurerm_api_management_named_value.schema_ip_nexi.value}${azurerm_api_management_named_value.base_path_nodo_oncloud.value}"
}

resource "azurerm_api_management_named_value" "default_nodo_backend_prf" {
  name                = "default-nodo-backend-prf"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "default-nodo-backend-prf"
  value               = var.env_short == "u" ? "${azurerm_api_management_named_value.schema_ip_nexi.value}/nodo-prf" : "fake.address"
  # /webservices/input is set in API policy
}

resource "azurerm_api_management_named_value" "default_nodo_backend_dev_nexi" {
  name                = "default-nodo-backend-dev-nexi"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "default-nodo-backend-dev-nexi"
  value               = var.env_short == "d" ? "${azurerm_api_management_named_value.schema_ip_nexi.value}/nodo-dev" : "fake.address"
  # /webservices/input is set in API policy
}

resource "azurerm_api_management_named_value" "default_nodo_id" {
  name                = "default-nodo-id"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "default-nodo-id"
  value               = var.default_node_id
}

resource "azurerm_api_management_named_value" "enable_nm3_decoupler_switch" {
  name                = "enable-nm3-decoupler-switch"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "enable-nm3-decoupler-switch"
  value               = var.apim_enable_nm3_decoupler_switch
}

resource "azurerm_api_management_named_value" "enable_routing_decoupler_switch" {
  name                = "enable-routing-decoupler-switch"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "enable-routing-decoupler-switch"
  value               = var.apim_enable_routing_decoupler_switch
}

# 1. PPT LMI
resource "azurerm_api_management_named_value" "base_path_nodo_ppt_lmi" {
  name                = "base-path-ppt-lmi"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "base-path-ppt-lmi"
  value               = var.base_path_nodo_ppt_lmi
}
resource "azurerm_api_management_named_value" "base_path_nodo_ppt_lmi_dev" {
  name                = "base-path-ppt-lmi-dev"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "base-path-ppt-lmi-dev"
  value               = var.base_path_nodo_ppt_lmi_dev
}

# 2. SYNC
resource "azurerm_api_management_named_value" "base_path_nodo_sync" {
  name                = "base-path-sync"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "base-path-sync"
  value               = var.base_path_nodo_sync
}
resource "azurerm_api_management_named_value" "base_path_nodo_sync_dev" {
  name                = "base-path-sync-dev"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "base-path-sync-dev"
  value               = var.base_path_nodo_sync_dev
}

# 3. WFESP
resource "azurerm_api_management_named_value" "base_path_nodo_wfesp" {
  name                = "base-path-wfesp"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "base-path-wfesp"
  value               = var.base_path_nodo_wfesp
}
resource "azurerm_api_management_named_value" "base_path_nodo_wfesp_dev" {
  name                = "base-path-wfesp-dev"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "base-path-wfesp-dev"
  value               = var.base_path_nodo_wfesp_dev
}

# 4. Fatturazione
resource "azurerm_api_management_named_value" "base_path_nodo_fatturazione" {
  name                = "base-path-fatturazione"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "base-path-fatturazione"
  value               = var.base_path_nodo_fatturazione
}
resource "azurerm_api_management_named_value" "base_path_nodo_fatturazione_dev" {
  name                = "base-path-fatturazione-dev"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "base-path-fatturazione-dev"
  value               = var.base_path_nodo_fatturazione_dev
}

# 5. Web-BO
resource "azurerm_api_management_named_value" "base_path_nodo_web_bo" {
  name                = "base-path-web-bo"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "base-path-web-bo"
  value               = var.base_path_nodo_web_bo
}
resource "azurerm_api_management_named_value" "base_path_nodo_web_bo_dev" {
  name                = "base-path-web-bo-dev"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "base-path-web-bo-dev"
  value               = var.base_path_nodo_web_bo_dev
}

# 6. Web-BO History
resource "azurerm_api_management_named_value" "base_path_nodo_web_bo_history" {
  name                = "base-path-web-bo-history"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "base-path-web-bo-history"
  value               = var.base_path_nodo_web_bo_history
}
resource "azurerm_api_management_named_value" "base_path_nodo_web_bo_history_dev" {
  name                = "base-path-web-bo-history-dev"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "base-path-web-bo-history-dev"
  value               = var.base_path_nodo_web_bo_history_dev
}

resource "azurerm_api_management_named_value" "pagopa_fn_checkout_key" {
  count               = var.checkout_enabled ? 1 : 0
  name                = "pagopa-fn-checkout-key"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "pagopa-fn-checkout-key"
  value               = data.azurerm_key_vault_secret.fn_checkout_key.value
  secret              = true
}

resource "azurerm_api_management_named_value" "checkout_google_recaptcha_secret" {
  name                = "google-recaptcha-secret"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "google-recaptcha-secret"
  value               = data.azurerm_key_vault_secret.google_recaptcha_secret.value
  secret              = true
}

resource "azurerm_api_management_named_value" "pagopa_fn_buyerbanks_url_value" {
  name                = "pagopa-fn-buyerbanks-url"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "pagopa-fn-buyerbanks-url"
  value               = format("https://pagopa-%s-fn-buyerbanks.azurewebsites.net", var.env_short)
}


resource "azurerm_api_management_named_value" "pagopa_fn_buyerbanks_key" {
  name                = "pagopa-fn-buyerbanks-key"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "pagopa-fn-buyerbanks-key"
  value               = data.azurerm_key_vault_secret.fn_buyerbanks_key.value
  secret              = true
}

resource "azurerm_api_management_named_value" "pm_gtw_hostname" {
  name                = "pm-gtw-hostname"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "pm-gtw-hostname"
  value               = data.azurerm_key_vault_secret.pm_gtw_hostname.value
  secret              = true
}

resource "azurerm_api_management_named_value" "pm_onprem_hostname" {
  name                = "pm-onprem-hostname"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "pm-onprem-hostname"
  value               = data.azurerm_key_vault_secret.pm_onprem_hostname.value
  secret              = true
}

resource "azurerm_api_management_named_value" "pm_host" {
  name                = "pm-host"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "pm-host"
  value               = data.azurerm_key_vault_secret.pm_host.value
  secret              = true
}

resource "azurerm_api_management_named_value" "pm_host_prf" {
  name                = "pm-host-prf"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "pm-host-prf"
  value               = data.azurerm_key_vault_secret.pm_host_prf.value
  secret              = true
}

resource "azurerm_api_management_named_value" "wisp2_gov_it" {
  name                = "wisp2-gov-it"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "wisp2-gov-it"
  value               = "${var.dns_zone_wisp2}.pagopa.gov.it"
}

resource "azurerm_api_management_named_value" "wisp2_it" {
  name                = "wisp2-it"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "wisp2-it"
  value               = "${var.dns_zone_wisp2}.${var.external_domain}"
}

# fdr
resource "azurerm_api_management_named_value" "fdrsaname" {
  name                = "fdrsaname"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "fdrsaname"
  value               = data.azurerm_storage_account.fdr_flows_sa.name
}

resource "azurerm_api_management_named_value" "fdrcontainername" {
  name                = "fdrcontainername"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "fdrcontainername"
  value               = data.azurerm_storage_container.fdr_rend_flow.name
}

data "azurerm_key_vault_secret" "mock_services_api_key" {
  count        = var.env_short == "d" ? 1 : 0
  name         = "mock-services-api-key"
  key_vault_id = data.azurerm_key_vault.kv_core.id
}

resource "azurerm_api_management_named_value" "pagopa_mock_services_api_key" {
  count               = var.env_short == "d" ? 1 : 0
  name                = "pagopa-mock-services-api-key"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "pagopa-mock-services-api-key"
  value               = data.azurerm_key_vault_secret.mock_services_api_key[0].value
  secret              = true
}

data "azurerm_key_vault_secret" "user_pm_test_key" {
  count        = var.env_short == "d" ? 1 : 0
  name         = "user-pm-test"
  key_vault_id = data.azurerm_key_vault.kv_core.id
}

resource "azurerm_api_management_named_value" "user_pm_test" {
  count               = var.env_short == "d" ? 1 : 0
  name                = "user-pm-test"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "user-pm-test"
  value               = data.azurerm_key_vault_secret.user_pm_test_key[0].value
  secret              = true
}

data "azurerm_key_vault_secret" "password_pm_test_key" {
  count        = var.env_short == "d" ? 1 : 0
  name         = "password-pm-test"
  key_vault_id = data.azurerm_key_vault.kv_core.id
}

resource "azurerm_api_management_named_value" "password_pm_test" {
  count               = var.env_short == "d" ? 1 : 0
  name                = "password-pm-test"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "password-pm-test"
  value               = data.azurerm_key_vault_secret.password_pm_test_key[0].value
  secret              = true
}

data "azurerm_key_vault_secret" "checkout_v2_test_key_secret" {
  count        = var.env_short == "d" ? 1 : 0
  name         = "checkout-v2-testing-api-key"
  key_vault_id = data.azurerm_key_vault.kv_core.id
}

resource "azurerm_api_management_named_value" "checkout_v2_test_key" {
  count               = var.env_short == "d" ? 1 : 0
  name                = "checkout-v2-testing-api-key"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "checkout-v2-testing-api-key"
  value               = data.azurerm_key_vault_secret.checkout_v2_test_key_secret[0].value
  secret              = true
}

# verificatore keys for apiconfig ( ottimizzazione ecs )

data "azurerm_key_vault_secret" "verificatore_key_secret_apiconfig" {
  name         = "verificatore-api-key-apiconfig"
  key_vault_id = data.azurerm_key_vault.kv_core.id
}

resource "azurerm_api_management_named_value" "verificatore_api_key_apiconfig" {
  name                = "verificatore-api-key-apiconfig"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "verificatore-api-key-apiconfig"
  value               = data.azurerm_key_vault_secret.verificatore_key_secret_apiconfig.value
  secret              = true
}


# donazioni
resource "azurerm_api_management_named_value" "donazioni_config_name" {
  name                = "donazioni-ucraina"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "donazioni-ucraina"
  value               = file(format("./api/nodopagamenti_api/paForNode/v1/donationsCfg/%s/donazioni_ucraina.json", var.env_short == "d" ? "dev" : var.env_short == "u" ? "uat" : "prod"))
}

resource "azurerm_api_management_named_value" "donazioni_config_name_2" {
  name                = "donazioni-ucraina2"
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "donazioni-ucraina2"
  value               = file(format("./api/nodopagamenti_api/paForNode/v1/donationsCfg/%s/donazioni_ucraina2.json", var.env_short == "d" ? "dev" : var.env_short == "u" ? "uat" : "prod"))
}

resource "azurerm_api_management_custom_domain" "api_custom_domain" {
  api_management_id = module.apimv2.id

  # old proxy block (provider v2.x) renamed to gateway (provider v3.x)
  gateway {
    host_name = local.api_domain
    key_vault_id = replace(
      data.azurerm_key_vault_certificate.app_gw_platform.secret_id,
      "/${data.azurerm_key_vault_certificate.app_gw_platform.version}",
      ""
    )
  }

  developer_portal {
    host_name = local.portal_domain
    key_vault_id = replace(
      data.azurerm_key_vault_certificate.portal_platform.secret_id,
      "/${data.azurerm_key_vault_certificate.portal_platform.version}",
      ""
    )
  }

  management {
    host_name = local.management_domain
    key_vault_id = replace(
      data.azurerm_key_vault_certificate.management_platform.secret_id,
      "/${data.azurerm_key_vault_certificate.management_platform.version}",
      ""
    )
  }

  dynamic "gateway" {
    for_each = var.env_short == "u" ? [""] : []
    content {
      host_name = local.prf_domain
      key_vault_id = replace(
        data.azurerm_key_vault_certificate.app_gw_platform_prf[0].secret_id,
        "/${data.azurerm_key_vault_certificate.app_gw_platform_prf[0].version}",
        ""
      )
    }
  }
}

#########
## API ##
#########

## monitor ##
module "monitor" {
  source              = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"
  name                = format("%s-monitor", var.env_short)
  api_management_name = module.apimv2.name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  description  = "Monitor"
  display_name = "Monitor"
  path         = ""
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/monitor/openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.gateway[0].host_name
  })

  xml_content = file("./api/base_policy.xml")

  subscription_required = false

  api_operation_policies = [
    {
      operation_id = "get"
      xml_content  = file("./api/monitor/mock_policy.xml")
    }
  ]
}


# Already apply forcing redis_connection_string on apim_module
resource "azurerm_api_management_redis_cache" "apimv2_external_cache_redis" {
  count             = var.create_redis_multiaz ? 1 : 0
  name              = "apim-v2-external-cache-redis"
  api_management_id = module.apimv2.id
  connection_string = module.redis[0].primary_connection_string
  description       = "APIM external cache Redis"
  redis_cache_id    = module.redis[0].id
  cache_location    = var.location
}


#############################
# apim v1 updated
#############################
data "azurerm_subnet" "apim_snet" {
  name                 = "${local.product}-apim-snet"
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = data.azurerm_virtual_network.vnet_integration.name
}


resource "azurerm_public_ip" "apim_pip" {
  name                = "${local.project}-apim-pip"
  resource_group_name = data.azurerm_resource_group.rg_vnet_integration.name
  location            = data.azurerm_resource_group.rg_vnet_integration.location
  sku                 = "Standard"
  domain_name_label   = "apim-${var.env_short}-pagopa-migrated"
  allocation_method   = "Static"

  zones = var.apim_v2_zones

  tags = var.tags
}


resource "azurerm_subnet_network_security_group_association" "apim_snet_sg_association" {
  count                     = var.is_feature_enabled.apim_core_import ? 1 : 0
  subnet_id                 = data.azurerm_subnet.apim_subnet.id
  network_security_group_id = azurerm_network_security_group.apimv2_snet_nsg.id
}

module "apim" {
  count               = var.is_feature_enabled.apim_core_import ? 1 : 0
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management?ref=v8.19.0"
  subnet_id           = data.azurerm_subnet.apim_subnet.id
  location            = data.azurerm_resource_group.rg_api.location
  name                = "${local.product}-apim"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  publisher_name      = var.apim_v2_publisher_name
  publisher_email     = data.azurerm_key_vault_secret.apim_publisher_email.value
  sku_name            = var.apim_v2_sku

  public_ip_address_id = azurerm_public_ip.apim_pip.id

  virtual_network_type = "Internal"

  redis_cache_enabled     = var.redis_cache_enabled
  redis_connection_string = var.redis_cache_enabled ? local.redis_connection_string : null
  redis_cache_id          = var.redis_cache_enabled ? local.redis_cache_id : null

  application_insights = {
    enabled             = true
    instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key
  }
  zones                                         = startswith(var.apim_v2_sku, "Premium") ? var.apim_v2_zones : null
  management_logger_applicaiton_insight_enabled = false


  # This enables the Username and Password Identity Provider
  sign_up_enabled = false

  lock_enable = false

  xml_content = templatefile("./api/base_policy.tpl", {
    portal-domain         = local.portal_domain
    management-api-domain = local.management_domain
    apim-name             = "${local.product}-apim"
    old-apim-name         = "${local.project}-apim-v2"
  })

  autoscale = var.apim_v2_autoscale

  alerts_enabled = var.apim_v2_alerts_enabled

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
  # https://docs.microsoft.com/en-us/azure/azure-monitor/essentials/metrics-supported#microsoftapimanagementservice
  metric_alerts = {
    capacity = {
      description   = "Apim used capacity is too high"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 1
      auto_mitigate = true

      criteria = [{
        metric_namespace       = "Microsoft.ApiManagement/service"
        metric_name            = "Capacity"
        aggregation            = "Average"
        operator               = "GreaterThan"
        threshold              = 50
        skip_metric_validation = false
        dimension              = []
      }]
      dynamic_criteria = []
    }

    duration = {
      description   = "Apim abnormal response time"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 2
      auto_mitigate = true

      criteria = []

      dynamic_criteria = [{
        metric_namespace         = "Microsoft.ApiManagement/service"
        metric_name              = "Duration"
        aggregation              = "Average"
        operator                 = "GreaterThan"
        alert_sensitivity        = "High"
        evaluation_total_count   = 2
        evaluation_failure_count = 2
        skip_metric_validation   = false
        ignore_data_before       = "2021-01-01T00:00:00Z" # sample data
        dimension                = []
      }]
    }

    requests_failed = {
      description   = "Apim abnormal failed requests"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 2
      auto_mitigate = true

      criteria = []

      dynamic_criteria = [{
        metric_namespace         = "Microsoft.ApiManagement/service"
        metric_name              = "Requests"
        aggregation              = "Total"
        operator                 = "GreaterThan"
        alert_sensitivity        = "High"
        evaluation_total_count   = 2
        evaluation_failure_count = 2
        skip_metric_validation   = false
        ignore_data_before       = "2021-01-01T00:00:00Z" # sample data
        dimension = [{
          name     = "BackendResponseCode"
          operator = "Include"
          values   = ["5xx"]
        }]
      }]
    }
  }

  tags = var.tags

}
