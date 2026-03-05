# linked services for cosmosdb
resource "azurerm_data_factory_linked_custom_service" "df_connection_linked_service_cosmosdb" {
  for_each = local.data_factory_linked_services_cosmosdb

  depends_on = [azapi_resource_action.df_connection_approve_private_endpoint_connection]

  name            = "${each.key}-cosmosdb-${var.env_short}-ls"
  data_factory_id = data.azurerm_data_factory.qi_data_factory.id
  type            = "CosmosDb"
  type_properties_json = jsonencode({
    connectionString       = each.value.connection_string
    account                = each.value.account_name
    database               = each.value.database
    isServerVersionAbove32 = true
  })

  integration_runtime {
    name = local.adf_integration_runtime_name
  }
}
