resource "azurerm_resource_group" "flex_data_archive" {
  name = format("%s-pgres-flex-archive-rg", local.product)

  location = var.location_itn
  tags     = module.tag_config.tags
}

module "postgres_flexible_server_fdr_archive" {
  source = "./.terraform/modules/__v4__/IDH/postgres_flexible_server"

  name                = format("%s-%s-fdr-archive-pgflex", local.product, var.location_itn_short)
  location            = azurerm_resource_group.flex_data_archive.location
  resource_group_name = azurerm_resource_group.flex_data_archive.name

  idh_resource_tier = "pgflex2"
  product_name      = var.prefix
  env               = var.env

  db_version = var.pgres_flex_archive_params.db_version
  databases  = ["fdr3"]

  storage_mb        = var.pgres_flex_archive_params.storage_mb
  auto_grow_enabled = var.pgres_flex_archive_params.auto_grow_enabled

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

  administrator_login    = data.azurerm_key_vault_secret.pgres_flex_admin_login.value
  administrator_password = data.azurerm_key_vault_secret.pgres_flex_admin_pwd.value

  diagnostic_settings_enabled = var.pgres_flex_archive_params.pgres_flex_diagnostic_settings_enabled
  log_analytics_workspace_id  = data.azurerm_log_analytics_workspace.log_analytics.id

  custom_metric_alerts = var.custom_metric_alerts

  alert_action = var.pgres_flex_archive_params.alerts_enabled ? [
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

  private_dns_registration = var.pgres_flex_archive_params.enable_private_dns_registration
  private_dns_zone_name    = "${var.env_short}.internal.postgresql.pagopa.it"
  private_dns_zone_rg_name = data.azurerm_resource_group.rg_vnet.name
  private_dns_record_cname = "fdr-archive-db"

  tags = local.tags_grafana

  geo_replication = {
    enabled = false
  }
}

resource "azurerm_postgresql_flexible_server_configuration" "fdr_archive_pg_cron_database" {
  name      = "cron.database_name"
  server_id = module.postgres_flexible_server_fdr_archive.id
  value     = "postgres"
}
