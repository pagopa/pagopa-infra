resource "azurerm_data_factory_linked_service_key_vault" "gps_kv_linked_service" {
  name            = "gps-${var.env}-kv-linked-service"
  data_factory_id = data.azurerm_data_factory.data_factory.id
  key_vault_id    = data.azurerm_key_vault.gps_kv.id
}

resource "azapi_resource" "gpd_postgres_linked_service" {
  type                      = "Microsoft.DataFactory/factories/linkedservices@2018-06-01"
  name                      = "gpd-${var.env}-postgres-ls"
  parent_id                 = data.azurerm_data_factory.data_factory.id
  schema_validation_enabled = false

  body = {
    properties = {
      connectVia = {
        parameters = {}
        referenceName = "AutoResolveIntegrationRuntime"
        type          = "IntegrationRuntimeReference"
      }
      version = "2.0"
      type    = "AzurePostgreSql"
      typeProperties = {
        database = "${var.gpd_db_name}"
        password = {
          type = "AzureKeyVaultSecret",
          store = {
            referenceName = "${azurerm_data_factory_linked_service_key_vault.gps_kv_linked_service.name}",
            type          = "LinkedServiceReference"
          },
          secretName = "${data.azurerm_key_vault_secret.gpd_db_pwd.name}"
        }
        port     = "5432"
        server   = "${module.postgres_flexible_server_private_db.fqdn}"
        sslMode  = "2"
        username = "${data.azurerm_key_vault_secret.gpd_db_usr.value}"
      }
    }
  }
}

resource "azurerm_data_factory_pipeline" "pipeline_odp_migration" {
  depends_on = [
    azapi_resource.gpd_postgres_linked_service
  ]

  name            = "APD_TO_ODP_MIGRATION_Pipeline"
  data_factory_id = data.azurerm_data_factory.data_factory.id

  parameters = {
    fromDate  = "NULL",
    toDate    = "NULL",
    batchSize = 10000
  }

  variables = {
    processed_pp          = 1,
    processed_po          = 1,
    processed_installment = 1
  }

  folder = "GPD_MIGRATION_PIPELINE"

  activities_json = "[${templatefile("datafactory/pipelines/APD_TO_ODP_MIGRATION_Pipeline.json", {
    linked_service_gpd = azapi_resource.gpd_postgres_linked_service.name
  })}]"
}
