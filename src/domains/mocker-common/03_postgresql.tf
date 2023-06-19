# resource group
resource "azurerm_resource_group" "mocker_rg" {
  name     = "${local.product}-mocker-rg"
  location = var.location

  tags = var.tags
}

# KV secrets flex server
data "azurerm_key_vault_secret" "psql_admin_user" {
  name         = "psql-mocker-admin-user"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "psql_admin_pwd" {
  name         = "psql-mocker-admin-pwd"
  key_vault_id = module.key_vault.id
}

module "mocker_postgresql_snet" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//subnet?ref=v6.11.2"

  name                                      = format("%s-mocker-psql-snet", local.product)
  address_prefixes                          = var.cidr_subnet_dbms
  resource_group_name                       = local.vnet_resource_group_name
  virtual_network_name                      = local.vnet_name
  service_endpoints                         = ["Microsoft.Sql"]
  private_endpoint_network_policies_enabled = false

  delegation = {
    name = "delegation"
    service_delegation = {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

#tfsec:ignore:azure-database-no-public-access
module "mocker_postgresql" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//postgresql_server?ref=v6.11.2"

  name                = format("%s-mocker-psql", local.product)
  location            = azurerm_resource_group.mocker_rg.location
  resource_group_name = azurerm_resource_group.mocker_rg.name

  administrator_login          = data.azurerm_key_vault_secret.psql_admin_user.value
  administrator_login_password = data.azurerm_key_vault_secret.psql_admin_pwd.value

  sku_name                     = "B_Gen5_1"
  db_version                   = 11
  geo_redundant_backup_enabled = false

  public_network_access_enabled = false
  network_rules                 = var.postgresql_network_rules

  private_endpoint = {
    enabled              = false
    virtual_network_id   = data.azurerm_virtual_network.vnet.id
    subnet_id            = module.mocker_postgresql_snet.id
    private_dns_zone_ids = []
  }

  enable_replica = false
  alerts_enabled = false
  lock_enable    = false

  tags = var.tags
}

resource "azurerm_postgresql_database" "mocker_db" {
  name                = var.mocker_db_name
  resource_group_name = azurerm_resource_group.mocker_rg.name
  server_name         = module.mocker_postgresql.name
  charset             = "UTF8"
  collation           = "Italian_Italy.1252"
}
