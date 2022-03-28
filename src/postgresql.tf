module "postgresql_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.7"
  name                                           = format("%s-postgresql-snet", local.project)
  address_prefixes                               = var.cidr_subnet_postgresql
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet.name
  service_endpoints                              = ["Microsoft.Sql"]
  enforce_private_link_endpoint_network_policies = true
}

# Postgres Flexible Server subnet
module "postgres_flexible_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.1.13"
  name                                           = format("%s-pgres-flexible-snet", local.project)
  address_prefixes                               = var.cidr_subnet_flex_dbms
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet.name
  service_endpoints                              = ["Microsoft.Storage"]
  enforce_private_link_endpoint_network_policies = true

  delegation = {
    name = "delegation"
    service_delegation = {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

# KV secrets single server
data "azurerm_key_vault_secret" "db_administrator_login" {
  count        = var.env_short == "d" ? 1 : 0
  name         = "db-administrator-login"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "db_administrator_login_password" {
  count        = var.env_short == "d" ? 1 : 0
  name         = "db-administrator-login-password"
  key_vault_id = module.key_vault.id
}

# KV secrets flex server
data "azurerm_key_vault_secret" "pgres_flex_admin_login" {
  name         = "pgres-flex-admin-login"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "pgres_flex_admin_pwd" {
  name         = "pgres-flex-admin-pwd"
  key_vault_id = module.key_vault.id
}

# DNS private single server
resource "azurerm_private_dns_zone" "privatelink_postgres_database_azure_com" {
  count               = var.postgres_private_endpoint_enabled ? 1 : 0
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_postgres_database_azure_com_vnet" {
  count                 = var.postgres_private_endpoint_enabled ? 1 : 0
  name                  = module.vnet.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_postgres_database_azure_com[0].name
  virtual_network_id    = module.vnet.id
  registration_enabled  = false

  tags = var.tags
}

#tfsec:ignore:azure-database-no-public-access
module "postgresql" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//postgresql_server?ref=v2.0.5"

  name                = format("%s-postgresql", local.project)
  location            = azurerm_resource_group.data.location
  resource_group_name = azurerm_resource_group.data.name

  administrator_login          = data.azurerm_key_vault_secret.db_administrator_login[0].value
  administrator_login_password = data.azurerm_key_vault_secret.db_administrator_login_password[0].value
  sku_name                     = var.postgresql_sku_name
  db_version                   = 11
  geo_redundant_backup_enabled = var.postgresql_geo_redundant_backup_enabled

  public_network_access_enabled = var.postgresql_public_network_access_enabled
  network_rules                 = var.postgresql_network_rules

  private_endpoint = {
    enabled              = var.postgres_private_endpoint_enabled
    virtual_network_id   = module.vnet.id
    subnet_id            = module.postgresql_snet.id
    private_dns_zone_ids = var.postgres_private_endpoint_enabled ? [azurerm_private_dns_zone.privatelink_postgres_database_azure_com[0].id] : []
  }

  enable_replica = var.postgresql_enable_replica
  alerts_enabled = var.postgresql_alerts_enabled
  lock_enable    = var.lock_enable

  tags = var.tags
}

resource "azurerm_postgresql_database" "this" {
  count               = var.env_short == "d" ? 1 : 0
  name                = "mock_psp"
  resource_group_name = azurerm_resource_group.data.name
  server_name         = module.postgresql[0].name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}

resource "azurerm_postgresql_database" "apd_db" {
  count               = var.env_short == "d" ? 1 : 0
  name                = var.gpd_db_name
  resource_group_name = azurerm_resource_group.data.name
  server_name         = module.postgresql[0].name
  charset             = "UTF8"
  collation           = "Italian_Italy.1252"
}

# https://docs.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-compare-single-server-flexible-server
module "postgres_flexible_server" {
  count  = var.env_short != "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//postgres_flexible_server?ref=v2.7.1"

  name                = format("%s-flexible-postgresql", local.project)
  location            = azurerm_resource_group.flex_data.location
  resource_group_name = azurerm_resource_group.flex_data.name

  private_endpoint = {
    enabled   = true
    subnet_id = module.postgres_flexible_snet.id
    private_dns_zone = {
      id   = azurerm_private_dns_zone.postgres.id
      name = azurerm_private_dns_zone.postgres.name
      rg   = azurerm_resource_group.rg_vnet.name
    }
  }

  administrator_login    = data.azurerm_key_vault_secret.pgres_flex_admin_login.value
  administrator_password = data.azurerm_key_vault_secret.pgres_flex_admin_pwd.value

  sku_name                     = var.pgres_flex_params.sku_name
  db_version                   = var.pgres_flex_params.db_version
  storage_mb                   = var.pgres_flex_params.storage_mb
  zone                         = var.pgres_flex_params.zone
  backup_retention_days        = var.pgres_flex_params.backup_retention_days
  geo_redundant_backup_enabled = var.pgres_flex_params.geo_redundant_backup_enabled
  create_mode                  = var.pgres_flex_params.create_mode

  tags = var.tags

  depends_on = [azurerm_private_dns_zone_virtual_network_link.postgres_vnet]

}
