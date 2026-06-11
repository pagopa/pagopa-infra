resource "azurerm_resource_group" "db_rg" {
  name     = "${local.project}-db-rg"
  location = var.location

  tags = module.tag_config.tags
}

data "azurerm_key_vault_secret" "pgres_flex_admin_login" {
  name         = "db-administrator-login"
  key_vault_id = data.azurerm_key_vault.domain_kv.id
}

data "azurerm_key_vault_secret" "pgres_flex_admin_pwd" {
  name         = "db-administrator-login-password"
  key_vault_id = data.azurerm_key_vault.domain_kv.id
}


module "postgres_flexible_server_qa" {
  source = "./.terraform/modules/__v4__/IDH/postgres_flexible_server"

  name                = "${local.project}-flexible-postgresql"
  location            = azurerm_resource_group.db_rg.location
  resource_group_name = azurerm_resource_group.db_rg.name

  env               = var.env
  idh_resource_tier = var.pgres_flex_params.idh_resource_tier
  product_name      = local.prefix

  embedded_subnet = {
    enabled              = true
    vnet_name            = local.spoke_data_vnet_name
    vnet_rg_name         = local.spoke_data_vnet_resource_group_name
  }

  #fixme configure the cidr list and service name allowed on this database
  embedded_nsg_configuration = {
    source_address_prefixes      = ["*"]
    source_address_prefixes_name = local.domain
  }

  private_dns_zone_id = data.azurerm_private_dns_zone.postgres.id


  administrator_login    = data.azurerm_key_vault_secret.pgres_flex_admin_login.value
  administrator_password = data.azurerm_key_vault_secret.pgres_flex_admin_pwd.value

  diagnostic_settings_enabled = var.pgres_flex_params.pgres_flex_diagnostic_settings_enabled
  log_analytics_workspace_id  = var.env_short != "d" ? data.azurerm_log_analytics_workspace.log_analytics_workspace.id : null

  custom_metric_alerts = var.postgres_custom_metric_alerts

  alert_action = concat(
  [
    {
      action_group_id    = data.azurerm_monitor_action_group.email.id
      webhook_properties = null
    },
    {
      action_group_id    = data.azurerm_monitor_action_group.slack.id
      webhook_properties = null
    }
  ], var.alert_use_opsgenie ? [
    {
      action_group_id    = data.azurerm_monitor_action_group.opsgenie[0].id
      webhook_properties = null
    }
  ] : [])

  databases = var.pgres_flex_db_names

  private_dns_registration = var.postgres_dns_registration_enabled
  private_dns_zone_name    = "${var.env_short}.internal.postgresql.pagopa.it"
  private_dns_zone_rg_name = local.private_dns_zone_rg_name
  private_dns_record_cname = "${local.domain}-db"

  tags = module.tag_config.tags
}