data "azurerm_api_management" "apim_v2" {
  name                = local.pagopa_apim_v2_name
  resource_group_name = local.pagopa_apim_v2_rg
}
