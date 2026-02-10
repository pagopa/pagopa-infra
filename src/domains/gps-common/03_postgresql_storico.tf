data "azurerm_key_vault_secret" "pgres_storico_admin_login" {
  name         = "pgres-admin-login"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "pgres_storico_admin_pwd" {
  name         = "pgres-admin-pwd"
  key_vault_id = module.key_vault.id
}

# Postgres Flexible Server subnet
module "postgres_storico_flexible_snet" {
  source               = "./.terraform/modules/__v4__/IDH/subnet"
  name                 = format("%s-storico-pgres-flexible-snet", local.product)
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  service_endpoints    = ["Microsoft.Storage"]

  idh_resource_tier = "postgres_flexible"
  product_name      = var.prefix
  env               = var.env

  tags = module.tag_config.tags
}

module "postgres_storico_flexible_server_private_db" {
  source = "./.terraform/modules/__v4__/IDH/postgres_flexible_server"

  name                = format("%s-%s-gpd-storico-pgflex", local.product, var.location_short)
  location            = azurerm_resource_group.flex_data[0].location
  resource_group_name = azurerm_resource_group.flex_data[0].name

  idh_resource_tier = "pgflex2"
  product_name      = var.prefix
  env               = var.env

  private_dns_zone_id = var.env_short != "d" ? data.azurerm_private_dns_zone.postgres.id : null
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

  custom_metric_alerts = var.pgflex_storico_public_metric_alerts

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


  tags = module.tag_config.tags

  geo_replication = {
    enabled                     = var.pgflex_storico_geo_replication.enabled
    name                        = var.pgflex_storico_geo_replication.name
    subnet_id                   = module.postgres_flexible_snet[0].id
    location                    = var.pgflex_storico_geo_replication.location
    private_dns_registration_ve = var.pgflex_storico_geo_replication.private_dns_registration_ve
  }
}

