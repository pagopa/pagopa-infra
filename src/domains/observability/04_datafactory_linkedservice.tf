# linked service df vs dataexp
resource "azurerm_data_factory_linked_service_kusto" "dataexp_ls" {
  count = var.dexp_db.enable ? 1 : 0

  name                 = "AzureDataExplorer${var.env_short}LinkService"
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


# get info of key vault
data "azurerm_key_vault" "qi_nodo_kv" {
  name                = "pagopa-${var.env_short}-nodo-kv"
  resource_group_name = "pagopa-${var.env_short}-nodo-sec-rg"
}

# creo access policy su key vault per permettere a data-factory di leggere chiavi e secret
resource "azurerm_key_vault_access_policy" "datafactory_access_db_nodo" {
  key_vault_id = data.azurerm_key_vault.qi_nodo_kv.id
  tenant_id    = data.azurerm_data_factory.qi_data_factory.identity.0.tenant_id
  object_id    = data.azurerm_data_factory.qi_data_factory.identity.0.principal_id

  key_permissions = [
    "Get", "List"
  ]

  secret_permissions = [
    "Get", "List"
  ]
}

# creo il linked service al key vault

resource "azurerm_data_factory_linked_service_key_vault" "qi_df_linked_kv" {
  name            = "SMO_NODO_KV"
  data_factory_id = data.azurerm_data_factory.qi_data_factory.id
  key_vault_id    = data.azurerm_key_vault.qi_nodo_kv.id
}



# recupero le info del db del nodo flexible
data "azurerm_postgresql_flexible_server" "qi_nodo_flexible" {
  name                = "pagopa-d-weu-nodo-flexible-postgresql"
  resource_group_name = "pagopa-d-weu-nodo-db-rg"
}

# recupero la chiave nel key vault

data "azurerm_key_vault_secret" "qi_kv_nodo_flexible_cfg" {
  name         = "db-cfg-password"
  key_vault_id = data.azurerm_key_vault.qi_nodo_kv.id
}

locals {
  host_flexible_db          = data.azurerm_postgresql_flexible_server.qi_nodo_flexible.fqdn
  password_flexible_cfg     = data.azurerm_key_vault_secret.qi_kv_nodo_flexible_cfg.value
  user_flexible_cfg         = "cfg"
  port_flexible_cfg         = "5432"
  database_flexible_cfg     = "nodo"
}


# creo il linked service da data factory verso il nodo flexible (deprecato su df, The current legacy linked service is to be deprecated. Kindly upgrade this by creating a new PostgreSQL linked service)
#resource "azurerm_data_factory_linked_service_postgresql" "qi_df_linked_nodo_flexible" {
#  name              = "NodoFlexible${var.env_short}LinkedService"
#  data_factory_id   = data.azurerm_data_factory.qi_data_factory.id
#  connection_string = "Host=${local.host_flexible_db};Port=${local.port_flexible_cfg};Database=${local.database_flexible_cfg};UID=${local.user_flexible_cfg};EncryptionMethod=0;Password=${local.password_flexible_cfg}"
#}

# copiato da pagopa-infra/src/domains/nodo-common/04_datafactory_linkedservice.tf
# evito azurerm_data_factory_linked_service_postgresql perchè crea un connettore legacy
resource "azapi_resource" "qi_azure_postgresql_ls" {
  type      = "Microsoft.DataFactory/factories/linkedservices@2018-06-01"
  name      = "NodoFlexible${var.env_short}LinkedService"
  parent_id = data.azurerm_data_factory.qi_data_factory.id

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
        connectionString = "host=${local.host_flexible_db};port=${local.port_flexible_cfg};database=${local.database_flexible_cfg};uid=${local.user_flexible_cfg};encryptionmethod=1;validateservercertificate=0;password=${local.password_flexible_cfg}"
      }
    }
  })
}


# format("Host=%s;Port=5432;Database=nodo;UID=cfg;EncryptionMethod=0;Password=%s", data.qi_nodo_flexible.fqdn, data.qi_kv_nodo_flexible_cfg.value)