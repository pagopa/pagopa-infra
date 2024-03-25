# KV secrets flex server
data "azurerm_key_vault_secret" "pgflex_smo_admin_usr" {
  name         = "pgflex-smo-admin-usr"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "pgflex_smo_admin_pwd" {
  name         = "pgflex-smo-admin-pwd"
  key_vault_id = module.key_vault.id
}


# Postgres Flexible Server subnet
module "postgres_flexible_smo_snet" {
  count  = var.env_short != "p" ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//subnet?ref=v6.11.2"

  name                                      = format("%s-pgres-flexible-smo-snet", local.product)
  address_prefixes                          = var.cidr_subnet_pg_flex_smo_dbms
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

resource "azurerm_resource_group" "flex_smo_data" {
  count = var.env_short != "p" ? 1 : 0

  name     = format("%s-pgres-flex-smo-rg", local.product)
  location = var.location_alt
  # location  = var.location
  tags = var.tags
}

# https://docs.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-compare-single-server-flexible-server
module "postgres_flexible_server_private" {
  count  = var.env_short != "p" ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//postgres_flexible_server?ref=v7.23.0"

  name = format("%s-smo-pgflex", local.product)

  location            = azurerm_resource_group.flex_smo_data[0].location
  resource_group_name = azurerm_resource_group.flex_smo_data[0].name

  ### Network
  private_endpoint_enabled = var.pgres_flex_smo_params.private_endpoint_enabled
  private_dns_zone_id      = var.env_short != "d" ? data.azurerm_private_dns_zone.postgres[0].id : null
  delegated_subnet_id      = module.postgres_flexible_smo_snet[0].id

  ### admin credentials
  administrator_login    = data.azurerm_key_vault_secret.pgflex_smo_admin_usr.value
  administrator_password = data.azurerm_key_vault_secret.pgflex_smo_admin_pwd.value

  sku_name                     = var.pgres_flex_smo_params.sku_name
  db_version                   = var.pgres_flex_smo_params.db_version
  storage_mb                   = var.pgres_flex_smo_params.storage_mb
  zone                         = var.pgres_flex_smo_params.zone
  backup_retention_days        = var.pgres_flex_smo_params.backup_retention_days
  create_mode                  = null // the update of this argument triggers a replace
  geo_redundant_backup_enabled = var.pgres_flex_smo_params.geo_redundant_backup_enabled

  high_availability_enabled = var.pgres_flex_smo_params.high_availability_enabled
  standby_availability_zone = var.pgres_flex_smo_params.standby_availability_zone
  pgbouncer_enabled         = var.pgres_flex_smo_params.pgbouncer_enabled

  diagnostic_settings_enabled = false

  tags = var.tags

  # alert section
  custom_metric_alerts = var.pgres_flex_smo_params.alerts_enabled ? var.pgflex_smo_public_metric_alerts : {}
  alerts_enabled       = var.pgres_flex_smo_params.alerts_enabled

  alert_action = var.pgres_flex_smo_params.alerts_enabled ? [
    {
      action_group_id    = data.azurerm_monitor_action_group.email.id
      webhook_properties = null
    },
    {
      action_group_id    = data.azurerm_monitor_action_group.slack.id
      webhook_properties = null
    },
    # {
    #   action_group_id    = data.azurerm_monitor_action_group.opsgenie[0].id
    #   webhook_properties = null
    # }
  ] : []

  private_dns_registration = var.pgres_flex_smo_params.enable_private_dns_registration
  private_dns_zone_name    = "${var.env_short}.internal.postgresql.pagopa.it"
  private_dns_zone_rg_name = local.vnet_resource_group_name
  private_dns_record_cname = "smo-db"
}

resource "azurerm_postgresql_flexible_server_database" "smo_db_flex" {
  count     = var.env_short != "p" ? 1 : 0
  name      = "smodb"
  server_id = module.postgres_flexible_server_private[0].id
  collation = "en_US.utf8"
  charset   = "utf8"
}

# resource "azurerm_postgresql_flexible_server_configuration" "smo_db_flex_max_connection" {
#   count     = var.env_short == "p" ? 1 : 0
#   name      = "max_connections"
#   server_id = module.postgres_flexible_server_private[0].id
#   value     = var.pgres_flex_smo_params.max_connections
# }

# # Message    : FATAL: unsupported startup parameter: extra_float_digits
# resource "azurerm_postgresql_flexible_server_configuration" "smo_db_flex_ignore_startup_parameters" {
#   count     = var.env_short == "p" ? 1 : 0
#   name      = "pgbouncer.ignore_startup_parameters"
#   server_id = module.postgres_flexible_server_private[0].id
#   value     = "extra_float_digits"
# }

# resource "azurerm_postgresql_flexible_server_configuration" "smo_db_flex_min_pool_size" {
#   count     = var.env_short == "p" ? 1 : 0
#   name      = "pgbouncer.min_pool_size"
#   server_id = module.postgres_flexible_server_private[0].id
#   value     = 10
# }
