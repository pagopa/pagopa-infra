locals {
  # datasets = { for filename in fileset(path.module, "datafactory/datasets/*.json") : replace(basename(filename), ".json", "") => file("${path.module}/${filename}") }

  datasets = { for filename in fileset(path.module, "datafactory/${var.env_short == "p" ? "NOT_FOUND" : "datasets"}/*.json") : replace(basename(filename), ".json", "") => file("${path.module}/${filename}") }
}

resource "azurerm_data_factory_custom_dataset" "datasets" {
  depends_on      = [azapi_resource.azure_postgresql_ls]
  for_each        = local.datasets
  name            = "${each.key}Dataset"
  data_factory_id = azurerm_data_factory.data_factory.id
  type            = "AzurePostgreSqlTable"

  type_properties_json = file("datafactory/datasets/type_properties/${each.key}.json")

  schema_json = <<JSON
      ${each.value}
  JSON

  linked_service {
    name = azapi_resource.azure_postgresql_ls.name
  }

}
