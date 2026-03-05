# linked services for cosmosdb
resource "azurerm_data_factory_linked_service_cosmosdb" "df_connection_linked_service_cosmosdb" {
  for_each = local.data_factory_linked_services_cosmosdb
  name             = "${each.key}-cosmosdb-${var.env_short}-LinkService"
  data_factory_id  = data.azurerm_data_factory.qi_data_factory.id
  connection_string = each.value.connection_string
  database         = each.value.database
}
