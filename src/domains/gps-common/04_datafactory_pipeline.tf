resource "azurerm_data_factory_linked_service_postgresql" "gpd_postgres_linked_service" {
  name            = "gpd-${var.env}-postgres-linked-service"
  data_factory_id = data.azurerm_data_factory.data_factory.id

  connection_string = format(
    "Host=%s;Port=5432;Database=%s;UID=%s;EncryptionMethod=0;Password=%s",
    module.postgres_flexible_server_private_db.fqdn,
    var.gpd_db_name,
    data.azurerm_key_vault_secret.gpd_db_usr.value,
    data.azurerm_key_vault_secret.gpd_db_pwd.value
  )

  description = "Source gpd schema for gpd migration test"

  integration_runtime_name = "AutoResolveIntegrationRuntime"
}

resource "azurerm_data_factory_pipeline" "pipeline_odp_migration" {
  depends_on = [
    azurerm_data_factory_linked_service_postgresql.gpd_postgres_linked_service
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

  activities_json = "[${templatefile("datafactory/pipelines/APD_TO_ODP_MIGRATION_Pipeline.json", {
    linked_service_gpd = azurerm_data_factory_linked_service_postgresql.gpd_postgres_linked_service.name
  })}]"
}
