data "azurerm_resource_group" "rg_api" {
  name = format("%s-api-rg", local.product)
}

data "azurerm_api_management" "apim" {
  name                = "${local.product}-apim"
  resource_group_name = data.azurerm_resource_group.rg_api.name
}

data "azurerm_key_vault" "gps_kv" {
  name                = local.gps_kv
  resource_group_name = local.gps_kv_rg
}

data "azurerm_key_vault_secret" "gpd_db_usr" {
  name         = "db-apd-user-name"
  key_vault_id = data.azurerm_key_vault.gps_kv.id
}

data "azurerm_key_vault_secret" "gpd_db_pwd" {
  name         = "db-apd-user-password"
  key_vault_id = data.azurerm_key_vault.gps_kv.id
}

data "azurerm_postgresql_server" "postgresql" {
  count               = var.env_short == "d" ? 1 : 0
  name                = format("%s-gpd-postgresql", local.product)
  resource_group_name = format("%s-gpd-rg", local.product)
}

data "azurerm_postgresql_flexible_server" "postgres_flexible_server_private" {
  count               = var.env_short != "d" ? 1 : 0
  name                = format("%s-gpd-pgflex", local.product)
  resource_group_name = format("%s-pgres-flex-rg", local.product)
}

data "azurerm_monitor_action_group" "opsgenie" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_opsgenie_name
}
