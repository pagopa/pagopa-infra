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



module "postgresql_gpd_replica_db" {
  source = "./.terraform/modules/__v3__/postgres_flexible_server_replica"
  count  = var.geo_replica_enabled ? 1 : 0

  name                = "${local.project_replica}-pgflex"
  resource_group_name = azurerm_resource_group.flex_data[0].name
  location            = var.location_replica

  private_dns_zone_id      = var.env_short != "d" ? data.azurerm_private_dns_zone.postgres[0].id : null
  delegated_subnet_id      = module.postgres_flexible_snet_replica[0].id
  private_endpoint_enabled = var.pgres_flex_params.private_endpoint_enabled

  sku_name = var.pgres_flex_params.sku_name

  high_availability_enabled = false
  pgbouncer_enabled         = var.pgres_flex_params.pgbouncer_enabled

  storage_mb = var.pgres_flex_params.storage_mb

  source_server_id = module.postgres_flexible_server_private_db.id #NEWGPD-DB : DEPRECATED switch to new istance postgres_flexible_server_private_db

  diagnostic_settings_enabled = false

  max_connections    = var.pgres_flex_params.max_connections
  max_worker_process = var.pgres_flex_params.max_worker_process

  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics.id
  zone                       = 2
  tags                       = var.tags
}


resource "azurerm_postgresql_flexible_server_virtual_endpoint" "virtual_endpoint" {
  count             = var.geo_replica_enabled ? 1 : 0
  name              = "${local.product}-${var.location_short}-gpd-pgflex-ve"
  source_server_id  = module.postgres_flexible_server_private_db.id
  replica_server_id = module.postgresql_gpd_replica_db[0].id
  type              = "ReadWrite"
}

resource "azurerm_private_dns_cname_record" "cname_record" {
  count               = var.geo_replica_enabled && var.pgres_flex_params.enable_private_dns_registration_virtual_endpoint ? 1 : 0
  name                = "gpd-db"
  zone_name           = "${var.env_short}.internal.postgresql.pagopa.it"
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  ttl                 = 300
  record              = "${azurerm_postgresql_flexible_server_virtual_endpoint.virtual_endpoint[0].name}.writer.postgres.database.azure.com"
}

