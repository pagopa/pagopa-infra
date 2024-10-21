### EVH
resource "azurerm_eventhub_authorization_rule" "cdc_connection_string" {
  name                = "cdc-connection-string"
  namespace_name      = "${local.project}-evh"
  resource_group_name = "${local.project}-evh-rg"
  listen              = true
  send                = true
  manage              = true
}
