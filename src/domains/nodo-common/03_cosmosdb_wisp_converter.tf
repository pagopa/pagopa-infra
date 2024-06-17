module "cosmosdb_account_wispconv" {
  count = var.enable_wisp_converter ? 1 : 0

  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_account?ref=v6.7.0"
  domain              = var.domain
  name                = "${local.project}-wispconv-cosmos-account"
  location            = var.location
  resource_group_name = azurerm_resource_group.wisp_converter_rg[0].name

  offer_type       = var.wisp_converter_cosmos_nosql_db_params.offer_type
  kind             = var.wisp_converter_cosmos_nosql_db_params.kind
  capabilities     = var.wisp_converter_cosmos_nosql_db_params.capabilities
  enable_free_tier = var.wisp_converter_cosmos_nosql_db_params.enable_free_tier

  subnet_id                     = module.cosmosdb_wisp_converter_snet[0].id
  public_network_access_enabled = var.wisp_converter_cosmos_nosql_db_params.public_network_access_enabled
  # private endpoint
  private_endpoint_enabled          = var.wisp_converter_cosmos_nosql_db_params.private_endpoint_enabled
  private_endpoint_name             = "${local.project}-wispconv-cosmos-nosql-endpoint"
  private_dns_zone_ids              = [data.azurerm_private_dns_zone.cosmos_nosql.id]
  is_virtual_network_filter_enabled = var.wisp_converter_cosmos_nosql_db_params.is_virtual_network_filter_enabled
  ip_range                          = ""

  allowed_virtual_network_subnet_ids = var.wisp_converter_cosmos_nosql_db_params.public_network_access_enabled ? [] : [data.azurerm_subnet.aks_subnet.id]

  enable_automatic_failover = true

  consistency_policy               = var.wisp_converter_cosmos_nosql_db_params.consistency_policy
  main_geo_location_location       = var.location
  main_geo_location_zone_redundant = var.wisp_converter_cosmos_nosql_db_params.main_geo_location_zone_redundant
  additional_geo_locations         = var.wisp_converter_cosmos_nosql_db_params.additional_geo_locations

  backup_continuous_enabled = var.wisp_converter_cosmos_nosql_db_params.backup_continuous_enabled

  tags = var.tags

  depends_on = [
    azurerm_resource_group.wisp_converter_rg,
    module.cosmosdb_wisp_converter_snet
  ]
}

# cosmosdb database for wispconv
module "cosmosdb_account_wispconv_db" {
  count               = var.enable_wisp_converter ? 1 : 0
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_database?ref=v6.7.0"
  name                = "wispconverter"
  resource_group_name = azurerm_resource_group.wisp_converter_rg[0].name
  account_name        = module.cosmosdb_account_wispconv[0].name
}

### containers
locals {
  wispconv_containers = [
    {
      name               = "data",
      partition_key_path = "/id", # contains brokerEC_sessionId
      default_ttl        = var.wisp_converter_cosmos_nosql_db_params.events_ttl
      autoscale_settings = {
        max_throughput = var.wisp_converter_cosmos_nosql_db_params.max_throughput
      }
    },
    {
      name               = "receipt",
      partition_key_path = "/partitionKey", # contains 'yyyy-MM-dd'
      default_ttl        = var.wisp_converter_cosmos_nosql_db_params.events_ttl
      autoscale_settings = {
        max_throughput = var.wisp_converter_cosmos_nosql_db_params.max_throughput
      }
    }
  ]
}

# cosmosdb container for stand-in datastore
module "cosmosdb_account_wispconv_containers" {
  source   = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_container?ref=v6.7.0"
  for_each = { for c in local.wispconv_containers : c.name => c if var.enable_wisp_converter }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.wisp_converter_rg[0].name
  account_name        = module.cosmosdb_account_wispconv[0].name
  database_name       = module.cosmosdb_account_wispconv_db[0].name
  partition_key_path  = each.value.partition_key_path
  throughput          = lookup(each.value, "throughput", null)
  default_ttl         = lookup(each.value, "default_ttl", null)

  autoscale_settings = contains(var.wisp_converter_cosmos_nosql_db_params.capabilities, "EnableServerless") ? null : lookup(each.value, "autoscale_settings", null)

  depends_on = [
    azurerm_resource_group.wisp_converter_rg,
    module.cosmosdb_account_wispconv,
    module.cosmosdb_account_wispconv_db
  ]
}

