### EVH
data "azurerm_eventhub_namespace_authorization_rule" "cdc_connection_string" {
  name                = "cdc-connection-string"
  namespace_name      = "${local.project}-evh"
  resource_group_name = "${local.project}-evh-rg"
}

data "azurerm_eventhub_namespace" "eventhub" {
  name = "${local.project}-evh"
  namespace_name      = "${local.project}-evh"
  resource_group_name = "${local.project}-evh-rg"
}

data "azurerm_postgresql_database" "apd_db" {
  name                = var.postgres_db_name
  resource_group_name = "${local.project}-evh-rg"
}
