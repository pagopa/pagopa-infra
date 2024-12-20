# ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️
# ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️
# ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️

# NEWGPD-DB : DEPRECATED remove all content file
# Note in DEV and UAT env the old version of GPD db it has already been manually removed from the portal , but not in PROD

# ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️
# ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️
# ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️


# https://docs.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-compare-single-server-flexible-server
module "postgres_flexible_server_private" { # private only into UAT and PROD env
  source = "./.terraform/modules/__v3__/postgres_flexible_server"
  count  = var.env_short == "p" ? 1 : 0 # forced 2 create o delete ( for housekeeping old GPD db)

  name = format("%s-gpd-pgflex", local.product)

  location            = azurerm_resource_group.flex_data[0].location
  resource_group_name = azurerm_resource_group.flex_data[0].name

  ### Network
  private_endpoint_enabled      = var.pgres_flex_params.private_endpoint_enabled
  private_dns_zone_id           = var.env_short != "d" ? data.azurerm_private_dns_zone.postgres[0].id : null
  delegated_subnet_id           = module.postgres_flexible_snet[0].id
  public_network_access_enabled = var.pgres_flex_params.public_network_access_enabled

  ### admin credentials
  administrator_login    = data.azurerm_key_vault_secret.pgres_admin_login.value
  administrator_password = data.azurerm_key_vault_secret.pgres_admin_pwd.value

  sku_name                     = "GP_Standard_D16ds_v4" # var.pgres_flex_params.sku_name # NEWGPD-DB
  db_version                   = "13"                   # var.pgres_flex_params.db_version # NEWGPD-DB
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
  count = var.env_short == "p" ? 1 : 0 # forced

  name      = var.gpd_db_name
  server_id = module.postgres_flexible_server_private[0].id
  collation = "en_US.utf8"
  charset   = "UTF8"
}

resource "azurerm_postgresql_flexible_server_configuration" "apd_db_flex_max_connection" {
  count = var.env_short == "p" ? 1 : 0 # forced

  name      = "max_connections"
  server_id = module.postgres_flexible_server_private[0].id
  value     = var.pgres_flex_params.max_connections
}

# Message    : FATAL: unsupported startup parameter: extra_float_digits
resource "azurerm_postgresql_flexible_server_configuration" "apd_db_flex_ignore_startup_parameters" {
  count = var.env_short == "p" ? 1 : 0 # forced

  name      = "pgbouncer.ignore_startup_parameters"
  server_id = module.postgres_flexible_server_private[0].id
  value     = "extra_float_digits"
}

resource "azurerm_postgresql_flexible_server_configuration" "apd_db_flex_min_pool_size" {
  count = var.env_short == "p" ? 1 : 0 # forced

  name      = "pgbouncer.min_pool_size"
  server_id = module.postgres_flexible_server_private[0].id
  value     = 10
}

# CDC https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-logical
resource "azurerm_postgresql_flexible_server_configuration" "apd_db_flex_max_worker_process" { # NEWGPD-DB : not needed to enable on OLD version
  count = 0                                                                                    # var.pgres_flex_params.wal_level != null && var.env_short == "p" ? 1 : 0 # forced

  name      = "max_worker_processes"
  server_id = module.postgres_flexible_server_private[0].id
  value     = var.pgres_flex_params.max_worker_process # var.env_short == "d" ? 16 : 32
}

resource "azurerm_postgresql_flexible_server_configuration" "apd_db_flex_wal_level" { # NEWGPD-DB : not needed to enable on OLD version
  count = 0                                                                           # var.pgres_flex_params.wal_level != null && var.env_short == "p" ? 1 : 0 # forced ? 1 : 0

  name      = "wal_level"
  server_id = module.postgres_flexible_server_private[0].id
  value     = var.pgres_flex_params.wal_level # "logical", ...
}

resource "azurerm_postgresql_flexible_server_configuration" "apd_db_flex_shared_preoload_libraries" { # NEWGPD-DB : not needed to enable on OLD version
  count = 0                                                                                           # var.pgres_flex_params.wal_level != null && var.env_short == "p" ? 1 : 0

  name      = "shared_preload_libraries"
  server_id = module.postgres_flexible_server_private[0].id
  value     = var.pgres_flex_params.shared_preoload_libraries # "pg_failover_slots"
}
