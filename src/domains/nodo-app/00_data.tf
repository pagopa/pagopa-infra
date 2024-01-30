data "azurerm_api_management_group" "group_developers" {
  name                = "developers"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

data "azurerm_api_management" "apim" {
  name                = "${local.product}-apim"
  resource_group_name = "${local.product}-api-rg"
}

data "azurerm_eventhub_namespace" "pagopa-evh-ns01" {
  resource_group_name = "${local.product}-msg-rg"
  name                = "${local.product}-evh-ns01"
}
