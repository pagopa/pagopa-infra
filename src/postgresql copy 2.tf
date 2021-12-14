module "postgresql_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.7"
  name                                           = format("%s-postgresql-snet", local.project)
  address_prefixes                               = var.cidr_subnet_postgresql
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet.name
  service_endpoints                              = ["Microsoft.Sql"]
  enforce_private_link_endpoint_network_policies = true
}


resource "azurerm_private_dns_zone" "privatelink_postgres_database_azure_com" {
  name                  = "pagopa-d-postgresql-private-dns-zone-group"
    resource_group_name = azurerm_resource_group.data.name

  private_dns_zone_name = module.azurerm_private_dns_zone.privatelink_postgres_database_azure_com.name
  virtual_network_id    = module.vnet.id

  tags = var.tags
}

data "azurerm_key_vault_secret" "db_administrator_login" {
  count        = var.prostgresql_enabled ? 1 : 0
  name         = "db-administrator-login"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "db_administrator_login_password" {
  count        = var.prostgresql_enabled ? 1 : 0
  name         = "db-administrator-login-password"
  key_vault_id = module.key_vault.id
}

#tfsec:ignore:azure-database-no-public-access
module "postgresql" {
  count  = var.prostgresql_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//postgresql_server?ref=v2.0.0"

  name                = format("%s-postgresql", local.project)
  location            = azurerm_resource_group.data.location
  resource_group_name = azurerm_resource_group.data.name

  administrator_login          = data.azurerm_key_vault_secret.db_administrator_login[0].value
  administrator_login_password = data.azurerm_key_vault_secret.db_administrator_login_password[0].value
  sku_name                     = var.postgresql_sku_name
  db_version                   = 11
  geo_redundant_backup_enabled = var.postgresql_geo_redundant_backup_enabled

  public_network_access_enabled = var.postgresql_public_network_access_enabled
  network_rules                 = var.postgresql_network_rules

  private_endpoint = {
    enabled              = false
    virtual_network_id   = module.vnet.id
    subnet_id            = module.postgresql_snet.id
    private_dns_zone_ids = [azurerm_private_dns_zone.azurerm_private_dns_zone.privatelink_postgres_database_azure_com.id]
  }

  storage_mb                       = var.postgresql_storage_mb
  enable_replica                   = var.postgresql_enable_replica
  ssl_minimal_tls_version_enforced = "TLS1_2"

  alerts_enabled = var.postgresql_alerts_enabled

  lock_enable = var.lock_enable

  tags = var.tags
}
