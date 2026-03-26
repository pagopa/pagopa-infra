
resource "azurerm_api_management_named_value" "pagopa_fn_checkout_url_value" {
  count               = var.checkout_enabled ? 1 : 0
  name                = "pagopa-fn-checkout-url"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "pagopa-fn-checkout-url"
  value               = format("https://pagopa-%s-fn-checkout.azurewebsites.net", var.env_short)
}

resource "azurerm_api_management_named_value" "brokerlist_value" {
  name                = "brokerlist"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "brokerlist"
  value               = var.nodo_pagamenti_psp
}

resource "azurerm_api_management_named_value" "ecblacklist_value" {
  name                = "ecblacklist"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "ecblacklist"
  value               = var.nodo_pagamenti_ec
}

# don't use it in policy -> schema_ip_nexi
resource "azurerm_api_management_named_value" "aks_lb_nexi" {
  name                = "aks-lb-nexi"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "aks-lb-nexi"
  value               = var.lb_aks
}

resource "azurerm_api_management_named_value" "base_path_nodo_oncloud" {
  name                = "base-path-nodo-oncloud"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "base-path-nodo-oncloud"
  value               = var.base_path_nodo_oncloud
}

# 7. schema://IP Nexi
# it replaces http://{{aks-lb-nexi}}, https://{{ip-nodo}}
resource "azurerm_api_management_named_value" "schema_ip_nexi" {
  name                = "schema-ip-nexi"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "schema-ip-nexi"
  value               = var.schema_ip_nexi
}


# DEFAULT NODO CONFIGURATION
resource "azurerm_api_management_named_value" "default_nodo_backend" {
  name                = "default-nodo-backend"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "default-nodo-backend"
  # in PROD Nodo have not the context-path
  value = azurerm_api_management_named_value.schema_ip_nexi.value
}

resource "azurerm_api_management_named_value" "default_nodo_backend_prf" {
  name                = "default-nodo-backend-prf"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "default-nodo-backend-prf"
  value               = var.env_short == "u" ? "${azurerm_api_management_named_value.schema_ip_nexi.value}" : "http://fake.address"
  # /webservices/input is set in API policy
}

resource "azurerm_api_management_named_value" "default_nodo_backend_dev_nexi" {
  name                = "default-nodo-backend-dev-nexi"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "default-nodo-backend-dev-nexi"
  value               = var.env_short == "d" ? "http://10.70.66.200/nodo-dev" : "http://fake.address"
  # /webservices/input is set in API policy
}

resource "azurerm_api_management_named_value" "default_nodo_id" {
  name                = "default-nodo-id"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "default-nodo-id"
  value               = var.default_node_id
}

resource "azurerm_api_management_named_value" "enable_nm3_decoupler_switch" {
  name                = "enable-nm3-decoupler-switch"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "enable-nm3-decoupler-switch"
  value               = var.apim_enable_nm3_decoupler_switch
}

resource "azurerm_api_management_named_value" "enable_routing_decoupler_switch" {
  name                = "enable-routing-decoupler-switch"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "enable-routing-decoupler-switch"
  value               = var.apim_enable_routing_decoupler_switch
}

# 1. PPT LMI
resource "azurerm_api_management_named_value" "base_path_nodo_ppt_lmi" {
  name                = "base-path-ppt-lmi"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "base-path-ppt-lmi"
  value               = var.base_path_nodo_ppt_lmi
}
resource "azurerm_api_management_named_value" "base_path_nodo_ppt_lmi_dev" {
  name                = "base-path-ppt-lmi-dev"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "base-path-ppt-lmi-dev"
  value               = var.base_path_nodo_ppt_lmi_dev
}

# 2. SYNC
resource "azurerm_api_management_named_value" "base_path_nodo_sync" {
  name                = "base-path-sync"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "base-path-sync"
  value               = var.base_path_nodo_sync
}
resource "azurerm_api_management_named_value" "base_path_nodo_sync_dev" {
  name                = "base-path-sync-dev"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "base-path-sync-dev"
  value               = var.base_path_nodo_sync_dev
}

# 3. WFESP
resource "azurerm_api_management_named_value" "base_path_nodo_wfesp" {
  name                = "base-path-wfesp"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "base-path-wfesp"
  value               = var.base_path_nodo_wfesp
}
resource "azurerm_api_management_named_value" "base_path_nodo_wfesp_dev" {
  name                = "base-path-wfesp-dev"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "base-path-wfesp-dev"
  value               = var.base_path_nodo_wfesp_dev
}

# 4. Fatturazione
resource "azurerm_api_management_named_value" "base_path_nodo_fatturazione" {
  name                = "base-path-fatturazione"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "base-path-fatturazione"
  value               = var.base_path_nodo_fatturazione
}
resource "azurerm_api_management_named_value" "base_path_nodo_fatturazione_dev" {
  name                = "base-path-fatturazione-dev"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "base-path-fatturazione-dev"
  value               = var.base_path_nodo_fatturazione_dev
}

# 5. Web-BO
resource "azurerm_api_management_named_value" "base_path_nodo_web_bo" {
  name                = "base-path-web-bo"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "base-path-web-bo"
  value               = var.base_path_nodo_web_bo
}
resource "azurerm_api_management_named_value" "base_path_nodo_web_bo_dev" {
  name                = "base-path-web-bo-dev"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "base-path-web-bo-dev"
  value               = var.base_path_nodo_web_bo_dev
}

# 6. Web-BO History
resource "azurerm_api_management_named_value" "base_path_nodo_web_bo_history" {
  name                = "base-path-web-bo-history"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "base-path-web-bo-history"
  value               = var.base_path_nodo_web_bo_history
}
resource "azurerm_api_management_named_value" "base_path_nodo_web_bo_history_dev" {
  name                = "base-path-web-bo-history-dev"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "base-path-web-bo-history-dev"
  value               = var.base_path_nodo_web_bo_history_dev
}

resource "azurerm_api_management_named_value" "pagopa_fn_checkout_key" {
  count               = var.checkout_enabled ? 1 : 0
  name                = "pagopa-fn-checkout-key"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "pagopa-fn-checkout-key"
  value               = data.azurerm_key_vault_secret.fn_checkout_key.value
  secret              = true
}

resource "azurerm_api_management_named_value" "checkout_google_recaptcha_secret" {
  name                = "google-recaptcha-secret"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "google-recaptcha-secret"
  value               = data.azurerm_key_vault_secret.google_recaptcha_secret.value
  secret              = true
}

resource "azurerm_api_management_named_value" "pm_gtw_hostname" {
  name                = "pm-gtw-hostname"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "pm-gtw-hostname"
  value               = data.azurerm_key_vault_secret.pm_gtw_hostname.value
  secret              = true
}

resource "azurerm_api_management_named_value" "pm_onprem_hostname" {
  name                = "pm-onprem-hostname"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "pm-onprem-hostname"
  value               = data.azurerm_key_vault_secret.pm_onprem_hostname.value
  secret              = true
}

resource "azurerm_api_management_named_value" "pm_host" {
  name                = "pm-host"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "pm-host"
  value               = data.azurerm_key_vault_secret.pm_host.value
  secret              = true
}

resource "azurerm_api_management_named_value" "pm_host_prf" {
  name                = "pm-host-prf"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "pm-host-prf"
  value               = data.azurerm_key_vault_secret.pm_host_prf.value
  secret              = true
}

resource "azurerm_api_management_named_value" "wisp2_gov_it" {
  name                = "wisp2-gov-it"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "wisp2-gov-it"
  value               = "${var.dns_zone_wisp2}.pagopa.gov.it"
}

resource "azurerm_api_management_named_value" "wisp2_it" {
  name                = "wisp2-it"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "wisp2-it"
  value               = "${var.dns_zone_wisp2}.${var.external_domain}"
}



data "azurerm_key_vault_secret" "mock_services_api_key" {
  count        = var.env_short == "d" ? 1 : 0
  name         = "mock-services-api-key"
  key_vault_id = module.key_vault.id
}

resource "azurerm_api_management_named_value" "pagopa_mock_services_api_key" {
  count               = var.env_short == "d" ? 1 : 0
  name                = "pagopa-mock-services-api-key"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "pagopa-mock-services-api-key"
  value               = data.azurerm_key_vault_secret.mock_services_api_key[0].value
  secret              = true
}

data "azurerm_key_vault_secret" "user_pm_test_key" {
  count        = var.env_short == "d" ? 1 : 0
  name         = "user-pm-test"
  key_vault_id = module.key_vault.id
}

resource "azurerm_api_management_named_value" "user_pm_test" {
  count               = var.env_short == "d" ? 1 : 0
  name                = "user-pm-test"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "user-pm-test"
  value               = data.azurerm_key_vault_secret.user_pm_test_key[0].value
  secret              = true
}

data "azurerm_key_vault_secret" "password_pm_test_key" {
  count        = var.env_short == "d" ? 1 : 0
  name         = "password-pm-test"
  key_vault_id = module.key_vault.id
}

resource "azurerm_api_management_named_value" "password_pm_test" {
  count               = var.env_short == "d" ? 1 : 0
  name                = "password-pm-test"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "password-pm-test"
  value               = data.azurerm_key_vault_secret.password_pm_test_key[0].value
  secret              = true
}

data "azurerm_key_vault_secret" "checkout_v2_test_key_secret" {
  count        = var.env_short == "d" ? 1 : 0
  name         = "checkout-v2-testing-api-key"
  key_vault_id = module.key_vault.id
}

resource "azurerm_api_management_named_value" "checkout_v2_test_key" {
  count               = var.env_short == "d" ? 1 : 0
  name                = "checkout-v2-testing-api-key"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "checkout-v2-testing-api-key"
  value               = data.azurerm_key_vault_secret.checkout_v2_test_key_secret[0].value
  secret              = true
}

# verificatore keys for apiconfig ( ottimizzazione ecs )

data "azurerm_key_vault_secret" "verificatore_key_secret_apiconfig" {
  name         = "verificatore-api-key-apiconfig"
  key_vault_id = module.key_vault.id
}

resource "azurerm_api_management_named_value" "verificatore_api_key_apiconfig" {
  name                = "verificatore-api-key-apiconfig"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "verificatore-api-key-apiconfig"
  value               = data.azurerm_key_vault_secret.verificatore_key_secret_apiconfig.value
  secret              = true
}


# donazioni
resource "azurerm_api_management_named_value" "donazioni_config_name" {
  name                = "donazioni-ucraina"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "donazioni-ucraina"
  value               = file(format("./api/nodopagamenti_api/paForNode/v1/donationsCfg/%s/donazioni_ucraina.json", var.env_short == "d" ? "dev" : var.env_short == "u" ? "uat" : "prod"))
}

resource "azurerm_api_management_named_value" "donazioni_config_name_2" {
  name                = "donazioni-ucraina2"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "donazioni-ucraina2"
  value               = file(format("./api/nodopagamenti_api/paForNode/v1/donationsCfg/%s/donazioni_ucraina2.json", var.env_short == "d" ? "dev" : var.env_short == "u" ? "uat" : "prod"))
}


resource "azurerm_api_management_named_value" "apicfg_core_service_path" { // https://${url_aks}/pagopa-api-config-core-service/<o|p>/
  name                = "apicfg-core-service-path"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "apicfg-core-service-path"
  value               = var.apicfg_core_service_path_value
}
resource "azurerm_api_management_named_value" "apicfg_selfcare_integ_service_path" { // https://${hostname}/pagopa-api-config-selfcare-integration/<o|p>"
  name                = "apicfg-selfcare-integ-service-path"
  api_management_name = module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "apicfg-selfcare-integ-service-path"
  value               = var.apicfg_selfcare_integ_service_path_value
}
