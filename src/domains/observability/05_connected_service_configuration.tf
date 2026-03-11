locals {
  # Configurazione degli endpoint privati gestiti per Azure Data Factory.
  # Ogni entry definisce un endpoint privato verso un servizio specifico tramite Private Link Service.
  # - target_resource_id: ID della risorsa di destinazione.
  # - fqdns: lista di FQDN (Fully Qualified Domain Names) recuperati da Key Vault,
  #          utilizzati per la risoluzione DNS dell'endpoint privato.
  # - subresource_name: nome della sottorisorsa per cui è necessario approvare la connessione (opzionale, dipende dal servizio di destinazione).
  # - type: tipo di risorsa di destinazione, utilizzato per mappare correttamente le API di Azure durante l'approvazione della connessione privata.
  # es:
  # GpdCosmosSql = {
  #    target_resource_id = data.azurerm_cosmosdb_account.gpd_payments_cosmos_account.id
  #    fqdns              = null
  #    subresource_name   = "Sql"
  #    type               = "cosmosdb"
  #  }
  data_factory_managed_private_endpoint = merge(
    var.env_short == "d" ? { //private endpoint already created on other envs, to avoid destroy/recreate we conditionally create it only on dev env
      AfmMarketplaceSql = {
        target_resource_id = data.azurerm_cosmosdb_account.afm_cosmos_account.id
        fqdns              = null
        subresource_name   = "Sql"
        type               = "cosmosdb"
      }
      AfmMarketplaceAnalytical = {
        target_resource_id = data.azurerm_cosmosdb_account.afm_cosmos_account.id
        fqdns              = null
        subresource_name   = "Analytical"
        type               = "cosmosdb"
      }
      BizPositiviSql = {
        target_resource_id = data.azurerm_cosmosdb_account.bizevent_cosmos_account.id
        fqdns              = null
        subresource_name   = "Sql"
        type               = "cosmosdb"
      }
      EcommerceMongo = {
        target_resource_id = data.azurerm_cosmosdb_account.ecommerce_cosmos_account.id
        fqdns              = null
        subresource_name   = "MongoDB"
        type               = "cosmosdb"
      }
    } : {},

    var.env_short == "u" ? { //private endpoint already created on other envs, to avoid destroy/recreate we conditionally create it only on dev env
      EcommerceMongo = {
        target_resource_id = data.azurerm_cosmosdb_account.ecommerce_cosmos_account.id
        fqdns              = null
        subresource_name   = "MongoDB"
        type               = "cosmosdb"
      }
    } : {}
  )



  # Configurazione dei Linked Services per Azure Cosmos DB in Azure Data Factory.
  # Ogni entry definisce una connessione verso un account Cosmos DB specifico.
  # - connection_string: connection string dell'account Cosmos DB.
  # - database: nome del database Cosmos DB a cui collegarsi.
  # es: GpdPayments = {
  #      connection_string = data.azurerm_cosmosdb_account.gpd_payments_cosmos_account.primary_sql_connection_string
  #      account_name      = data.azurerm_cosmosdb_account.gpd_payments_cosmos_account.name
  #      database         = "TablesDb"
  #    }
  data_factory_linked_services_cosmosdb = {

  }

  # Configurazione dei Linked Services per Azure Blob Storage in Azure Data Factory.
  # Ogni entry definisce una connessione verso un account di archiviazione Blob specifico.
  # - connection_string: stringa di connessione all'account di archiviazione Azure Blob Storage.
  # es: Test = {
  #      connection_string = "asd"
  #    }
  data_factory_linked_services_blob = {

  }


  # Configurazione dei Linked Services per Azure PostgreSQL in Azure Data Factory.
  # Ogni entry definisce una connessione verso un database PostgreSQL specifico,
  # con le credenziali e i parametri di connessione recuperati da Azure Key Vault.
  # - key_vault_id: ID del Key Vault da cui recuperare i segreti.
  # - host_secret_name: nome del segreto contenente l'hostname del server PostgreSQL.
  # - port_secret_name: nome del segreto contenente la porta del server PostgreSQL.
  # - database_secret_name: nome del segreto contenente il nome del database.
  # - username_secret_name: nome del segreto contenente lo username per l'autenticazione.
  # - password_secret_name: nome del segreto contenente la password per l'autenticazione.
  # es: Cruscotto = {
  #        key_vault_id         = data.azurerm_key_vault.cruscotto_kv.id
  #        host_secret_name     = "ls-cruscotto-server"
  #        port_secret_name     = "ls-cruscotto-port"
  #        database_secret_name = "ls-cruscotto-database"
  #        username_secret_name = "ls-cruscotto-username"
  #        password_secret_name = "ls-cruscotto-password"
  #      }
  data_factory_linked_services_postgres = {

  }



  az_api_type_mappings = {
    cosmosdb = {
      data_az_api_type    = "Microsoft.DocumentDB/databaseAccounts@2025-10-15"
      approve_az_api_type = "Microsoft.DocumentDB/databaseAccounts/privateEndpointConnections@2025-10-15"
    }
    storage = {
      data_az_api_type    = "Microsoft.Storage/storageAccounts@2025-08-01"
      approve_az_api_type = "Microsoft.Storage/storageAccounts/privateEndpointConnections@2025-08-01"
    }
    postgres = {
      data_az_api_type    = "Microsoft.Network/privateLinkServices@2022-09-01"
      approve_az_api_type = "Microsoft.Network/privateLinkServices/privateEndpointConnections@2022-09-01"
    }
  }

}

