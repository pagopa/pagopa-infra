# review postgreql:
# naming and resource group
# avaibility zones, backup redundancy

# KV secrets flex server
data "azurerm_key_vault_secret" "pgres_admin_login" {
  name         = "pgres-admin-login"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "pgres_admin_pwd" {
  name         = "pgres-admin-pwd"
  key_vault_id = module.key_vault.id
}

data "azurerm_resource_group" "flex_data" {
  count = var.env_short != "d" ? 1 : 0
  name  = format("%s-pgres-flex-rg", local.product)
}

data "azurerm_resource_group" "data" {
  count = var.env_short == "d" ? 1 : 0
  name  = format("%s-data-rg", local.product)
}

# Postgres Flexible Server subnet
module "postgres_flexible_snet" {
  count  = var.env_short != "d" ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//subnet?ref=v6.11.2"

  name                                      = format("%s-pgres-flexible-snet", local.product)
  address_prefixes                          = var.cidr_subnet_pg_flex_dbms
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

data "azurerm_private_dns_zone" "postgres" {
  count = var.env_short != "d" ? 1 : 0

  name                = "private.postgres.database.azure.com"
  resource_group_name = local.vnet_resource_group_name
}

# https://docs.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-compare-single-server-flexible-server
module "postgres_flexible_server_private" {
  count  = var.env_short != "d" ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//postgres_flexible_server?ref=v7.23.0"

  name = format("%s-gpd-pgflex", local.product)

  location            = data.azurerm_resource_group.flex_data[0].location
  resource_group_name = data.azurerm_resource_group.flex_data[0].name

  ### Network
  private_endpoint_enabled = var.pgres_flex_params.private_endpoint_enabled
  private_dns_zone_id      = data.azurerm_private_dns_zone.postgres[0].id
  delegated_subnet_id      = module.postgres_flexible_snet[0].id

  ### admin credentials
  administrator_login    = data.azurerm_key_vault_secret.pgres_admin_login.value
  administrator_password = data.azurerm_key_vault_secret.pgres_admin_pwd.value

  sku_name                     = var.pgres_flex_params.sku_name
  db_version                   = var.pgres_flex_params.db_version
  storage_mb                   = var.pgres_flex_params.storage_mb
  zone                         = var.pgres_flex_params.zone
  backup_retention_days        = var.pgres_flex_params.backup_retention_days
  create_mode                  = null // the update of this argument triggers a replace
  geo_redundant_backup_enabled = var.pgres_flex_params.geo_redundant_backup_enabled

  high_availability_enabled = var.pgres_flex_params.high_availability_enabled
  standby_availability_zone = var.pgres_flex_params.standby_availability_zone
  pgbouncer_enabled         = var.pgres_flex_params.pgbouncer_enabled

  diagnostic_settings_enabled = false

  tags = var.tags

  # alert section
  custom_metric_alerts = var.pgres_flex_params.alerts_enabled ? var.pgflex_public_metric_alerts : {}
  alerts_enabled       = var.pgres_flex_params.alerts_enabled

  alert_action = var.pgres_flex_params.alerts_enabled ? [
    {
      action_group_id    = data.azurerm_monitor_action_group.email.id
      webhook_properties = null
    },
    {
      action_group_id    = data.azurerm_monitor_action_group.slack.id
      webhook_properties = null
    },
    {
      action_group_id    = data.azurerm_monitor_action_group.opsgenie[0].id
      webhook_properties = null
    }
  ] : []

  private_dns_registration = var.pgres_flex_params.enable_private_dns_registration
  private_dns_zone_name    = "${var.env_short}.internal.postgresql.pagopa.it"
  private_dns_zone_rg_name = data.azurerm_resource_group.rg_vnet.name
  private_dns_record_cname = "gpd-db"
}

resource "azurerm_postgresql_flexible_server_database" "apd_db_flex" {
  count     = var.env_short != "d" ? 1 : 0
  name      = var.gpd_db_name
  server_id = module.postgres_flexible_server_private[0].id
  collation = "en_US.utf8"
  charset   = "utf8"
}

resource "azurerm_postgresql_flexible_server_configuration" "apd_db_flex_max_connection" {
  count     = var.env_short != "d" ? 1 : 0
  name      = "max_connections"
  server_id = module.postgres_flexible_server_private[0].id
  value     = var.pgres_flex_params.max_connections
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

########################################################################################################################
########################################### POSTGRES DEV ###############################################################
########################################################################################################################

module "postgresql_snet" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//subnet?ref=v6.11.2"

  name                                      = format("%s-gpd-postgresql-snet", local.product)
  address_prefixes                          = var.cidr_subnet_pg_flex_dbms
  resource_group_name                       = local.vnet_resource_group_name
  virtual_network_name                      = local.vnet_name
  service_endpoints                         = ["Microsoft.Sql"]
  private_endpoint_network_policies_enabled = false

  delegation = {
    name = "delegation"
    service_delegation = {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

#tfsec:ignore:azure-database-no-public-access
module "postgresql" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//postgresql_server?ref=v6.11.2"

  name                = format("%s-gpd-postgresql", local.product)
  location            = azurerm_resource_group.gpd_rg.location
  resource_group_name = azurerm_resource_group.gpd_rg.name

  administrator_login          = data.azurerm_key_vault_secret.pgres_admin_login.value
  administrator_login_password = data.azurerm_key_vault_secret.pgres_admin_pwd.value

  sku_name                     = "B_Gen5_1"
  db_version                   = 11
  geo_redundant_backup_enabled = false

  public_network_access_enabled = false
  network_rules                 = var.postgresql_network_rules

  private_endpoint = {
    enabled              = false
    virtual_network_id   = data.azurerm_virtual_network.vnet.id
    subnet_id            = module.postgresql_snet[0].id
    private_dns_zone_ids = []
  }

  enable_replica = false
  alerts_enabled = false
  lock_enable    = false

  tags = var.tags
}

resource "azurerm_postgresql_database" "apd_db" {
  count               = var.env_short == "d" ? 1 : 0
  name                = var.gpd_db_name
  resource_group_name = azurerm_resource_group.gpd_rg.name
  server_name         = module.postgresql[0].name
  charset             = "UTF8"
  collation           = "Italian_Italy.1252"
}
