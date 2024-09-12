

locals {
  folder_in  = "BIZ_EVENTS_SOURCE"
  folder_out = "BIZ_EVENTS_DESTINATION"
}

// IN
resource "azurerm_data_factory_dataset_cosmosdb_sqlapi" "biz_events_dataset" {
  name                = "BIZ_EVENTS_OK_Dataset"
  data_factory_id     = data.azurerm_data_factory.data_factory.id
  linked_service_name = "NewCosmosDbNoSqlBizPositivi${var.env_short}LinkService"
  folder              = local.folder_in
  collection_name     = "biz-events"
}

// OUT
resource "azurerm_data_factory_dataset_cosmosdb_sqlapi" "biz_events_cart_view_dataset" {
  name                = "BIZ_EVENTS_CART_VIEW_DataSet"
  data_factory_id     = data.azurerm_data_factory.data_factory.id
  linked_service_name = "NewCosmosDbNoSqlBizPositivi${var.env_short}LinkService${var.env == "dev" ? "Dev" : ""}"
  folder              = local.folder_out
  collection_name     = "biz-events-view-cart"
}
resource "azurerm_data_factory_dataset_cosmosdb_sqlapi" "biz_events_general_view_dataset" {
  name                = "BIZ_EVENTS_GENERAL_VIEW_DataSet"
  data_factory_id     = data.azurerm_data_factory.data_factory.id
  linked_service_name = "NewCosmosDbNoSqlBizPositivi${var.env_short}LinkService${var.env == "dev" ? "Dev" : ""}"
  folder              = local.folder_out
  collection_name     = "biz-events-view-general"
}
resource "azurerm_data_factory_dataset_cosmosdb_sqlapi" "biz_events_user_view_dataset" {
  name                = "BIZ_EVENTS_USER_VIEW_DataSet"
  data_factory_id     = data.azurerm_data_factory.data_factory.id
  linked_service_name = "NewCosmosDbNoSqlBizPositivi${var.env_short}LinkService${var.env == "dev" ? "Dev" : ""}"
  folder              = local.folder_out
  collection_name     = "biz-events-view-user"
}
