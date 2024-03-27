locals {
  datasets = { for filename in fileset(path.module, "datafactory/datasets/*.json") : replace(basename(filename), ".json", "") => file("${path.module}/${filename}") }
  # datasets = { for filename in fileset(path.module, "datafactory/${var.env_short == "p" ? "NOT_FOUND" : "datasets"}/*.json") : replace(basename(filename), ".json", "") => file("${path.module}/${filename}") }
}

data "azurerm_data_factory" "qi_data_factory" {
  name                = "pagopa-${var.env_short}-weu-nodo-df"
  resource_group_name = "pagopa-${var.env_short}-weu-nodo-df-rg"
}

resource "azurerm_data_factory_custom_dataset" "qi_datasets" {
  depends_on      = [azurerm_data_factory_linked_service_kusto.dataexp_ls[0]]
  for_each        = local.datasets
  name            = "SMO_${each.key}_DataSet"
  data_factory_id = data.azurerm_data_factory.qi_data_factory.id
  type            = "AzureDataExplorerTable"

  type_properties_json = file("datafactory/datasets/type_properties/${each.key}.json")

  schema_json = <<JSON
      ${each.value}
  JSON

  linked_service {
    name = azurerm_data_factory_linked_service_kusto.dataexp_ls[0].name
  }

}
