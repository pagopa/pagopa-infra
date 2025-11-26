data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns03_nodo-dei-pagamenti-verify-ko-tx" {
  name                = "nodo-dei-pagamenti-verify-ko-tx-PAGOPA"
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

data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns03_nodo-dei-pagamenti-biz-evt_pagopa-biz-evt-tx" {
  name                = "pagopa-biz-evt-tx-PAGOPA"
  namespace_name      = "${local.product}-${var.location_short}-core-evh-ns03"
  eventhub_name       = "nodo-dei-pagamenti-biz-evt"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns03_nodo-dei-pagamenti-negative-biz-evt_pagopa-negative-biz-evt-tx" {
  name                = "pagopa-negative-biz-evt-tx-PAGOPA"
  namespace_name      = "${local.product}-${var.location_short}-core-evh-ns03"
  eventhub_name       = "nodo-dei-pagamenti-negative-biz-evt"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns03_nodo-dei-pagamenti-verify-ko_nodo-dei-pagamenti-verify-ko-tx" {
  name                = "nodo-dei-pagamenti-verify-ko-tx-PAGOPA"
  namespace_name      = "${local.product}-${var.location_short}-core-evh-ns03"
  eventhub_name       = "nodo-dei-pagamenti-verify-ko"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns03_nodo-dei-pagamenti-re_nodo-dei-pagamenti" {
  name                = "nodo-dei-pagamenti-PAGOPA"
  namespace_name      = "${local.product}-${var.location_short}-core-evh-ns03"
  eventhub_name       = "nodo-dei-pagamenti-re"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-weu-core-evh-ns04_nodo-dei-pagamenti-cache-sync-rx" {
  name                = "nodo-dei-pagamenti-cache-sync-rx"
  namespace_name      = "${local.product}-${local.evt_hub_location}-evh-ns04"
  eventhub_name       = "nodo-dei-pagamenti-cache"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-weu-core-evh-ns04_nodo-dei-pagamenti-cache-stand-in-rx" {
  name                = "nodo-dei-pagamenti-cache-stand-in-rx"
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
