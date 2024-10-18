locals {
  datasets_nodo_flexible_cfg = { for filename in fileset(path.module, "datafactory/postgres/nodo-flexible/cfg/*.json") : replace(basename(filename), ".json", "") => file("${path.module}/${filename}") }
  # datasets = { for filename in fileset(path.module, "datafactory/${var.env_short == "p" ? "NOT_FOUND" : "datasets"}/*.json") : replace(basename(filename), ".json", "") => file("${path.module}/${filename}") }
}

data "azurerm_data_factory" "qi_data_factory_x_nodo_flexible" {
  name                = "pagopa-${var.env_short}-weu-nodo-df"
  resource_group_name = "pagopa-${var.env_short}-weu-nodo-df-rg"
}

resource "azurerm_data_factory_custom_dataset" "qi_datasets_nodo_flexible_cfg" {
  depends_on      = [azapi_resource.qi_azure_postgresql_ls]
  for_each        = local.datasets_nodo_flexible_cfg
  name            = "SMO_NODO_CFG_${each.key}_DataSet"
  data_factory_id = data.azurerm_data_factory.qi_data_factory_x_nodo_flexible.id
  type            = "AzurePostgreSqlTable"

  type_properties_json = file("datafactory/postgres/nodo-flexible/cfg/type_properties/${each.key}.json")

  schema_json = <<JSON
      ${each.value}
  JSON

  linked_service {
    name = azapi_resource.qi_azure_postgresql_ls.name
  }

}
