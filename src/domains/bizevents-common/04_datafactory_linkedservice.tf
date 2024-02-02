data "azurerm_cosmosdb_account" "biz_event_cosmos_account" {
  name                = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-ds-cosmos-account"
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-rg"
}

resource "azurerm_data_factory_linked_service_cosmosdb" "biz_event_data_factory_linked_service" {
  name             = "biz_event_data_factory_linked_service"
  data_factory_id  = azurerm_data_factory.data_factory.id
  account_endpoint = data.azurerm_cosmosdb_account.biz_event_cosmos_account.endpoint
  account_key      = data.azurerm_cosmosdb_account.biz_event_cosmos_account.primary_key
  database         = "db"
}
