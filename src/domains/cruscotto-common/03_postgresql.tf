resource "azurerm_resource_group" "db_rg" {
  name     = "${local.project}-db-rg"
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


# Postgres Flexible Server subnet Hub&Spoke
module "postgres_flexible_hub_spoke_snet" {
  source               = "./.terraform/modules/__v4__/IDH/subnet"
  name                 = "${local.project}-data-spoke-pgres-flexible-snet"
  resource_group_name  = data.azurerm_virtual_network.spoke_data_vnet.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.spoke_data_vnet.name
  service_endpoints    = ["Microsoft.Storage"]
  product_name         = var.prefix

  env               = var.env
  idh_resource_tier = "postgres_flexible"

  tags = module.tag_config.tags
}

module "postgres_flexible_server_crus8" {
  source = "./.terraform/modules/__v4__/IDH/postgres_flexible_server"

  name                = "${local.project}-flexible-postgresql"
  location            = azurerm_resource_group.db_rg.location
  resource_group_name = azurerm_resource_group.db_rg.name

  env               = var.env_short != "p" ? var.env : "uat" # ⚠️⚠️⚠️ Italy : Cannot create a server with geo-redundant backup enabled in this location
  idh_resource_tier = var.pgres_flex_params.idh_resource
  product_name      = var.prefix

  private_dns_zone_id = var.env_short != "d" ? data.azurerm_private_dns_zone.postgres.id : null
  delegated_subnet_id = module.postgres_flexible_hub_spoke_snet.id

  administrator_login    = data.azurerm_key_vault_secret.pgres_flex_admin_login.value
  administrator_password = data.azurerm_key_vault_secret.pgres_flex_admin_pwd.value

  diagnostic_settings_enabled = var.pgres_flex_params.pgres_flex_diagnostic_settings_enabled
  log_analytics_workspace_id  = var.env_short != "d" ? data.azurerm_log_analytics_workspace.log_analytics_italy.id : null

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

  databases = var.pgres_flex_db_names

  private_dns_registration = var.postgres_dns_registration_enabled
  private_dns_zone_name    = "${var.env_short}.internal.postgresql.pagopa.it"
  private_dns_zone_rg_name = data.azurerm_resource_group.rg_vnet.name
  private_dns_record_cname = "crusc8-db"

  tags = module.tag_config.tags

}
