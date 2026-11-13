data "azurerm_api_management_api" "apim_nodo_technical_support_api_v1" {
  name                = "${local.project}-technical-support-api-v1"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  revision            = "1"
}

resource "azurerm_api_management_subscription" "nodo_technical_support_subkey" {
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  api_id        = replace(data.azurerm_api_management_api.apim_nodo_technical_support_api_v1.id, ";rev=1", "")
  display_name  = "Nodo Technical Support for Cloudo alerts"
  allow_tracing = false
  state         = "active"
}

# Used by ClouDO alerts
resource "azurerm_key_vault_secret" "nodo_technical_support_subkey_secret" {
  name         = "nodo-technical-support-subkey"
  value        = azurerm_api_management_subscription.nodo_technical_support_subkey.primary_key
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}
