# review postgreql:
# naming and resource group
# avaibility zones, backup redundancy

resource "azurerm_resource_group" "flex_data" {
  count = var.env_short != "d" ? 1 : 0

  name     = format("%s-pgres-flex-rg", local.project)
  location = var.location

  tags = var.tags
}

# Postgres Flexible Server subnet
module "postgres_flexible_snet" {
  count  = var.env_short != "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.1.13"

  name                                           = format("%s-pgres-flexible-snet", local.project)
  address_prefixes                               = var.cidr_subnet_pg_flex_dbms
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

# KV secrets flex server
data "azurerm_key_vault_secret" "pgres_flex_admin_login" {
  name         = "pgres-flex-admin-login"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "pgres_flex_admin_pwd" {
  name         = "pgres-flex-admin-pwd"
  key_vault_id = module.key_vault.id
}

# https://docs.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-compare-single-server-flexible-server
module "postgres_flexible_server_private" {
  count  = var.env_short != "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//postgres_flexible_server?ref=v2.8.1"

  name = format("%s-gpd-pgflex", local.project)

  location            = azurerm_resource_group.flex_data[0].location
  resource_group_name = azurerm_resource_group.flex_data[0].name

  ### Network
  private_endpoint_enabled = var.pgres_flex_params.private_endpoint_enabled
  private_dns_zone_id      = azurerm_private_dns_zone.postgres[0].id
  delegated_subnet_id      = module.postgres_flexible_snet[0].id

  ### admin credentials
  administrator_login    = data.azurerm_key_vault_secret.pgres_flex_admin_login.value
  administrator_password = data.azurerm_key_vault_secret.pgres_flex_admin_pwd.value

  sku_name                     = var.pgres_flex_params.sku_name
  db_version                   = var.pgres_flex_params.db_version
  storage_mb                   = var.pgres_flex_params.storage_mb
  zone                         = var.pgres_flex_params.zone
  backup_retention_days        = var.pgres_flex_params.backup_retention_days
  geo_redundant_backup_enabled = var.pgres_flex_params.geo_redundant_backup_enabled

  high_availability_enabled = var.pgres_flex_params.high_availability_enabled
  standby_availability_zone = var.pgres_flex_params.standby_availability_zone
  pgbouncer_enabled         = var.pgres_flex_params.pgbouncer_enabled

  tags = var.tags

}

resource "azurerm_postgresql_flexible_server_database" "apd_db_flex" {
  count     = var.env_short != "d" ? 1 : 0
  name      = var.gpd_db_name
  server_id = module.postgres_flexible_server_private[0].id
  collation = "en_US.utf8"
  charset   = "utf8"
}

# Message    : FATAL: unsupported startup parameter: extra_float_digits
resource "azurerm_postgresql_flexible_server_configuration" "apd_db_flex_ignore_startup_parameters" {
  count     = var.env_short != "d" ? 1 : 0
  name      = "pgbouncer.ignore_startup_parameters"
  server_id = module.postgres_flexible_server_private[0].id
  value     = "extra_float_digits"
}

resource "azurerm_postgresql_flexible_server_configuration" "apd_db_flex_min_pool_size" {
  count     = var.env_short != "d" ? 1 : 0
  name      = "pgbouncer.min_pool_size"
  server_id = module.postgres_flexible_server_private[0].id
  value     = 10
}
