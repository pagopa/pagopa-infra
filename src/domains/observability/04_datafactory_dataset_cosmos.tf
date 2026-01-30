locals {
  cosmos = { for filename in fileset(path.module, "datafactory/cosmos/*.json") : replace(basename(filename), ".json", "") => file("${path.module}/${filename}") }
  # datasets = { for filename in fileset(path.module, "datafactory/${var.env_short == "p" ? "NOT_FOUND" : "datasets"}/*.json") : replace(basename(filename), ".json", "") => file("${path.module}/${filename}") }
}

data "azurerm_data_factory" "qi_data_factory_cosmos" {
  name                = "pagopa-${var.env_short}-weu-nodo-df"
  resource_group_name = "pagopa-${var.env_short}-weu-nodo-df-rg"
}

resource "azurerm_data_factory_custom_dataset" "qi_datasets_cosmos" {
  depends_on      = [azurerm_data_factory_linked_service_cosmosdb.cosmos_biz]
  for_each        = local.cosmos
  name            = "SMO_COSMOS_${each.key}_DataSet"
  data_factory_id = data.azurerm_data_factory.qi_data_factory_cosmos.id
  type            = "CosmosDbSqlApiCollection"

  type_properties_json = file("datafactory/cosmos/type_properties/${each.key}.json")

  schema_json = <<JSON
      ${each.value}
  JSON

  linked_service {
    name = azurerm_data_factory_linked_service_cosmosdb.cosmos_biz.name
  }
}
