
// ns3 ( new ns1 )
data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns03_nodo-dei-pagamenti-biz-evt_pagopa-biz-evt-rx" {
  name                = "${var.prefix}-biz-evt-rx"
  namespace_name      = "${local.product}-${var.location_short}-core-evh-ns03"
  eventhub_name       = "nodo-dei-pagamenti-biz-evt"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns03_nodo-dei-pagamenti-biz-evt_pagopa-biz-evt-tx" {
  name                = "${var.prefix}-biz-evt-tx"
  namespace_name      = "${local.product}-${var.location_short}-core-evh-ns03"
  eventhub_name       = "nodo-dei-pagamenti-biz-evt"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns03_nodo-dei-pagamenti-negative-biz-evt_pagopa-negative-biz-evt-tx" {
  name                = "${var.prefix}-negative-biz-evt-tx"
  namespace_name      = "${local.product}-${var.location_short}-core-evh-ns03"
  eventhub_name       = "nodo-dei-pagamenti-negative-biz-evt"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns03_nodo-dei-pagamenti-biz-evt-enrich_pagopa-biz-evt-tx" {
  name                = "${var.prefix}-biz-evt-tx"
  namespace_name      = "${local.product}-${var.location_short}-core-evh-ns03"
  eventhub_name       = "nodo-dei-pagamenti-biz-evt-enrich"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns03_nodo-dei-pagamenti-negative-biz-evt_pagopa-negative-biz-evt-rx" {
  name                = "${var.prefix}-negative-biz-evt-rx"
  namespace_name      = "${local.product}-${var.location_short}-core-evh-ns03"
  eventhub_name       = "nodo-dei-pagamenti-negative-biz-evt"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns03_nodo-dei-pagamenti-biz-evt_pagopa-biz-evt-rx-views" {
  name                = "${var.prefix}-biz-evt-rx-views"
  namespace_name      = "${local.product}-${var.location_short}-core-evh-ns03"
  eventhub_name       = "nodo-dei-pagamenti-biz-evt"
  resource_group_name = "${local.product}-msg-rg"
}

// ns4 ( new ns2 )
data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns04_nodo-dei-pagamenti-negative-awakable-biz-evt_pagopa-biz-evt-tx" {
  name                = "${var.prefix}-biz-evt-tx"
  namespace_name      = "${local.product}-${var.location_short}-core-evh-ns04"
  eventhub_name       = "nodo-dei-pagamenti-negative-awakable-biz-evt"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns04_nodo-dei-pagamenti-negative-final-biz-evt_pagopa-biz-evt-tx" {
  name                = "${var.prefix}-biz-evt-tx"
  namespace_name      = "${local.product}-${var.location_short}-core-evh-ns04"
  eventhub_name       = "nodo-dei-pagamenti-negative-final-biz-evt"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns04_nodo-dei-pagamenti-negative-awakable-biz-evt_pagopa-biz-evt-rx-pdnd" {
  name                = "${var.prefix}-biz-evt-rx-pdnd"
  namespace_name      = "${local.product}-${var.location_short}-core-evh-ns04"
  eventhub_name       = "nodo-dei-pagamenti-negative-awakable-biz-evt"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns04_nodo-dei-pagamenti-negative-final-biz-evt_pagopa-biz-evt-rx-pdnd" {
  name                = "${var.prefix}-biz-evt-rx-pdnd"
  namespace_name      = "${local.product}-${var.location_short}-core-evh-ns04"
  eventhub_name       = "nodo-dei-pagamenti-negative-final-biz-evt"
  resource_group_name = "${local.product}-msg-rg"
}

