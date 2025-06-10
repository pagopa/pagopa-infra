resource "azurerm_resource_group" "db_rg" {
  name     = format("%s-db-rg", local.project)
  location = var.location

  tags = module.tag_config.tags
}

data "azurerm_key_vault_secret" "pgres_flex_admin_login" {
  name         = "db-administrator-login"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "pgres_flex_admin_pwd" {
  name         = "db-administrator-login-password"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

# Postgres Flexible Server subnet
module "postgres_flexible_snet" {
  source                                        = "./.terraform/modules/__v3__/subnet"
  name                                          = format("%s-pgres-flexible-snet", local.project)
  address_prefixes                              = var.cidr_subnet_flex_dbms
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

module "postgres_flexible_server" {
  source              = "./.terraform/modules/__v3__/postgres_flexible_server"
  name                = format("%s-flexible-postgresql", local.project)
  location            = azurerm_resource_group.db_rg.location
  resource_group_name = azurerm_resource_group.db_rg.name

  private_endpoint_enabled    = var.pgres_flex_params.pgres_flex_private_endpoint_enabled
  private_dns_zone_id         = var.env_short != "d" ? data.azurerm_private_dns_zone.postgres[0].id : null
  delegated_subnet_id         = var.env_short != "d" ? module.postgres_flexible_snet.id : null
  high_availability_enabled   = var.pgres_flex_params.pgres_flex_ha_enabled
  standby_availability_zone   = var.env_short != "d" ? var.pgres_flex_params.standby_ha_zone : null
  pgbouncer_enabled           = var.pgres_flex_params.pgres_flex_pgbouncer_enabled
  diagnostic_settings_enabled = var.pgres_flex_params.pgres_flex_diagnostic_settings_enabled
  administrator_login         = data.azurerm_key_vault_secret.pgres_flex_admin_login.value
  administrator_password      = data.azurerm_key_vault_secret.pgres_flex_admin_pwd.value

  sku_name                     = var.pgres_flex_params.sku_name
  db_version                   = var.pgres_flex_params.db_version
  storage_mb                   = var.pgres_flex_params.storage_mb
  zone                         = var.pgres_flex_params.zone
  backup_retention_days        = var.pgres_flex_params.backup_retention_days
  geo_redundant_backup_enabled = var.pgres_flex_params.geo_redundant_backup_enabled
  create_mode                  = var.pgres_flex_params.create_mode

  public_network_access_enabled = var.pgres_flex_params.public_network_access_enabled

  log_analytics_workspace_id = var.env_short != "d" ? data.azurerm_log_analytics_workspace.log_analytics.id : null
  custom_metric_alerts       = var.custom_metric_alerts
  alert_action = [
    {
      action_group_id    = data.azurerm_monitor_action_group.email.id
      webhook_properties = null
    },
    {
      action_group_id    = azurerm_monitor_action_group.slack.id
      webhook_properties = null
    }
    # {
    #   action_group_id    = azurerm_monitor_action_group.push.id
    #   webhook_properties = null
    # }
  ]

  private_dns_registration = var.pgres_flex_params.enable_private_dns_registration
  private_dns_zone_name    = "${var.env_short}.internal.postgresql.pagopa.it"
  private_dns_zone_rg_name = data.azurerm_resource_group.rg_vnet.name
  private_dns_record_cname = "nodo-db"


  tags = module.tag_config.tags
}

# Nodo database
resource "azurerm_postgresql_flexible_server_database" "nodo_db" {
  name      = var.pgres_flex_nodo_db_name
  server_id = module.postgres_flexible_server.id
  collation = "en_US.utf8"
  charset   = "utf8"
}

# https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-limits
# DEV D4s_v3 / D4ds_v4	4	16 GiB	1719	1716
# UAT D8s_v3 / D8ds_V4	8	32 GiB	3438	3435

resource "azurerm_postgresql_flexible_server_configuration" "nodo_db_flex_max_connection" {
  name      = "max_connections"
  server_id = module.postgres_flexible_server.id
  value     = var.pgres_flex_params.max_connections
}

# PG bouncer config
# pgbouncer.default_pool_size         How many server connections to allow per user/database pair.
# pgbouncer.ignore_startup_parameters Comma-separated list of parameters that PgBouncer can ignore because they are going to be handled by the admin.
# pgbouncer.max_client_conn           Maximum number of client connections allowed.
# pgbouncer.min_pool_size             Add more server connections to pool if below this number.
# pgbouncer.pool_mode                 Specifies when a server connection can be reused by other clients.
# pgbouncer.query_wait_timeout        Maximum time (in seconds) queries are allowed to spend waiting for execution. If the query is not assigned to a server during that time, the client is disconnected.
# pgbouncer.server_idle_timeout       If a server connection has been idle more than this many seconds it will be dropped. If 0 then timeout is disabled.
# pgbouncer.stats_users               Comma-separated list of database users that are allowed to connect and run read-only queries on the pgBouncer console.

# Message    : FATAL: unsupported startup parameter: extra_float_digits
resource "azurerm_postgresql_flexible_server_configuration" "nodo_db_flex_ignore_startup_parameters" {
  count     = var.pgres_flex_params.pgres_flex_pgbouncer_enabled ? 1 : 0
  name      = "pgbouncer.ignore_startup_parameters"
  server_id = module.postgres_flexible_server.id
  value     = "extra_float_digits,search_path"
}

resource "azurerm_postgresql_flexible_server_configuration" "nodo_db_flex_min_pool_size" {
  count     = var.pgres_flex_params.pgres_flex_pgbouncer_enabled ? 1 : 0
  name      = "pgbouncer.min_pool_size"
  server_id = module.postgres_flexible_server.id
  value     = 500
}
resource "azurerm_postgresql_flexible_server_configuration" "nodo_db_flex_default_pool_size" {
  count     = var.pgres_flex_params.pgres_flex_pgbouncer_enabled ? 1 : 0
  name      = "pgbouncer.default_pool_size"
  server_id = module.postgres_flexible_server.id
  value     = 1000
}


resource "azurerm_postgresql_flexible_server_database" "nodo_replica_db" {
  count     = var.env_short == "p" ? 0 : 1
  name      = "${var.pgres_flex_nodo_db_name}-replica"
  server_id = module.postgres_flexible_server.id
  collation = "en_US.utf8"
  charset   = "utf8"
}
