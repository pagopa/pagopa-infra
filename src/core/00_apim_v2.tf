data "azurerm_api_management" "apim_v2" {
  count               = var.enabled_features.apim_v2 ? 1 : 0
  name                = local.pagopa_apim_v2_name
  resource_group_name = local.pagopa_apim_v2_rg
}


data "azurerm_api_management" "apim_migrated" {
  count               = var.enabled_features.apim_migrated ? 1 : 0
  name                = local.pagopa_apim_migrated_name
  resource_group_name = local.pagopa_apim_migrated_rg
}