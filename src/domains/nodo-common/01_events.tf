
data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns01_nodo-dei-pagamenti-verify-ko-tx" {
  name                = "nodo-dei-pagamenti-verify-ko-tx"
  namespace_name      = "${local.product}-evh-ns01"
  eventhub_name       = "nodo-dei-pagamenti-verify-ko"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns01_nodo-dei-pagamenti-verify-ko-datastore-rx" {
  name                = "nodo-dei-pagamenti-verify-ko-datastore-rx"
  namespace_name      = "${local.product}-evh-ns01"
  eventhub_name       = "nodo-dei-pagamenti-verify-ko"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns01_nodo-dei-pagamenti-verify-ko-tablestorage-rx" {
  name                = "nodo-dei-pagamenti-verify-ko-tablestorage-rx"
  namespace_name      = "${local.product}-evh-ns01"
  eventhub_name       = "nodo-dei-pagamenti-verify-ko"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns03_nodo-dei-pagamenti-verify-ko-tx" {
  name                = "nodo-dei-pagamenti-verify-ko-tx"
  namespace_name      = "${local.product}-${var.location_short}-core-evh-ns03"
  eventhub_name       = "nodo-dei-pagamenti-verify-ko"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns03_nodo-dei-pagamenti-verify-ko-datastore-rx" {
  name                = "nodo-dei-pagamenti-verify-ko-datastore-rx"
  namespace_name      = "${local.product}-${var.location_short}-core-evh-ns03"
  eventhub_name       = "nodo-dei-pagamenti-verify-ko"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns03_nodo-dei-pagamenti-verify-ko-tablestorage-rx" {
  name                = "nodo-dei-pagamenti-verify-ko-tablestorage-rx"
  namespace_name      = "${local.product}-${var.location_short}-core-evh-ns03"
  eventhub_name       = "nodo-dei-pagamenti-verify-ko"
  resource_group_name = "${local.product}-msg-rg"
}

#data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns01_nodo-dei-pagamenti-verify-ko-test-rx" {
#  name                = "nodo-dei-pagamenti-verify-ko-test-rx"
#  namespace_name      = "${local.product}-evh-ns01"
#  eventhub_name       = "nodo-dei-pagamenti-verify-ko"
#  resource_group_name = "${local.product}-msg-rg"
#}

data "azurerm_eventhub_authorization_rule" "pagopa-weu-core-evh-ns04_nodo-dei-pagamenti-cache-sync-rx" {
  name                = "nodo-dei-pagamenti-cache-sync-rx"
  namespace_name      = "${local.product}-${local.evt_hub_location}-evh-ns04"
  eventhub_name       = "nodo-dei-pagamenti-cache"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-weu-core-evh-ns04_nodo-dei-pagamenti-stand-in-tx" {
  name                = "nodo-dei-pagamenti-stand-in-tx"
  namespace_name      = "${local.product}-${local.evt_hub_location}-evh-ns04"
  eventhub_name       = "nodo-dei-pagamenti-stand-in"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-weu-core-evh-ns04_nodo-dei-pagamenti-stand-in-sync-rx" {
  name                = "nodo-dei-pagamenti-stand-in-sync-rx"
  namespace_name      = "${local.product}-${local.evt_hub_location}-evh-ns04"
  eventhub_name       = "nodo-dei-pagamenti-stand-in"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-weu-core-evh-ns04_dismissione-wisp-paainviart-rx" {
  count               = var.enable_wisp_converter ? 1 : 0
  name                = "dismissione-wisp-paainviart-rx"
  namespace_name      = "${local.product}-${local.evt_hub_location}-evh-ns04"
  eventhub_name       = "dismissione-wisp-paainviart"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-weu-core-evh-ns04_dismissione-wisp-paainviart-tx" {
  count               = var.enable_wisp_converter ? 1 : 0
  name                = "dismissione-wisp-paainviart-tx"
  namespace_name      = "${local.product}-${local.evt_hub_location}-evh-ns04"
  eventhub_name       = "dismissione-wisp-paainviart"
  resource_group_name = "${local.product}-msg-rg"
}
