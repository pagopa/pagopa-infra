#
## Postgres Flexible Server subnet
module "postgres_flexible_snet_replica" {
  count                                         = var.geo_replica_enabled ? 1 : 0
  source                                        = "./.terraform/modules/__v3__/subnet"
  name                                          = "${local.project_replica}-pgres-flexible-snet"
  address_prefixes                              = var.geo_replica_cidr_subnet_postgresql
  resource_group_name                           = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name                          = data.azurerm_virtual_network.vnet_replica[0].name
  service_endpoints                             = ["Microsoft.Storage"]
  private_link_service_network_policies_enabled = true

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



module "postgresql_nodo_replica_db" {
  source = "./.terraform/modules/__v3__/postgres_flexible_server_replica"
  count  = var.geo_replica_enabled ? 1 : 0

  name                = "${local.project_replica}-flexible-postgresql"
  resource_group_name = azurerm_resource_group.db_rg.name
  location            = var.location_replica

  private_dns_zone_id      = var.env_short != "d" ? data.azurerm_private_dns_zone.postgres[0].id : null
  delegated_subnet_id      = module.postgres_flexible_snet_replica[0].id
  private_endpoint_enabled = var.pgres_flex_params.pgres_flex_private_endpoint_enabled

  sku_name = var.pgres_flex_params.sku_name

  high_availability_enabled = false
  pgbouncer_enabled         = var.pgres_flex_params.pgres_flex_pgbouncer_enabled


  source_server_id = module.postgres_flexible_server.id

  diagnostic_settings_enabled = false

  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics.id
  zone                       = 2
  tags                       = var.tags
}



resource "azurerm_postgresql_flexible_server_virtual_endpoint" "virtual_endpoint" {
  count             = var.geo_replica_enabled ? 1 : 0
  name              = "${local.project}-pgflex-ve"
  source_server_id  = module.postgres_flexible_server.id
  replica_server_id = module.postgresql_nodo_replica_db[0].id
  type              = "ReadWrite"
}

resource "azurerm_private_dns_cname_record" "cname_record" {
  count               = var.geo_replica_enabled && var.pgres_flex_params.enable_private_dns_registration_virtual_endpoint ? 1 : 0
  name                = "nodo-db"
  zone_name           = "${var.env_short}.internal.postgresql.pagopa.it"
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  ttl                 = 300
  record              = "${azurerm_postgresql_flexible_server_virtual_endpoint.virtual_endpoint[0].name}.writer.postgres.database.azure.com"
}

