data "azurerm_key_vault_secret" "df_connection_postgres_host" {
  for_each = local.data_factory_linked_services_postgres
  name         = each.value.host_secret_name
  key_vault_id = data.azurerm_key_vault.cruscotto_kv.id
}

data "azurerm_key_vault_secret" "df_connection_postgres_port" {
  for_each = local.data_factory_linked_services_postgres
  name         = each.value.port_secret_name
  key_vault_id = data.azurerm_key_vault.cruscotto_kv.id
}

data "azurerm_key_vault_secret" "df_connection_postgres_database" {
  for_each = local.data_factory_linked_services_postgres
  name         = each.value.database_secret_name
  key_vault_id = data.azurerm_key_vault.cruscotto_kv.id
}

data "azurerm_key_vault_secret" "df_connection_postgres_username" {
  for_each = local.data_factory_linked_services_postgres
  name         = each.value.username_secret_name
  key_vault_id = data.azurerm_key_vault.cruscotto_kv.id
}




resource "azurerm_key_vault_access_policy" "df_connecction_access_kv" {
  for_each = local.data_factory_linked_services_postgres
  key_vault_id = each.value.key_vault_id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_data_factory.qi_data_factory.identity[0].principal_id

  secret_permissions = ["Get", "List"]
}

resource "azurerm_data_factory_linked_service_key_vault" "df_connection_linked_service_key_vault" {
  for_each = local.data_factory_linked_services_postgres
  name            = "${each.key}-${var.env_short}-key-vault"
  data_factory_id = data.azurerm_data_factory.obeserv_data_factory.id
  key_vault_id    = each.value.key_vault_id
}


resource "azapi_resource" "df_connection_linked_service_postgres" {
  for_each = local.data_factory_linked_services_postgres
  type      = "Microsoft.DataFactory/factories/linkedservices@2018-06-01"
  name      = "${each.key}-postgres-${var.env_short}-LinkService"
  parent_id = data.azurerm_data_factory.obeserv_data_factory.id

  body = {
    properties = {
      annotations = []
      connectVia = {
        parameters    = {}
        referenceName = "AutoResolveIntegrationRuntime"
        type          = "IntegrationRuntimeReference"
      }
      type = "AzurePostgreSql"
      typeProperties = {
        #connectionString = "Host=${data.azurerm_key_vault_secret.cruscotto_db_host.value};Port=${data.azurerm_key_vault_secret.cruscotto_db_port.value};Database=${data.azurerm_key_vault_secret.cruscotto_db_database.value};UID=${data.azurerm_key_vault_secret.cruscotto_db_username.value};EncryptionMethod=6;Password=${data.azurerm_key_vault_secret.cruscotto_db_password.value}"
        connectionString = "Host=${data.azurerm_key_vault_secret.df_connection_postgres_host[each.key].value};Port=${data.azurerm_key_vault_secret.df_connection_postgres_port[each.key].value};Database=${data.azurerm_key_vault_secret.df_connection_postgres_database[each.key].value};UID=${data.azurerm_key_vault_secret.df_connection_postgres_username[each.key].value};EncryptionMethod=1;ValidateServerCertificate=1"
        password = {
          type = "AzureKeyVaultSecret"
          store = {
            referenceName = azurerm_data_factory_linked_service_key_vault.df_connection_linked_service_key_vault[each.key].name
            type          = "LinkedServiceReference"
          }
          secretName = each.value.password_secret_name
        }
      }
    }
  }
}
