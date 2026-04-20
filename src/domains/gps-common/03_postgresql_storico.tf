data "azurerm_key_vault_secret" "pgres_storico_admin_login" {
  name         = "pgres-admin-login"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "pgres_storico_admin_pwd" {
  name         = "pgres-admin-pwd"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "pgres_apd_storico_user_login" {
  name         = "pgres-apd-storico-user-login"
  key_vault_id = module.key_vault.id
}

# After applying the first time remember to switch cron.database_name to apd in server parameters
module "postgres_storico_flexible_server_private_db" {
  source = "./.terraform/modules/__v4__/IDH/postgres_flexible_server"

  name                = format("%s-%s-gpd-storico-pgflex", local.product, var.location_itn_short)
  location            = azurerm_resource_group.flex_data_storico.location
  resource_group_name = azurerm_resource_group.flex_data_storico.name

  idh_resource_tier = "pgflex2"
  storage_mb        = var.pgflex_storico_params.storage_mb
  product_name      = var.prefix
  env               = var.env

  private_dns_zone_id = data.azurerm_private_dns_zone.postgres.id
  embedded_subnet = {
    enabled      = true
    vnet_name    = data.azurerm_virtual_network.spoke_data_vnet.name
    vnet_rg_name = data.azurerm_resource_group.rg_spoke_vnet.name
  }

  embedded_nsg_configuration = {
    source_address_prefixes      = ["*"]
    source_address_prefixes_name = var.domain
  }

  administrator_login    = data.azurerm_key_vault_secret.pgres_storico_admin_login.value
  administrator_password = data.azurerm_key_vault_secret.pgres_storico_admin_pwd.value

  databases = [var.gpd_db_storico_name]

  diagnostic_settings_enabled = var.pgflex_storico_params.pgres_flex_diagnostic_settings_enabled
  log_analytics_workspace_id  = data.azurerm_log_analytics_workspace.log_analytics.id

  custom_metric_alerts = var.pgflex_public_metric_alerts

  alert_action = var.pgflex_storico_params.alerts_enabled ? [
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

  private_dns_registration = var.pgflex_storico_params.enable_private_dns_registration
  private_dns_zone_name    = "${var.env_short}.internal.postgresql.pagopa.it"
  private_dns_zone_rg_name = data.azurerm_resource_group.rg_vnet.name
  private_dns_record_cname = "gpd-storico-db"


  tags = local.tags_grafana

  geo_replication = {
    enabled = false
  }

  additional_azure_extensions  = ["pg_partman"]
  additional_preload_libraries = ["pg_partman_bgw"]
}

# Create a secure password
resource "random_password" "pgres_apd_storico_user_password" {
  length  = 32
  special = true
  # Avoid char that could break the Bash/SQL script
  override_special = "#%&*()-_=+[]{}<>:?"
}

# Save pgres_adf_pipeline_pwd
resource "azurerm_key_vault_secret" "pgres_apd_storico_pwd_secret" {
  name         = "pgres-apd-storico-user-pwd"
  value        = random_password.pgres_adf_pipeline_password.result
  key_vault_id = module.key_vault.id
}

provider "postgresql" {
  alias = "historical"

  host      = module.postgres_storico_flexible_server_private_db.fqdn
  port      = 5432
  database  = "apd"
  username  = data.azurerm_key_vault_secret.pgres_storico_admin_login.value
  password  = data.azurerm_key_vault_secret.pgres_storico_admin_pwd.value
  sslmode   = "require"
  superuser = false
}

resource "postgresql_role" "apd_storico_user" {
  provider = postgresql.historical

  name     = data.azurerm_key_vault_secret.pgres_apd_storico_user_login.value
  login    = true
  password = azurerm_key_vault_secret.pgres_apd_storico_pwd_secret.value
}

resource "azurerm_postgresql_flexible_server_configuration" "pg_cron_database" {
  name      = "cron.database_name"
  server_id = module.postgres_storico_flexible_server_private_db.id
  value     = "apd"
}

# Full permission on the apd schema
# resource "postgresql_grant" "flyway_schema_all" {
#   provider = postgresql.historical
#
#   database    = "apd"
#   role        = postgresql_role.apd_storico_user.name
#   schema      = "apd"
#   object_type = "schema"
#   privileges  = ["ALL"]
# }

# Full permissions on ALL existing apd TABLES and VIEWS (Read, Write, Truncate)
# resource "postgresql_grant" "flyway_tables_all" {
#   provider = postgresql.historical
#
#   database    = "apd"
#   role        = postgresql_role.apd_storico_user.name
#   schema      = "apd"
#   object_type = "table"
#   privileges  = ["ALL"]
# }

# Full permissions on apd SEQUENCES
# resource "postgresql_grant" "flyway_sequences_all" {
#   provider = postgresql.historical
#
#   database    = "apd"
#   role        = postgresql_role.apd_storico_user.name
#   schema      = "apd"
#   object_type = "sequence"
#   privileges  = ["ALL"]
# }

# Full permissions on existing apd functions and procedures
# resource "postgresql_grant" "flyway_routines_all" {
#   provider = postgresql.historical
#
#   database    = "apd"
#   role        = postgresql_role.apd_storico_user.name
#   schema      = "apd"
#   object_type = "routine"
#   privileges  = ["ALL"]
# }
