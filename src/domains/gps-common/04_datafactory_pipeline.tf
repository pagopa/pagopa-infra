resource "azurerm_data_factory_linked_service_key_vault" "gps_kv_linked_service" {
  name            = "gps-${var.env}-kv-linked-service"
  data_factory_id = data.azurerm_data_factory.data_factory.id
  key_vault_id    = data.azurerm_key_vault.gps_kv.id
}

resource "azapi_resource" "gpd_postgres_linked_service" {
  depends_on = [
    azurerm_data_factory_linked_service_key_vault.gps_kv_linked_service
  ]

  type                      = "Microsoft.DataFactory/factories/linkedservices@2018-06-01"
  name                      = "gpd-${var.env}-postgres-ls"
  parent_id                 = data.azurerm_data_factory.data_factory.id
  schema_validation_enabled = false

  body = {
    properties = {
      connectVia = {
        parameters    = {}
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
        port     = "5433"                                                  // "8432" // adhoc private endpoint port
        server   = "gpd-db.${var.env_short}.internal.postgresql.pagopa.it" // "172.205.217.81" // adhoc private endpoint host
        sslMode  = "2"
        username = "${data.azurerm_key_vault_secret.gpd_db_usr.value}"
      }
    }
  }
}

resource "azurerm_data_factory_pipeline" "pipeline_odp_backfill" {
  depends_on = [
    azapi_resource.gpd_postgres_linked_service
  ]

  name            = "GPD_ZDT_BACKFILL_FUNCTIONS"
  data_factory_id = data.azurerm_data_factory.data_factory.id

  parameters = {
    functionName = ""
    batchSize    = 10000
  }

  variables = {
    rowsUpdated = 1
  }

  folder = "GPD_MIGRATION_PIPELINE"

  activities_json = "[${templatefile("datafactory/pipelines/GPD_ZDT_BACKFILL_FUNCTION.json", {
    linked_service_gpd = azapi_resource.gpd_postgres_linked_service.name
  })}]"
}
