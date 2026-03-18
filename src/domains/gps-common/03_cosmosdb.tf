resource "azurerm_resource_group" "gps_rg" {
  name     = "${local.project}-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "gps_cosmosdb_snet" {
  source                            = "./.terraform/modules/__v4__/subnet"
  name                              = "${local.project}-cosmosdb-snet"
  address_prefixes                  = var.cidr_subnet_gps_cosmosdb
  resource_group_name               = local.vnet_resource_group_name
  virtual_network_name              = local.vnet_name
  private_endpoint_network_policies = "Disabled"

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]
}

module "gps_cosmosdb_account" {
  source   = "./.terraform/modules/__v4__/cosmosdb_account"
  name     = "${local.project}-cosmos-account"
  location = var.location
  domain   = var.domain

  resource_group_name = azurerm_resource_group.gps_rg.name
  offer_type          = var.cosmos_gps_db_params.offer_type
  kind                = var.cosmos_gps_db_params.kind

  public_network_access_enabled    = var.cosmos_gps_db_params.public_network_access_enabled
  main_geo_location_zone_redundant = var.cosmos_gps_db_params.main_geo_location_zone_redundant

  enable_free_tier                             = var.cosmos_gps_db_params.enable_free_tier
  enable_automatic_failover                    = true
  enable_provisioned_throughput_exceeded_alert = false

  capabilities       = var.cosmos_gps_db_params.capabilities
  consistency_policy = var.cosmos_gps_db_params.consistency_policy

  main_geo_location_location = var.location
  additional_geo_locations   = var.cosmos_gps_db_params.additional_geo_locations
  backup_continuous_enabled  = var.cosmos_gps_db_params.backup_continuous_enabled

  is_virtual_network_filter_enabled = var.cosmos_gps_db_params.is_virtual_network_filter_enabled


  # add data.azurerm_subnet.<my_service>.id
  allowed_virtual_network_subnet_ids = var.cosmos_gps_db_params.public_network_access_enabled ? var.env_short == "d" ? [] : [data.azurerm_subnet.aks_subnet.id] : [data.azurerm_subnet.aks_subnet.id]

  # private endpoint
  private_endpoint_sql_name           = "${local.project}-cosmos-sql-endpoint" # forced after update module vers
  private_service_connection_sql_name = "${local.project}-cosmos-sql-endpoint" # forced after update module vers
  private_endpoint_enabled            = var.cosmos_gps_db_params.private_endpoint_enabled
  subnet_id                           = module.gps_cosmosdb_snet.id
  private_dns_zone_sql_ids            = [data.azurerm_private_dns_zone.cosmos.id]

  tags = module.tag_config.tags
}

# cosmosdb database
module "gps_cosmosdb_database" {
  source              = "./.terraform/modules/__v4__/cosmosdb_sql_database"
  name                = "db"
  resource_group_name = azurerm_resource_group.gps_rg.name
  account_name        = module.gps_cosmosdb_account.name
}

# GPD cosmosdb database
module "gpd_cosmosdb_database" {
  source              = "./.terraform/modules/__v4__/cosmosdb_sql_database"
  name                = "gpd_db"
  resource_group_name = azurerm_resource_group.gps_rg.name
  account_name        = module.gps_cosmosdb_account.name
}

### Containers
locals {

  gps_cosmosdb_containers = [
    {
      name               = "creditor_institutions",
      partition_key_path = "/fiscalCode",
      default_ttl        = -1, // the value is set to -1 -> items don’t expire by default
      autoscale_settings = { max_throughput = 1000 }
    },
    {
      name               = "services",
      partition_key_path = "/transferCategory",
      default_ttl        = -1, // the value is set to -1 -> items don’t expire by default
      autoscale_settings = { max_throughput = 1000 }
    },
  ]

  gpd_cosmosdb_containers = [
    {
      name               = "gpd_upload_status",
      partition_key_path = "/fiscalCode",
      default_ttl        = var.gpd_upload_status_ttl,
      autoscale_settings = { max_throughput = var.gpd_upload_status_throughput }
    },
  ]
}

# cosmosdb container
module "gpd_cosmosdb_containers" {
  source   = "./.terraform/modules/__v4__/cosmosdb_sql_container"
  for_each = { for c in local.gpd_cosmosdb_containers : c.name => c }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.gps_rg.name
  account_name        = module.gps_cosmosdb_account.name
  database_name       = module.gpd_cosmosdb_database.name
  partition_key_paths = [each.value.partition_key_path]
  throughput          = lookup(each.value, "throughput", null)
  default_ttl         = each.value.default_ttl

  autoscale_settings = contains(var.cosmos_gps_db_params.capabilities, "EnableServerless") ? null : lookup(each.value, "autoscale_settings", null)
}


# cosmosdb container
module "gps_cosmosdb_containers" {
  source   = "./.terraform/modules/__v4__/cosmosdb_sql_container"
  for_each = { for c in local.gps_cosmosdb_containers : c.name => c }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.gps_rg.name
  account_name        = module.gps_cosmosdb_account.name
  database_name       = module.gps_cosmosdb_database.name
  partition_key_paths = [each.value.partition_key_path]
  throughput          = lookup(each.value, "throughput", null)

  autoscale_settings = contains(var.cosmos_gps_db_params.capabilities, "EnableServerless") ? null : lookup(each.value, "autoscale_settings", null)
}

module "gpd_payments_cosmosdb_account" {
  source   = "./.terraform/modules/__v4__/cosmosdb_account"
  name     = "${local.project}-payments-cosmos-account"
  location = var.location
  domain   = var.domain

  resource_group_name = azurerm_resource_group.gps_rg.name
  offer_type          = var.cosmos_gpd_payments_db_params.offer_type
  kind                = var.cosmos_gpd_payments_db_params.kind

  public_network_access_enabled    = var.cosmos_gpd_payments_db_params.public_network_access_enabled
  main_geo_location_zone_redundant = var.cosmos_gpd_payments_db_params.main_geo_location_zone_redundant

  enable_free_tier          = var.cosmos_gpd_payments_db_params.enable_free_tier
  enable_automatic_failover = true

  capabilities       = var.cosmos_gpd_payments_db_params.capabilities
  consistency_policy = var.cosmos_gpd_payments_db_params.consistency_policy

  main_geo_location_location = var.location
  additional_geo_locations   = var.cosmos_gpd_payments_db_params.additional_geo_locations
  backup_continuous_enabled  = var.cosmos_gpd_payments_db_params.backup_continuous_enabled

  is_virtual_network_filter_enabled = var.cosmos_gpd_payments_db_params.is_virtual_network_filter_enabled

  # add data.azurerm_subnet.<my_service>.id
  allowed_virtual_network_subnet_ids = var.cosmos_gpd_payments_db_params.public_network_access_enabled ? var.env_short == "d" ? [] : [data.azurerm_subnet.aks_subnet.id] : [data.azurerm_subnet.aks_subnet.id]

  # private endpoint
  private_endpoint_enabled   = var.cosmos_gpd_payments_db_params.private_endpoint_enabled
  subnet_id                  = module.gps_cosmosdb_snet.id
  private_dns_zone_sql_ids   = [data.azurerm_private_dns_zone.cosmos.id]
  private_dns_zone_table_ids = [data.azurerm_private_dns_zone.cosmos_table.id]

  tags = module.tag_config.tags
}

# cosmosdb gpd payments table
resource "azurerm_cosmosdb_table" "payments_receipts_table" {
  name                = "gpdpaymentsreceiptstable"
  resource_group_name = azurerm_resource_group.gps_rg.name
  account_name        = module.gpd_payments_cosmosdb_account.name
  throughput          = !var.cosmos_gpd_payments_db_params.payments_receipts_table.autoscale ? var.cosmos_gpd_payments_db_params.payments_receipts_table.throughput : null
  dynamic "autoscale_settings" {
    for_each = var.cosmos_gpd_payments_db_params.payments_receipts_table.autoscale ? ["dummy"] : []
    content {
      max_throughput = var.cosmos_gpd_payments_db_params.payments_receipts_table.throughput
    }
  }
}


// Az portal manual setting
// DEV  7 Giorni  = 604800 Secondi
// UAT  3 Mesi    = 7889400 Secondi
// PROD 10 Anni   = 315576000 Secondi
// https://github.com/hashicorp/terraform-provider-azurerm/issues/11098
resource "azurerm_cosmosdb_table" "payments_pp_table" {
  name                = "paymentpositiontable"
  resource_group_name = azurerm_resource_group.gps_rg.name
  account_name        = module.gpd_payments_cosmosdb_account.name
  throughput          = !var.cosmos_gpd_payments_db_params.payments_pp_table.autoscale ? var.cosmos_gpd_payments_db_params.payments_receipts_table.throughput : null
  dynamic "autoscale_settings" {
    for_each = var.cosmos_gpd_payments_db_params.payments_pp_table.autoscale ? ["dummy"] : []
    content {
      max_throughput = var.cosmos_gpd_payments_db_params.payments_pp_table.throughput
    }
  }
}
