module "postgresql_snet" {
  source                                         = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.76.0"
  name                                           = format("%s-postgresql-snet", local.project)
  address_prefixes                               = var.cidr_subnet_postgresql
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet.name
  service_endpoints                              = ["Microsoft.Sql"]
  enforce_private_link_endpoint_network_policies = true

  delegation = {
    name = "delegation"
    service_delegation = {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

# KV secrets single server
data "azurerm_key_vault_secret" "db_administrator_login" {
  count        = var.env_short == "d" ? 1 : 0
  name         = "db-administrator-login"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "db_administrator_login_password" {
  count        = var.env_short == "d" ? 1 : 0
  name         = "db-administrator-login-password"
  key_vault_id = module.key_vault.id
}

# DNS private single server
resource "azurerm_private_dns_zone" "privatelink_postgres_database_azure_com" {
  count               = var.postgres_private_endpoint_enabled ? 1 : 0
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_postgres_database_azure_com_vnet" {
  count                 = var.postgres_private_endpoint_enabled ? 1 : 0
  name                  = module.vnet.name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_postgres_database_azure_com[0].name
  virtual_network_id    = module.vnet.id
  registration_enabled  = false

  tags = var.tags
}

#tfsec:ignore:azure-database-no-public-access
module "postgresql" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//postgresql_server?ref=v7.76.0"

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
    enabled              = var.postgres_private_endpoint_enabled
    virtual_network_id   = module.vnet.id
    subnet_id            = module.postgresql_snet.id
    private_dns_zone_ids = var.postgres_private_endpoint_enabled ? [azurerm_private_dns_zone.privatelink_postgres_database_azure_com[0].id] : []
  }

  enable_replica = var.postgresql_enable_replica
  alerts_enabled = var.postgresql_alerts_enabled
  lock_enable    = var.lock_enable

  tags = var.tags
}

resource "azurerm_postgresql_database" "this" {
  count               = var.env_short == "d" ? 1 : 0
  name                = "mock_psp"
  resource_group_name = azurerm_resource_group.data.name
  server_name         = module.postgresql[0].name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}
