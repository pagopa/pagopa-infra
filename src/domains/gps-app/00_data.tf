data "azurerm_api_management" "apim" {
  name                = "${local.product}-apim"
  resource_group_name = "${local.product}-api-rg"
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
  name                = format("%s-postgresql", local.product)
  resource_group_name = format("%s-data-rg", local.product)
}

data "azurerm_postgresql_flexible_server" "postgres_flexible_server_private" {
  count               = var.env_short != "d" ? 1 : 0
  name                = format("%s-gpd-pgflex", local.product)
  resource_group_name = format("%s-pgres-flex-rg", local.product)
}
