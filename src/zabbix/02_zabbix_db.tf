#
# KeyVault
#
resource "random_password" "zabbix_pg_admin_password" {
  length           = 8
  special          = true
  upper            = false
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
  min_lower        = 1
  override_special = "-"
}

resource "azurerm_key_vault_secret" "zabbix_pg_admin_password" {
  count = var.enabled_resource.zabbix_kv_enabled ? 1 : 0

  name         = "zabbix-pg-admin-password"
  value        = random_password.zabbix_pg_admin_password.result
  content_type = "text/plain"

  key_vault_id = module.key_vault[0].id
}

# Postgres Flexible Server subnet
module "zabbix_pg_flexible_snet" {
  count = var.enabled_resource.zabbix_pgflexi_enabled ? 1 : 0

  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.35.1"
  name                                      = "${local.project}-pg-snet"
  address_prefixes                          = var.cidr_subnet_pg_flex_zabbix
  resource_group_name                       = data.azurerm_resource_group.rg_vnet_core.name
  virtual_network_name                      = data.azurerm_virtual_network.vnet_core.name
  service_endpoints                         = ["Microsoft.Storage"]
  private_endpoint_network_policies_enabled = true

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

module "zabbix_pgflex_dev" {

  count = var.enabled_resource.zabbix_pgflexi_enabled ? 1 : 0

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//postgres_flexible_server?ref=v7.35.1"

  name                = "${local.project}-pgflex"
  location            = azurerm_resource_group.zabbix.location
  resource_group_name = azurerm_resource_group.zabbix.name

  ### Network
  private_endpoint_enabled = false
  # private_dns_zone_id      = data.azurerm_private_dns_zone.privatelink_postgres_database_azure_com.id
  # delegated_subnet_id      = module.zabbix_pg_flexible_snet.id

  administrator_login    = "postgres"
  administrator_password = random_password.zabbix_pg_admin_password.result

  sku_name   = "B_Standard_B1ms"
  db_version = "13"
  # Possible values are 32768, 65536, 131072, 262144, 524288, 1048576,
  # 2097152, 4194304, 8388608, 16777216, and 33554432.
  storage_mb                   = 32768
  zone                         = 3
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false

  high_availability_enabled = false
  pgbouncer_enabled         = false

  tags = var.tags

  # custom_metric_alerts = null
  alerts_enabled = false

  diagnostic_settings_enabled = false
  # log_analytics_workspace_id  = data.azurerm_log_analytics_workspace.log_analytics.id
  # diagnostic_setting_destination_storage_id = data.azurerm_storage_account.security_monitoring_storage.id

  depends_on = [
    azurerm_key_vault_secret.zabbix_pg_admin_password
  ]

}
