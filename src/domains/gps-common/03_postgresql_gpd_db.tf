# KV secrets flex server
data "azurerm_key_vault_secret" "pgres_admin_login" {
  name         = "pgres-admin-login"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "pgres_admin_pwd" {
  name         = "pgres-admin-pwd"
  key_vault_id = module.key_vault.id
}

resource "azurerm_resource_group" "flex_data" {
  count = 1 # forced ( before exits only in UAT and PROD now DEV too)

  name = format("%s-pgres-flex-rg", local.product)

  location = var.location
  tags     = module.tag_config.tags
}

resource "azurerm_resource_group" "flex_data_storico" {
  name = format("%s-pgres-flex-storico-rg", local.product)

  location = var.location_itn
  tags     = module.tag_config.tags
}

data "azurerm_resource_group" "data" {
  name = format("%s-data-rg", local.product)
}

# Postgres Flexible Server subnet
module "postgres_flexible_snet" {
  source = "./.terraform/modules/__v4__/subnet"

  count = 1 # forced ( before exits only in UAT and PROD now DEV too)

  name                              = format("%s-pgres-flexible-snet", local.product)
  address_prefixes                  = var.cidr_subnet_pg_flex_dbms
  resource_group_name               = local.vnet_resource_group_name
  virtual_network_name              = local.vnet_name
  service_endpoints                 = ["Microsoft.Storage"]
  private_endpoint_network_policies = "Disabled"

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
  name                = "private.postgres.database.azure.com"
  resource_group_name = local.vnet_resource_group_name
}

########
########
# https://docs.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-compare-single-server-flexible-server
module "postgres_flexible_server_private_db" {
  source = "./.terraform/modules/__v4__/postgres_flexible_server"

  name = format("%s-%s-gpd-pgflex", local.product, var.location_short)

  location            = azurerm_resource_group.flex_data[0].location
  resource_group_name = azurerm_resource_group.flex_data[0].name

  ### Network
  private_endpoint_enabled      = var.pgres_flex_params.private_endpoint_enabled
  private_dns_zone_id           = var.env_short != "d" ? data.azurerm_private_dns_zone.postgres.id : null
  delegated_subnet_id           = module.postgres_flexible_snet[0].id
  public_network_access_enabled = var.pgres_flex_params.public_network_access_enabled

  ### admin credentials
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

  tags = module.tag_config.tags

  # alert section
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

resource "azurerm_postgresql_flexible_server_database" "pg_charset" {
  name      = var.gpd_db_name
  server_id = module.postgres_flexible_server_private_db.id
  collation = "en_US.utf8"
  charset   = "UTF8"
}

resource "azurerm_postgresql_flexible_server_configuration" "pg_max_connections" {
  name      = "max_connections"
  server_id = module.postgres_flexible_server_private_db.id
  value     = var.pgres_flex_params.max_connections
}

# Message    : FATAL: unsupported startup parameter: extra_float_digits
resource "azurerm_postgresql_flexible_server_configuration" "pd_pgbouncer_ignore_startup_parameters" {
  name      = "pgbouncer.ignore_startup_parameters"
  server_id = module.postgres_flexible_server_private_db.id
  value     = "extra_float_digits"
}

resource "azurerm_postgresql_flexible_server_configuration" "pg_pgbouncer_min_pool_size" {
  name      = "pgbouncer.min_pool_size"
  server_id = module.postgres_flexible_server_private_db.id
  value     = 10
}

# CDC https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-logical
resource "azurerm_postgresql_flexible_server_configuration" "pg_max_worker_processes" {
  name      = "max_worker_processes"
  server_id = module.postgres_flexible_server_private_db.id
  value     = var.pgres_flex_params.max_worker_process # var.env_short == "d" ? 16 : 32
}

resource "azurerm_postgresql_flexible_server_configuration" "pg_wal_level" {
  count = var.pgres_flex_params.wal_level != null ? 1 : 0

  name      = "wal_level"
  server_id = module.postgres_flexible_server_private_db.id
  value     = var.pgres_flex_params.wal_level # "logical", ...
}

resource "azurerm_postgresql_flexible_server_configuration" "pg_shared_preload_libraries" {
  count = var.pgres_flex_params.wal_level != null ? 1 : 0

  name      = "shared_preload_libraries"
  server_id = module.postgres_flexible_server_private_db.id
  value     = var.pgres_flex_params.shared_preoload_libraries # "pg_failover_slots"
}


resource "azurerm_portal_dashboard" "debt_position_postgresql_dashboard" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "debt-position-postgresql-db-usage"
  resource_group_name = var.monitor_resource_group_name
  location            = var.location
  tags = {
    source = "terraform"
  }
  #convert json dashboard output from Azure export function to the one handled by azurerm portal dashboard provider
  #see https://github.com/hashicorp/terraform-provider-azurerm/issues/27117 issue for more info
  dashboard_properties = jsonencode(
    merge(
      jsondecode(templatefile("dashboards/debt-positions-postgres-db-usage.json", {
        resourceId   = module.postgres_flexible_server_private_db.name,
        resourceName = module.postgres_flexible_server_private_db.id
      })),
      {
        "lenses" = {
          for lens_index, lens in jsondecode(templatefile("dashboards/debt-positions-postgres-db-usage.json", {
            resourceId   = module.postgres_flexible_server_private_db.id,
            resourceName = module.postgres_flexible_server_private_db.name
          })).lenses :
          tostring(lens_index) => merge(lens, {
            "parts" = {
              for part_index, part in lens.parts :
              tostring(part_index) => part
            }
          })
        }
      }
    )
  )
}
