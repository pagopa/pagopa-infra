# Postgres Flexible Server subnet
module "postgres_flexible_snet_archive" {
  source = "./.terraform/modules/__v4__/subnet"

  count                                         = var.pgres_flex_archive_params.enabled ? 1 : 0
  name                                          = "${local.project}-archive-pgres-flexible-snet"
  address_prefixes                              = var.cidr_subnet_flex_dbms_archive
  resource_group_name                           = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name                          = data.azurerm_virtual_network.vnet.name
  service_endpoints                             = ["Microsoft.Storage"]
  private_link_service_network_policies_enabled = true

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

module "postgres_flexible_server_fdr_archive" {
  source = "./.terraform/modules/__v4__/postgres_flexible_server"

  count               = var.pgres_flex_archive_params.enabled ? 1 : 0
  name                = "${local.project}-archive-flexible-postgresql"
  location            = azurerm_resource_group.db_rg.location
  resource_group_name = azurerm_resource_group.db_rg.name

  private_endpoint_enabled      = var.pgres_flex_archive_params.pgres_flex_private_endpoint_enabled
  private_dns_zone_id           = data.azurerm_private_dns_zone.postgres.id
  delegated_subnet_id           = module.postgres_flexible_snet_archive[0].id
  public_network_access_enabled = var.pgres_flex_archive_params.public_network_access_enabled

  administrator_login    = data.azurerm_key_vault_secret.pgres_flex_admin_login.value
  administrator_password = data.azurerm_key_vault_secret.pgres_flex_admin_pwd.value

  sku_name                     = var.pgres_flex_archive_params.sku_name
  db_version                   = var.pgres_flex_archive_params.db_version
  storage_mb                   = var.pgres_flex_archive_params.storage_mb
  zone                         = var.pgres_flex_archive_params.zone
  backup_retention_days        = var.pgres_flex_archive_params.backup_retention_days
  create_mode                  = var.pgres_flex_archive_params.create_mode
  geo_redundant_backup_enabled = var.pgres_flex_archive_params.geo_redundant_backup_enabled

  high_availability_enabled = var.pgres_flex_archive_params.pgres_flex_ha_enabled
  standby_availability_zone = var.pgres_flex_archive_params.standby_zone
  pgbouncer_enabled         = var.pgres_flex_archive_params.pgres_flex_pgbouncer_enabled

  diagnostic_settings_enabled = var.pgres_flex_archive_params.pgres_flex_diagnostic_settings_enabled
  log_analytics_workspace_id  = var.env_short != "d" ? data.azurerm_log_analytics_workspace.log_analytics.id : null

  custom_metric_alerts = var.custom_metric_alerts
  alerts_enabled       = var.pgres_flex_archive_params.alerts_enabled

  alert_action = var.pgres_flex_archive_params.alerts_enabled ? [
    {
      action_group_id    = data.azurerm_monitor_action_group.email.id
      webhook_properties = null
    },
    {
      action_group_id    = data.azurerm_monitor_action_group.slack.id
      webhook_properties = null
    }
  ] : []

  private_dns_registration = var.postgres_dns_registration_enabled
  private_dns_zone_name    = "${var.env_short}.internal.postgresql.pagopa.it"
  private_dns_zone_rg_name = data.azurerm_resource_group.rg_vnet.name
  private_dns_record_cname = "fdr-archive-db"

  tags = module.tag_config.tags
}

# FdR database
resource "azurerm_postgresql_flexible_server_database" "fdr3_archive_db" {
  count     = var.pgres_flex_archive_params.enabled ? 1 : 0
  name      = "fdr3"
  server_id = module.postgres_flexible_server_fdr_archive[0].id
  collation = "en_US.utf8"
  charset   = "utf8"
}

# https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-limits
# DEV D4s_v3 / D4ds_v4	4	16 GiB	1719	1716
# UAT D8s_v3 / D8ds_V4	8	32 GiB	3438	3435

resource "azurerm_postgresql_flexible_server_configuration" "fdr_archive_db_flex_max_connection" {
  count     = var.pgres_flex_archive_params.enabled ? 1 : 0
  name      = "max_connections"
  server_id = module.postgres_flexible_server_fdr_archive[0].id
  value     = var.pgres_flex_archive_params.max_connections
}

# Message    : FATAL: unsupported startup parameter: extra_float_digits
resource "azurerm_postgresql_flexible_server_configuration" "fdr_archive_db_flex_ignore_startup_parameters" {
  count     = var.pgres_flex_archive_params.enabled && var.pgres_flex_archive_params.pgres_flex_pgbouncer_enabled ? 1 : 0
  name      = "pgbouncer.ignore_startup_parameters"
  server_id = module.postgres_flexible_server_fdr_archive[0].id
  value     = "extra_float_digits,search_path"
}

resource "azurerm_postgresql_flexible_server_configuration" "fdr_archive_db_flex_min_pool_size" {
  count     = var.pgres_flex_archive_params.enabled && var.pgres_flex_archive_params.pgres_flex_pgbouncer_enabled ? 1 : 0
  name      = "pgbouncer.min_pool_size"
  server_id = module.postgres_flexible_server_fdr_archive[0].id
  value     = var.pgres_flex_archive_params.pgbouncer_min_pool_size
}

# CDC https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-logical
resource "azurerm_postgresql_flexible_server_configuration" "fdr_archive_db_flex_max_worker_process" {
  count     = var.pgres_flex_archive_params.enabled ? 1 : 0
  name      = "max_worker_processes"
  server_id = module.postgres_flexible_server_fdr_archive[0].id
  value     = var.pgres_flex_archive_params.max_worker_process # var.env_short == "d" ? 16 : 32
}

resource "azurerm_postgresql_flexible_server_configuration" "fdr_archive_db_flex_wal_level" {
  count     = var.pgres_flex_archive_params.enabled && var.pgres_flex_archive_params.wal_level != null ? 1 : 0
  name      = "wal_level"
  server_id = module.postgres_flexible_server_fdr_archive[0].id
  value     = var.pgres_flex_archive_params.wal_level # "logical", ...
}

resource "azurerm_postgresql_flexible_server_configuration" "fdr_archive_db_flex_shared_preload_libraries" {
  count     = var.pgres_flex_archive_params.enabled && var.pgres_flex_archive_params.wal_level != null ? 1 : 0
  name      = "shared_preload_libraries"
  server_id = module.postgres_flexible_server_fdr_archive[0].id
  value     = var.pgres_flex_archive_params.shared_preload_libraries # "pg_failover_slots"
}

resource "azurerm_postgresql_flexible_server_configuration" "fdr_archive_db_flex_extensions" {
  count     = var.pgres_flex_archive_params.enabled ? 1 : 0
  name      = "azure.extensions"
  server_id = module.postgres_flexible_server_fdr_archive[0].id
  value     = var.pgres_flex_archive_params.azure_extensions
}

# configure pg_cron to use fdr3 database (:warning: needs restart)
resource "azurerm_postgresql_flexible_server_configuration" "fdr_archive_pg_cron_database" {
  count     = var.pgres_flex_archive_params.enabled ? 1 : 0
  name      = "cron.database_name"
  server_id = module.postgres_flexible_server_fdr_archive[0].id
  value     = "postgres"
}
