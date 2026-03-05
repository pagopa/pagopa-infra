data "azurerm_private_link_service" "vmss_pls" {
  name                = "${local.product_network}-privatelink"
  resource_group_name = "${local.product_network}-vmss-rg"
}

data "azurerm_key_vault_secret" "database_proxy_fqdn" {
  name         = "${var.prefix}-${var.env_short}-${var.location_short}-network-database-map"
  key_vault_id = data.azurerm_key_vault.network_kv.id
}

data "azurerm_cosmosdb_account" "bizevent_cosmos_account" {
  name                = "pagopa-${var.env_short}-${var.location_short}-bizevents-ds-cosmos-account"
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-bizevents-rg"
}

data "azurerm_cosmosdb_account" "gpd_payments_cosmos_account" {
  name                = "pagopa-d-weu-gps-cosmos-account"
  resource_group_name = "pagopa-d-weu-gps-rg"
}


## DF_4_blob_sa
data "azurerm_storage_account" "observ_storage_account" {
  name                = "pagopa${var.env_short}${var.location_short_itn}observsa" # pagopa<ENV>itnobservsa
  resource_group_name = "pagopa-${var.env_short}-${var.location_short_itn}-observ-st-rg"
}

data "azurerm_storage_account" "audit_storage_account" {
  name                = "pagopaditnaudittmpst" # pagopa<ENV>itnobservsa
  resource_group_name = "pagopa-d-itn-audit-rg"
}

## DF_4_cosmos_afm
data "azurerm_cosmosdb_account" "afm_cosmos_account" {
  name                = "pagopa-${var.env_short}-${var.location_short}-afm-marketplace-cosmos-account"
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-afm-rg"
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
