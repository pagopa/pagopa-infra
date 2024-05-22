data "azurerm_eventhub_authorization_rule" "pagopa-weu-core-evh-ns04_fdr-qi-flows-tx" {
  name                = "fdr-qi-flows-tx"
  namespace_name      = "${local.product}-${local.evt_hub_location}-evh-ns04"
  eventhub_name       = "fdr-qi-flows"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-weu-core-evh-ns04_fdr-qi-flows-rx" {
  name                = "fdr-qi-flows-rx"
  namespace_name      = "${local.product}-${local.evt_hub_location}-evh-ns04"
  eventhub_name       = "fdr-qi-flows"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-weu-core-evh-ns04_fdr-qi-reported-iuv-tx" {
  name                = "fdr-qi-reported-iuv-tx"
  namespace_name      = "${local.product}-${local.evt_hub_location}-evh-ns04"
  eventhub_name       = "fdr-qi-reported-iuv"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-weu-core-evh-ns04_fdr-qi-reported-iuv-rx" {
  name                = "fdr-qi-reported-iuv-rx"
  namespace_name      = "${local.product}-${local.evt_hub_location}-evh-ns04"
  eventhub_name       = "fdr-qi-reported-iuv"
  resource_group_name = "${local.product}-msg-rg"
}