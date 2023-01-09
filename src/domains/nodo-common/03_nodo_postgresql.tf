resource "azurerm_resource_group" "db_rg_2" {
  count = var.env_short == "d" ? 1 : 0

  name     = format("%s-db-rg-2", local.project)
  location = var.location

  tags = var.tags
}

data "azurerm_key_vault_secret" "pgres_flex_admin_login_2" {
  name         = "db-administrator-login"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "pgres_flex_admin_pwd_2" {
  name         = "db-administrator-login-password"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

module "postgres_flexible_server_2" {
  count = var.env_short == "d" ? 1 : 0

  source              = "git::https://github.com/pagopa/azurerm.git//postgres_flexible_server?ref=v2.12.3"
  name                = format("%s-flexible-postgresql-2", local.project)
  location            = azurerm_resource_group.db_rg_2[0].location
  resource_group_name = azurerm_resource_group.db_rg_2[0].name

  private_endpoint_enabled    = var.pgres_flex_private_endpoint_enabled
  private_dns_zone_id         = var.env_short != "d" ? data.azurerm_private_dns_zone.postgres[0].id : null
  delegated_subnet_id         = var.env_short != "d" ? module.postgres_flexible_snet.id : null
  high_availability_enabled   = var.pgres_flex_ha_enabled
  pgbouncer_enabled           = var.pgres_flex_pgbouncer_enabled
  diagnostic_settings_enabled = var.pgres_flex_diagnostic_settings_enabled
  administrator_login         = data.azurerm_key_vault_secret.pgres_flex_admin_login_2.value
  administrator_password      = data.azurerm_key_vault_secret.pgres_flex_admin_pwd_2.value

  sku_name                     = var.pgres_flex_params.sku_name
  db_version                   = var.pgres_flex_params.db_version
  storage_mb                   = var.pgres_flex_params.storage_mb
  zone                         = var.pgres_flex_params.zone
  backup_retention_days        = var.pgres_flex_params.backup_retention_days
  geo_redundant_backup_enabled = var.pgres_flex_params.geo_redundant_backup_enabled
  create_mode                  = var.pgres_flex_params.create_mode

  tags = var.tags
}

# Nodo database
# resource "azurerm_postgresql_flexible_server_database" "nodo_db_2" {
#   count = var.env_short == "d" ? 1 : 0

#   name      = var.pgres_flex_nodo_db_name
#   server_id = module.postgres_flexible_server_2[0].id
#   collation = "en_US.utf8"
#   charset   = "utf8"
# }
