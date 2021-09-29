resource "azurerm_resource_group" "mock_data_rg" {
  name     = format("%s-db-rg", local.project)
  location = var.location

  tags = var.tags
}

module "mock_data_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.7"
  name                                           = format("%s-mock-data-snet", local.project)
  address_prefixes                               = var.cidr_subnet_mock_data
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet.name
  service_endpoints                              = ["Microsoft.Sql"]
  enforce_private_link_endpoint_network_policies = true
}

data "azurerm_key_vault_secret" "db_administrator_login" {
  name         = "db-administrator-login"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "db_administrator_login_password" {
  name         = "db-administrator-login-password"
  key_vault_id = module.key_vault.id
}

#tfsec:ignore:azure-database-no-public-access
module "postgresql" {
  source                           = "git::https://github.com/pagopa/azurerm.git//postgresql_server?ref=v1.0.51"
  name                             = format("%s-postgresql", local.project)
  location                         = azurerm_resource_group.mock_data_rg.location
  resource_group_name              = azurerm_resource_group.mock_data_rg.name
  virtual_network_id               = module.vnet.id
  subnet_id                        = module.mock_data_snet.id
  administrator_login              = data.azurerm_key_vault_secret.db_administrator_login.value
  administrator_login_password     = data.azurerm_key_vault_secret.db_administrator_login_password.value
  sku_name                         = var.db_sku_name
  storage_mb                       = var.db_storage_mb
  db_version                       = 10
  geo_redundant_backup_enabled     = var.db_geo_redundant_backup_enabled
  enable_replica                   = var.db_enable_replica
  ssl_minimal_tls_version_enforced = "TLS1_2"
  public_network_access_enabled    = true
  lock_enable                      = var.lock_enable

  network_rules         = var.db_network_rules

  configuration         = var.db_configuration

  alerts_enabled = var.db_alerts_enabled

  tags = var.tags
}