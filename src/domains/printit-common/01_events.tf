data "azurerm_eventhub_namespace" "printit_event_hub_namespace" {
  name                = "${var.prefix}-${var.env_short}-weu-core-evh-ns04"
  resource_group_name = data.azurerm_resource_group.msg_rg.name
}

data "azurerm_eventhub" "printit_event_hub" {
  name                = "${var.prefix}-printit-evh"
  resource_group_name = data.azurerm_resource_group.msg_rg.name
  namespace_name      = data.azurerm_eventhub_namespace.printit_event_hub_namespace.name
}

data "azurerm_resource_group" "msg_rg" {
  name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa_evh_printit-evt_notice-evt-rx" {
  name                = "${var.prefix}-notice-evt-rx"
  namespace_name      = data.azurerm_eventhub_namespace.printit_event_hub_namespace
  eventhub_name       = data.azurerm_eventhub.printit_event_hub.name
  resource_group_name = data.azurerm_resource_group.msg_rg
}

data "azurerm_eventhub_authorization_rule" "pagopa_evh_printit-evt_notice-complete-evt-rx" {
  name                = "${var.prefix}-notice-complete-evt-tx"
  namespace_name      = data.azurerm_eventhub_namespace.printit_event_hub_namespace
  eventhub_name       = data.azurerm_eventhub.printit_event_hub.name
  resource_group_name = data.azurerm_resource_group.msg_rg
}

data "azurerm_eventhub_authorization_rule" "pagopa_evh_printit-evt_notice-error-evt-rx" {
  name                = "${var.prefix}-notice-error-evt-tx"
  namespace_name      = data.azurerm_eventhub_namespace.printit_event_hub_namespace
  eventhub_name       = data.azurerm_eventhub.printit_event_hub.name
  resource_group_name = data.azurerm_resource_group.msg_rg
}
