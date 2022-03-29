# review postgreql:
# naming and resource group
# avaibility zones, backup redundancy

resource "azurerm_resource_group" "flex_data" {
  count = var.env_short != "d" ? 1 : 0

  name     = format("%s-flex-data-rg", local.project)
  location = var.location

  tags = var.tags
}

# Postgres Flexible Server subnet
module "postgres_flexible_snet" {
  count  = var.env_short != "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.1.13"

  name                                           = format("%s-pgres-flexible-snet", local.project)
  address_prefixes                               = var.cidr_subnet_flex_dbms
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet.name
  service_endpoints                              = ["Microsoft.Storage"]
  enforce_private_link_endpoint_network_policies = true

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

# KV secrets flex server
data "azurerm_key_vault_secret" "pgres_flex_admin_login" {
  name         = "pgres-flex-admin-login"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "pgres_flex_admin_pwd" {
  name         = "pgres-flex-admin-pwd"
  key_vault_id = module.key_vault.id
}

# https://docs.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-compare-single-server-flexible-server
module "postgres_flexible_server" {
  count  = var.env_short != "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//postgres_flexible_server?ref=v2.7.1"

  name = format("%s-gpd-pgflex", local.project)

  location            = azurerm_resource_group.flex_data[0].location
  resource_group_name = azurerm_resource_group.flex_data[0].name

  private_endpoint = {
    enabled   = true
    subnet_id = module.postgres_flexible_snet[0].id
    private_dns_zone = {
      id   = azurerm_private_dns_zone.postgres[0].id
      name = azurerm_private_dns_zone.postgres[0].name
      rg   = azurerm_resource_group.rg_vnet.name
    }
  }

  administrator_login    = data.azurerm_key_vault_secret.pgres_flex_admin_login.value
  administrator_password = data.azurerm_key_vault_secret.pgres_flex_admin_pwd.value

  sku_name                     = var.pgres_flex_params.sku_name
  db_version                   = var.pgres_flex_params.db_version
  storage_mb                   = var.pgres_flex_params.storage_mb
  zone                         = var.pgres_flex_params.zone
  backup_retention_days        = var.pgres_flex_params.backup_retention_days
  geo_redundant_backup_enabled = var.pgres_flex_params.geo_redundant_backup_enabled
  create_mode                  = var.pgres_flex_params.create_mode

  tags = var.tags

  depends_on = [azurerm_private_dns_zone_virtual_network_link.postgres_vnet[0]]

}
