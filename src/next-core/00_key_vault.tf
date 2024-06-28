data "azurerm_key_vault" "kv_core" {
  name                = "${local.product}-kv"
  resource_group_name = "${local.product}-sec-rg"
}


module "domain_key_vault_secrets_query" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query?ref=v7.50.0"

  key_vault_name = data.azurerm_key_vault.kv_core.name
  resource_group = data.azurerm_key_vault.kv_core.resource_group_name

  secrets = [
    "alert-error-notification-email"
  ]
}



data "azurerm_key_vault_secret" "apim_publisher_email" {
  name         = "apim-publisher-email"
  key_vault_id = data.azurerm_key_vault.kv_core.id
}

data "azurerm_key_vault_certificate" "app_gw_platform" {
  name         = var.integration_app_gateway_api_certificate_name
  key_vault_id = data.azurerm_key_vault.kv_core.id
}

data "azurerm_key_vault_certificate" "portal_platform" {
  name         = var.integration_app_gateway_portal_certificate_name
  key_vault_id = data.azurerm_key_vault.kv_core.id
}

data "azurerm_key_vault_certificate" "management_platform" {
  name         = var.integration_app_gateway_management_certificate_name
  key_vault_id = data.azurerm_key_vault.kv_core.id
}


data "azurerm_key_vault_secret" "fn_checkout_key" {
  name         = "fn-checkout-key"
  key_vault_id = data.azurerm_key_vault.kv_core.id
}

data "azurerm_key_vault_secret" "google_recaptcha_secret" {
  name         = "google-recaptcha-secret"
  key_vault_id = data.azurerm_key_vault.kv_core.id
}

data "azurerm_key_vault_secret" "fn_buyerbanks_key" {
  name         = "fn-buyerbanks-key"
  key_vault_id = data.azurerm_key_vault.kv_core.id
}

data "azurerm_key_vault_secret" "pm_gtw_hostname" {
  name         = "pm-gtw-hostname"
  key_vault_id = data.azurerm_key_vault.kv_core.id
}

data "azurerm_key_vault_secret" "pm_onprem_hostname" {
  name         = "pm-onprem-hostname"
  key_vault_id = data.azurerm_key_vault.kv_core.id
}

data "azurerm_key_vault_secret" "pm_host" {
  name         = "pm-host"
  key_vault_id = data.azurerm_key_vault.kv_core.id
}

data "azurerm_key_vault_secret" "pm_host_prf" {
  name         = "pm-host-prf"
  key_vault_id = data.azurerm_key_vault.kv_core.id
}

data "azurerm_key_vault_certificate" "app_gw_platform_prf" {
  count = (var.dns_zone_prefix_prf == "") ? 0 : 1

  name         = var.app_gateway_prf_certificate_name
  key_vault_id = data.azurerm_key_vault.kv_core.id
}

data "azurerm_key_vault_secret" "certificate_crt_node_forwarder" {
  name         = "certificate-crt-node-forwarder"
  key_vault_id = data.azurerm_key_vault.kv_core.id
}
data "azurerm_key_vault_secret" "certificate_key_node_forwarder" {
  name         = "certificate-key-node-forwarder"
  key_vault_id = data.azurerm_key_vault.kv_core.id
}
