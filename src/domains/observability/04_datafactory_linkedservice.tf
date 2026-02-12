



# linked service df vs dataexp
resource "azurerm_data_factory_linked_service_kusto" "dataexp_ls" {
  count = var.dexp_db.enable ? 1 : 0

  name                 = local.dataexplorer_ls_name
  data_factory_id      = data.azurerm_data_factory.qi_data_factory.id
  kusto_endpoint       = azurerm_kusto_cluster.data_explorer_cluster[count.index].uri
  kusto_database_name  = azurerm_kusto_database.re_db[count.index].name
  use_managed_identity = true
}

# linked service df vs cosmos
data "azurerm_cosmosdb_account" "bizevent_cosmos_account" {
  name                = "pagopa-${var.env_short}-${var.location_short}-bizevents-ds-cosmos-account"
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-bizevents-rg"
}

resource "azurerm_data_factory_linked_service_cosmosdb" "cosmos_biz" {
  name             = "CosmosDbNoSqlBizPositivi${var.env_short}LinkService"
  data_factory_id  = data.azurerm_data_factory.qi_data_factory.id
  account_endpoint = data.azurerm_cosmosdb_account.bizevent_cosmos_account.endpoint
  account_key      = data.azurerm_cosmosdb_account.bizevent_cosmos_account.primary_key
  database         = "db"
}


resource "azurerm_kusto_database_principal_assignment" "qi_principal_assignment" {

  count = var.dexp_db.enable ? 1 : 0

  name                = "DexpPrincipalAssignment"
  resource_group_name = azurerm_kusto_cluster.data_explorer_cluster[count.index].resource_group_name
  cluster_name        = azurerm_kusto_cluster.data_explorer_cluster[count.index].name
  database_name       = azurerm_kusto_database.re_db[count.index].name

  tenant_id      = data.azurerm_data_factory.qi_data_factory.identity.0.tenant_id
  principal_id   = data.azurerm_data_factory.qi_data_factory.identity.0.principal_id
  principal_type = "App"
  role           = "Admin"
}

############### GEC CDC INGESTION LINKED SERVICEs #####################

## DF_4_blob_sa
data "azurerm_storage_account" "observ_storage_account" {
  name                = "pagopa${var.env_short}${var.location_short_itn}observsa" # pagopa<ENV>itnobservsa
  resource_group_name = "pagopa-${var.env_short}-${var.location_short_itn}-observ-st-rg"
}

# on DF json LinkSer config
# {
#     "name": "afm-gec-<env>-weu-sa-linkedservice",
#     "type": "Microsoft.DataFactory/factories/linkedservices",
#     "properties": {
#         "connectVia": {
#             "referenceName": "AutoResolveIntegrationRuntime",
#             "type": "IntegrationRuntimeReference"
#         },
#         "type": "AzureBlobStorage",
#         "typeProperties": {
#             "connectionString": "DefaultEndpointsProtocol=https;AccountName=pagopa<env>itnobservsa;EndpointSuffix=core.windows.net;",
#             "encryptedCredential": "<base64>"
#         },
#         "annotations": []
#     }
# }
resource "azurerm_data_factory_linked_service_azure_blob_storage" "afm_gec_storage_linked_service" {
  name              = "afm-gec-${var.env_short}-${var.location_short}-sa-linkedservice"
  data_factory_id   = data.azurerm_data_factory.obeserv_data_factory.id
  connection_string = data.azurerm_storage_account.observ_storage_account.primary_connection_string

  integration_runtime_name = "AutoResolveIntegrationRuntime"
  # connection_string_insecure = "DefaultEndpointsProtocol=https;AccountName=pagopa${var.env_short}itnobservsa;EndpointSuffix=core.windows.net;"
  use_managed_identity = true

  lifecycle {
    ignore_changes = [
      connection_string_insecure,
      connection_string
    ]
  }

}

## DF_4_cosmos_afm
data "azurerm_cosmosdb_account" "afm_cosmos_account" {
  name                = "pagopa-${var.env_short}-${var.location_short}-afm-marketplace-cosmos-account"
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-afm-rg"
}

resource "azurerm_data_factory_linked_service_cosmosdb" "afm_gec_cosmosdb_linked_service" {
  name             = "afm-gec-${var.env_short}-${var.location_short}-cosmos-linked-service"
  data_factory_id  = data.azurerm_data_factory.obeserv_data_factory.id
  account_endpoint = data.azurerm_cosmosdb_account.afm_cosmos_account.endpoint
  account_key      = data.azurerm_cosmosdb_account.afm_cosmos_account.primary_key
  database         = "db"
}

######### Datafactory & Cruscotto Config #########

# assignment for datafactory to see kv

resource "azurerm_key_vault_access_policy" "df_see_kv_cruscotto" {
  key_vault_id = data.azurerm_key_vault.cruscotto_kv.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_data_factory.qi_data_factory.identity[0].principal_id

  secret_permissions = ["Get", "List"]
}

# create linked service to keyvault

resource "azurerm_data_factory_linked_service_key_vault" "ls_df_to_kv" {
  name            = local.linked_service_cruscotto_kv_name
  data_factory_id = data.azurerm_data_factory.obeserv_data_factory.id
  key_vault_id    = data.azurerm_key_vault.cruscotto_kv.id
}

# fetch data config from kv for linked service to postgres

data "azurerm_key_vault_secret" "cruscotto_db_host" {
  name         = "ls-cruscotto-server"
  key_vault_id = data.azurerm_key_vault.cruscotto_kv.id
}

data "azurerm_key_vault_secret" "cruscotto_db_port" {
  name         = "ls-cruscotto-port"
  key_vault_id = data.azurerm_key_vault.cruscotto_kv.id
}

data "azurerm_key_vault_secret" "cruscotto_db_database" {
  name         = "ls-cruscotto-database"
  key_vault_id = data.azurerm_key_vault.cruscotto_kv.id
}

data "azurerm_key_vault_secret" "cruscotto_db_username" {
  name         = "ls-cruscotto-username"
  key_vault_id = data.azurerm_key_vault.cruscotto_kv.id
}

data "azurerm_key_vault_secret" "cruscotto_db_password" {
  name         = "ls-cruscotto-password"
  key_vault_id = data.azurerm_key_vault.cruscotto_kv.id
}


resource "azapi_resource" "ls_postgres_cruscotto" {

  type      = "Microsoft.DataFactory/factories/linkedservices@2018-06-01"
  name      = "LinkedService-Cruscotto-Fake"
  parent_id = data.azurerm_data_factory.obeserv_data_factory.id

  body = {
    properties = {
      type = "PostgreSqlV2"
      typeProperties = {
        server   = data.azurerm_key_vault_secret.cruscotto_db_host.value
        port     = data.azurerm_key_vault_secret.cruscotto_db_port.value
        database = data.azurerm_key_vault_secret.cruscotto_db_database.value
        username = data.azurerm_key_vault_secret.cruscotto_db_username.value
        password = {
          type = "AzureKeyVaultSecret"
          store = {
            referenceName = local.linked_service_cruscotto_kv_name
            type          = "LinkedServiceReference"
          }
          secretName = local.kv_name_password_database,
        }
        sslMode            = "2"
        authenticationType = "Basic"
      }
      connectVia = {
        referenceName = local.df_integration_runtime_name
        type          = "IntegrationRuntimeReference"
      }
    }
  }
}



resource "azapi_resource" "ls_postgres_cruscotto_tf" {
  type      = "Microsoft.DataFactory/factories/linkedservices@2018-06-01"
  name      = "LinkedService-Cruscotto"
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
        connectionString = "Host=${data.azurerm_key_vault_secret.cruscotto_db_host.value};Port=${data.azurerm_key_vault_secret.cruscotto_db_port.value};Database=${data.azurerm_key_vault_secret.cruscotto_db_database.value};UID=${data.azurerm_key_vault_secret.cruscotto_db_username.value};EncryptionMethod=1;ValidateServerCertificate=1"
        password = {
          type = "AzureKeyVaultSecret"
          store = {
            referenceName = local.linked_service_cruscotto_kv_name
            type          = "LinkedServiceReference"
          }
          secretName = local.kv_name_password_database
        }
      }
    }
  }
}



# grant for kv on data factory
resource "azurerm_key_vault_access_policy" "df_see_kv_nodo" {
  key_vault_id = data.azurerm_key_vault.nodo_kv.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_data_factory.qi_data_factory.identity[0].principal_id

  secret_permissions = ["Get", "List"]
}

# linked service to key vault nodo x df
resource "azurerm_data_factory_linked_service_key_vault" "ls_df_to_kv_nodo" {
  depends_on      = [azurerm_key_vault_access_policy.df_see_kv_nodo]
  name            = local.linked_service_nodo_kv_name
  data_factory_id = data.azurerm_data_factory.obeserv_data_factory.id
  key_vault_id    = data.azurerm_key_vault.nodo_kv.id
}

# fetch config value from kv
data "azurerm_key_vault_secret" "nodo_db_host" {
  name         = "ls-nodo-server"
  key_vault_id = data.azurerm_key_vault.qi-kv.id
}

data "azurerm_key_vault_secret" "nodo_db_port" {
  name         = "ls-nodo-port"
  key_vault_id = data.azurerm_key_vault.qi-kv.id
}

data "azurerm_key_vault_secret" "nodo_db_database" {
  name         = "ls-nodo-database"
  key_vault_id = data.azurerm_key_vault.qi-kv.id
}

data "azurerm_key_vault_secret" "nodo_db_username" {
  name         = "ls-nodo-username"
  key_vault_id = data.azurerm_key_vault.qi-kv.id
}

resource "azapi_resource" "ls_postgres_nodo_tf" {
  depends_on = [azurerm_data_factory_linked_service_key_vault.ls_df_to_kv_nodo]
  type       = "Microsoft.DataFactory/factories/linkedservices@2018-06-01"
  name       = "LinkedService-Nodo-Flexible"
  parent_id  = data.azurerm_data_factory.obeserv_data_factory.id

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
        connectionString = "Host=${data.azurerm_key_vault_secret.nodo_db_host.value};Port=${data.azurerm_key_vault_secret.nodo_db_port.value};Database=${data.azurerm_key_vault_secret.nodo_db_database.value};UID=${data.azurerm_key_vault_secret.nodo_db_username.value};EncryptionMethod=1;ValidateServerCertificate=1"
        password = {
          type = "AzureKeyVaultSecret"
          store = {
            referenceName = local.linked_service_nodo_kv_name
            type          = "LinkedServiceReference"
          }
          secretName = local.kv_name_password_config_database
        }
      }
    }
  }
}
