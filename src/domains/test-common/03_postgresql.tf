resource "azurerm_resource_group" "db_rg" {
  name     = "${local.product}-test-rg"
  location = var.location

  tags = var.tags
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
  source                                        = "./.terraform/modules/__v4__/IDH/subnet"
  name                                          = "${local.product}-test-idh-snet"
  resource_group_name                           = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name                          = data.azurerm_virtual_network.vnet.name
  service_endpoints                             = ["Microsoft.Storage"]

  idh_resource = "postgres_flexible"
  prefix = var.prefix
  env = var.env

}

module "postgres_flexible_server_fdr" {
  source = "./.terraform/modules/__v4__/IDH/postgres_flexible_server"

  name                = "${local.project}-flexible-postgresql-idh"
  location            = azurerm_resource_group.db_rg.location
  resource_group_name = azurerm_resource_group.db_rg.name

  idh_resource = "pgflex2"
  prefix = var.prefix
  env = var.env

  private_dns_zone_id           = var.env_short != "d" ? data.azurerm_private_dns_zone.postgres[0].id : null
  delegated_subnet_id           = module.postgres_flexible_snet.id

  administrator_login    = data.azurerm_key_vault_secret.pgres_flex_admin_login.value
  administrator_password = data.azurerm_key_vault_secret.pgres_flex_admin_pwd.value


  diagnostic_settings_enabled = var.pgres_flex_params.pgres_flex_diagnostic_settings_enabled
  log_analytics_workspace_id  = data.azurerm_log_analytics_workspace.log_analytics.id

  custom_metric_alerts = var.custom_metric_alerts

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

  private_dns_registration = var.postgres_dns_registration_enabled
  private_dns_zone_name    = "${var.env_short}.internal.postgresql.pagopa.it"
  private_dns_zone_rg_name = data.azurerm_resource_group.rg_vnet.name
  private_dns_record_cname = "fdr-db"


  tags = var.tags

  geo_replication = {
    enabled = false
    name = "test-replica"
    subnet_id = module.postgres_flexible_snet.id
    location = "westeurope"
    private_dns_registration_ve = true
  }

}
