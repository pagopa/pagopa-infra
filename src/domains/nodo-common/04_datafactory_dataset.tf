locals {
  datasets = { for filename in fileset(path.module, "datafactory/datasets/*.json") : replace(basename(filename), ".json", "") => file("${path.module}/${filename}") }
}

resource "azurerm_data_factory_custom_dataset" "datasets" {
  for_each        = local.datasets
  depends_on      = [azurerm_data_factory_linked_service_postgresql.data_factory_ls]
  name            = "${each.key}Dataset"
  data_factory_id = azurerm_data_factory.data_factory.id
  type            = "AzurePostgreSqlTable"

  type_properties_json = file("datafactory/datasets/type_properties/${each.key}.json")

  schema_json = <<JSON
      ${each.value}
  JSON

  linked_service {
    name = azurerm_data_factory_linked_service_postgresql.data_factory_ls.name
  }

  lifecycle { create_before_destroy = true }
}
