# apim
data "azurerm_api_management" "apim" {
  name                = "${local.product}-apim"
  resource_group_name = data.azurerm_resource_group.rg_api.name
}

data "azurerm_resource_group" "rg_api" {
  name = "${local.product}-api-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-weu-core-evh-ns03_fdr-re-fdr-re-tx" {
  name                = "fdr-re-tx"
  namespace_name      = "${local.product}-${local.evt_hub_location}-evh-ns03"
  eventhub_name       = "fdr-re"
  resource_group_name = "${local.product}-msg-rg"
}
