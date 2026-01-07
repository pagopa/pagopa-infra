resource "azurerm_api_management_subscription" "iuv_generator_subkey" {
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = data.azurerm_api_management_product.apim_iuv_generator_product.id
  display_name        = "Subscription Spontaneous Payments for IUV Generator"
  allow_tracing       = false
  state               = "active"
}

resource "azurerm_api_management_subscription" "gps_spontaneous_payments_services_subkey" {
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = data.azurerm_api_management_product.apim_gps_spontaneous_payments_services_product.id
  display_name        = "Subscription Spontaneous Payments for Services"
  allow_tracing       = false
  state               = "active"
}

#### QA subkey for integration testing
resource "azurerm_api_management_subscription" "gpd_integration_qa_subkey" {
  count = var.env_short != "p" ? 1 : 0

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = data.azurerm_api_management_product.apim_gpd_integration_product.id
  display_name        = "QA-GPD"
  allow_tracing       = false
  state               = "active"
  user_id             = data.azurerm_api_management_user.apim_qa_user[0].id
}

# FDR1-FDR3 Integration
resource "azurerm_api_management_subscription" "fdr3_flow_subkey" {
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = data.azurerm_api_management_product.apim_fdr_orgs.id
  display_name        = "FDR3 for GPD Reporting"
  allow_tracing       = false
  state               = "active"
}

resource "azurerm_api_management_subscription" "fdr1_flow_subkey" {
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = data.azurerm_api_management_product.apim_fdr_internal.id
  display_name        = "FDR1 for GPD Reporting"
  allow_tracing       = false
  state               = "active"
}
resource "azurerm_api_management_subscription" "gpd_for_reporting_subkey" {
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = data.azurerm_api_management_product.apim_gpd_integration_product.id
  display_name        = "GPD for GPD Reporting"
  allow_tracing       = false
  state               = "active"
}

resource "azurerm_key_vault_secret" "gpd_for_reporting_subkey_secret" {
  name         = "gpd-subkey-for-reporting"
  value        = azurerm_api_management_subscription.gpd_for_reporting_subkey.primary_key
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.gps_kv.id
}

