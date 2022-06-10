# region
resource "azurerm_resource_group" "gps_rg" {
  name     = format("%s-gps-rg", local.project)
  location = var.location

  tags = var.tags
}

# local variables
locals {

  gps_cosmosdb_containers = [
    {
      name               = "creditor_institutions",
      partition_key_path = "/fiscalCode",
    },
    {
      name               = "services",
      partition_key_path = "/transferCategory",
    },
  ]
}

# subnet
module "gps_app_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                 = format("%s-gps-app-snet", local.project)
  address_prefixes     = var.cidr_subnet_gps_app
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = module.vnet.name

  enforce_private_link_endpoint_network_policies = true

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "gps_cosmosdb_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                 = format("%s-gps-cosmosdb-snet", local.project)
  address_prefixes     = var.cidr_subnet_gps_cosmosdb
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = module.vnet.name

  enforce_private_link_endpoint_network_policies = true

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]
}

# gps cosmosdb configuration

# cosmosdb account
module "gps_cosmosdb_account" {
  source   = "git::https://github.com/pagopa/azurerm.git//cosmosdb_account?ref=v2.1.18"
  name     = format("%s-gps-cosmosdb-account", local.project)
  location = var.location

  resource_group_name = azurerm_resource_group.gpd_rg.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  public_network_access_enabled = var.gps_cosmosdb_public_network_access_enabled

  enable_free_tier          = false
  enable_automatic_failover = true

  consistency_policy = {
    consistency_level       = "Strong"
    max_interval_in_seconds = null
    max_staleness_prefix    = null
  }

  main_geo_location_zone_redundant = false
  main_geo_location_location       = "westeurope"

  additional_geo_locations = [
    {
      location          = "northeurope"
      failover_priority = 1
      zone_redundant    = true
    }
  ]

  backup_continuous_enabled = var.gps_cosmosdb_backup_continuous_enabled

  is_virtual_network_filter_enabled = true

  ip_range = ""

  # add data.azurerm_subnet.<my_service>.id
  allowed_virtual_network_subnet_ids = [module.gps_app_snet.id]

  # private endpoint
  private_endpoint_name    = format("%s-gps-cosmosdb-sql-endpoint", local.project)
  private_endpoint_enabled = true
  subnet_id                = module.gps_cosmosdb_snet.id
  private_dns_zone_ids     = [azurerm_private_dns_zone.privatelink_gps_cosmos_azure_com.id]

  tags = var.tags
}

# cosmosdb database
module "gps_cosmosdb_database" {
  source              = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_database?ref=v2.1.15"
  name                = "db"
  resource_group_name = azurerm_resource_group.gps_rg.name
  account_name        = module.gps_cosmosdb_account.name
}

# cosmosdb container
module "gps_cosmosdb_containers" {
  source   = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_container?ref=v2.1.8"
  for_each = { for c in local.gps_cosmosdb_containers : c.name => c }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.gps_rg.name
  account_name        = module.gps_cosmosdb_account.name
  database_name       = module.gps_cosmosdb_database[0].name
  partition_key_path  = each.value.partition_key_path
  throughput          = lookup(each.value, "throughput", null)

  autoscale_settings = lookup(each.value, "autoscale_settings", null)
}
