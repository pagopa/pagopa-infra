data "azurerm_api_management" "apim" {
  name                = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}
