data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns01_printit-evt_notice-evt-rx" {
  name                = "${var.prefix}-notice-evt-rx"
  namespace_name      = "${local.product}-evh-ns01"
  eventhub_name       = "printit-notice-evt"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns01_printit-evt_notice-complete-evt-rx" {
  name                = "${var.prefix}-notice-complete-evt-tx"
  namespace_name      = "${local.product}-evh-ns01"
  eventhub_name       = "printit-notice-evt"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns01_printit-evt_notice-error-evt-rx" {
  name                = "${var.prefix}-notice-error-evt-tx"
  namespace_name      = "${local.product}-evh-ns01"
  eventhub_name       = "printit-notice-evt"
  resource_group_name = "${local.product}-msg-rg"
}
