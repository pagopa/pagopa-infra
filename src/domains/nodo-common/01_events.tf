#
#data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns02_nodo-dei-pagamenti-verify-ko_nodo-dei-pagamenti-verify-ko-tx" {
#  name                = "nodo-dei-pagamenti-verify-ko-tx"
#  namespace_name      = "${local.product}-evh-ns02"
#  eventhub_name       = "nodo-dei-pagamenti-verify-ko"
#  resource_group_name = "${local.product}-msg-rg"
#}
#
#data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns02_nodo-dei-pagamenti-verify-ko_nodo-dei-pagamenti-verify-ko-datastore-rx" {
#  name                = "nodo-dei-pagamenti-verify-ko-datastore-rx"
#  namespace_name      = "${local.product}-evh-ns02"
#  eventhub_name       = "nodo-dei-pagamenti-verify-ko"
#  resource_group_name = "${local.product}-msg-rg"
#}
#
#data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns02_nodo-dei-pagamenti-verify-ko_nodo-dei-pagamenti-verify-ko-tablestorage-rx" {
#  name                = "nodo-dei-pagamenti-verify-ko-tablestorage-rx"
#  namespace_name      = "${local.product}-evh-ns02"
#  eventhub_name       = "nodo-dei-pagamenti-verify-ko"
#  resource_group_name = "${local.product}-msg-rg"
#}
#
#data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns02_nodo-dei-pagamenti-verify-ko_nodo-dei-pagamenti-verify-ko-test-rx" {
#  name                = "nodo-dei-pagamenti-verify-ko-test-rx"
#  namespace_name      = "${local.product}-evh-ns02"
#  eventhub_name       = "nodo-dei-pagamenti-verify-ko"
#  resource_group_name = "${local.product}-msg-rg"
#}
