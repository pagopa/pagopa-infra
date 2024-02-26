data "azurerm_eventhub_authorization_rule" "nodo_dei_pagamenti_cache_tx" {
  name                = "nodo-dei-pagamenti-cache-tx"
  resource_group_name = "${local.product}-msg-rg"
  namespace_name      = "${local.product}-${local.evt_hub_location}-evh-ns04"
  eventhub_name       = "nodo-dei-pagamenti-cache"
}
