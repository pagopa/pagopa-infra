resource "azurerm_resource_group" "portal" {
  name     = "${local.project}-departements-rg"
  location = var.location

  tags = module.tag_config.tags
}


module "postgres_flexible_server" {
  source = "./.terraform/modules/__v4__/IDH/postgres_flexible_server"

  name                = "${local.project}-flexible-postgresql"
  location            = azurerm_resource_group.portal.location
  resource_group_name = azurerm_resource_group.portal.name

  idh_resource_tier = var.pgres_flex_params.idh_resource
  product_name      = var.prefix
  env               = var.env
  databases         = [var.postgres_database_name]

  private_dns_zone_id = data.azurerm_private_dns_zone.privatelink_postgres_database_azure_com.id
  embedded_subnet = {
    enabled      = true
    vnet_name    = local.spoke_data_vnet_name
    vnet_rg_name = local.spoke_data_vnet_resource_group_name
  }

  embedded_nsg_configuration = {
    source_address_prefixes      = ["*"]
    source_address_prefixes_name = local.domain
  }

  administrator_login    = data.azurerm_key_vault_secret.pgres_flex_admin_login.value
  administrator_password = data.azurerm_key_vault_secret.pgres_flex_admin_pwd.value


  diagnostic_settings_enabled = var.pgres_flex_params.pgres_flex_diagnostic_settings_enabled
  log_analytics_workspace_id  = data.azurerm_log_analytics_workspace.log_analytics.id

  alert_action = var.pgres_flex_params.alerts_enabled ? [
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
  private_dns_zone_rg_name = "${local.product}-vnet-rg"
  private_dns_record_cname = "portal-db"


  tags = module.tag_config.tags

  geo_replication = {
    enabled = false
  }

}


resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_azure_services" {
  count = var.allow_azure_services_to_postgres ? 1 : 0

  name             = "allow-azure-services"
  server_id        = module.postgres_flexible_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

