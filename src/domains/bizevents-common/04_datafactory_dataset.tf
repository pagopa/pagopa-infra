resource "azurerm_data_factory_dataset_cosmosdb_sqlapi" "biz-events" {
  name                = "example"
  data_factory_id     = azurerm_data_factory.data_factory.id
  linked_service_name = azurerm_data_factory_linked_service_cosmosdb.biz_event_data_factory_linked_service.name

  collection_name = "biz-events"
}

resource "azurerm_data_factory_dataset_cosmosdb_sqlapi" "biz-events-view-general" {
  name                = "biz-events-view-general"
  data_factory_id     = azurerm_data_factory.data_factory.id
  linked_service_name = azurerm_data_factory_linked_service_cosmosdb.biz_event_data_factory_linked_service.name

  collection_name = "biz-events-cart-view-general"
}

resource "azurerm_data_factory_dataset_cosmosdb_sqlapi" "biz-events-view-item" {
  name                = "biz-events-view-item"
  data_factory_id     = azurerm_data_factory.data_factory.id
  linked_service_name = azurerm_data_factory_linked_service_cosmosdb.biz_event_data_factory_linked_service.name

  collection_name = "biz-events-cart-view-item"
}

resource "azurerm_data_factory_dataset_cosmosdb_sqlapi" "biz-events-view-user" {
  name                = "biz-events-view-user"
  data_factory_id     = azurerm_data_factory.data_factory.id
  linked_service_name = azurerm_data_factory_linked_service_cosmosdb.biz_event_data_factory_linked_service.name

  collection_name = "biz-events-cart-view-user"
}
