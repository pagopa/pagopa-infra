locals {
  administrator_login    = data.azurerm_key_vault_secret.pgres_flex_admin_login.value
  administrator_password = data.azurerm_key_vault_secret.pgres_flex_admin_pwd.value
}

resource "azapi_resource" "azure_postgresql_ls" {
  type      = "Microsoft.DataFactory/factories/linkedservices@2018-06-01"
  name      = "AzurePostgreSqlLinkedService"
  parent_id = azurerm_data_factory.data_factory.id

  body = jsonencode({
    properties = {
      annotations = []
      connectVia = {
        parameters    = {}
        referenceName = "AutoResolveIntegrationRuntime"
        type          = "IntegrationRuntimeReference"
      }
      type = "AzurePostgreSql"
      typeProperties = {
        connectionString = "host=pagopa-${var.env_short}-weu-nodo-flexible-postgresql.postgres.database.azure.com;port=5432;database=nodo;uid=${local.administrator_login};encryptionmethod=1;validateservercertificate=0;password=${local.administrator_password}"
      }
    }
  })
}
