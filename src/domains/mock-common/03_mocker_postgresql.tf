# resource group
resource "azurerm_resource_group" "mock_rg" {
  name     = "${local.product}-mock-rg"
  location = var.location

  tags = var.tags
}

# KV secrets flex server
data "azurerm_key_vault_secret" "psql_admin_user" {
  count        = var.env_short == "d" ? 1 : 0
  name         = "psql-mocker-admin-user"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "psql_admin_pwd" {
  count        = var.env_short == "d" ? 1 : 0
  name         = "psql-mocker-admin-pwd"
  key_vault_id = module.key_vault.id
}

data "azurerm_private_dns_zone" "postgres" {
  count = var.env_short != "d" ? 1 : 0

  name                = "private.postgres.database.azure.com"
  resource_group_name = local.vnet_resource_group_name
}

module "mocker_pgflex_snet" {
  #  count  = var.env_short != "d" ? 1 : 0
  count  = 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//subnet?ref=v6.11.2"

  name                                      = format("%s-mocker-pgflex-snet", local.product)
  address_prefixes                          = var.cidr_subnet_pgflex_dbms
  resource_group_name                       = local.vnet_resource_group_name
  virtual_network_name                      = local.vnet_name
  service_endpoints                         = ["Microsoft.Storage"]
  private_endpoint_network_policies_enabled = false

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

#tfsec:ignore:azure-database-no-public-access
module "mocker_pgflex" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//postgres_flexible_server?ref=v6.11.2"

  name                = format("%s-mocker-pgflex", local.product)
  location            = azurerm_resource_group.mock_rg.location
  resource_group_name = azurerm_resource_group.mock_rg.name

  ### Network
  private_endpoint_enabled = var.pgflex_params.private_endpoint_enabled
  private_dns_zone_id      = var.env_short != "d" ? data.azurerm_private_dns_zone.postgres[0].id : null
  delegated_subnet_id      = var.env_short != "d" ? module.mocker_pgflex_snet[0].id : null

  ### Admin credentials
  administrator_login    = data.azurerm_key_vault_secret.psql_admin_user[0].value
  administrator_password = data.azurerm_key_vault_secret.psql_admin_pwd[0].value

  sku_name                     = var.pgflex_params.sku_name
  db_version                   = var.pgflex_params.db_version
  storage_mb                   = var.pgflex_params.storage_mb
  zone                         = var.pgflex_params.zone
  backup_retention_days        = var.pgflex_params.backup_retention_days
  create_mode                  = null // the update of this argument triggers a replace
  geo_redundant_backup_enabled = var.pgflex_params.geo_redundant_backup_enabled

  high_availability_enabled = var.pgflex_params.high_availability_enabled
  standby_availability_zone = var.pgflex_params.standby_availability_zone
  pgbouncer_enabled         = var.pgflex_params.pgbouncer_enabled

  diagnostic_settings_enabled = false

  tags = var.tags
}

resource "azurerm_postgresql_flexible_server_database" "mocker_pgflex_db" {
  count     = var.env_short == "d" ? 1 : 0
  name      = var.mocker_db_name
  server_id = module.mocker_pgflex[0].id
  collation = "en_US.utf8"
  charset   = "utf8"
}


# Message    : FATAL: unsupported startup parameter: extra_float_digits
resource "azurerm_postgresql_flexible_server_configuration" "mocker_pgflex_db_flex_ignore_startup_parameters" {
  count     = var.env_short == "d" ? 1 : 0
  name      = "pgbouncer.ignore_startup_parameters"
  server_id = module.mocker_pgflex[0].id
  value     = "extra_float_digits"
}

resource "azurerm_postgresql_flexible_server_configuration" "mocker_pgflex_db_flex_min_pool_size" {
  count     = var.env_short == "d" ? 1 : 0
  name      = "pgbouncer.min_pool_size"
  server_id = module.mocker_pgflex[0].id
  value     = 500
}



