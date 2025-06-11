resource "azurerm_resource_group" "shared_rg" {
  name     = "${local.project}-rg"
  location = var.location

  tags = module.tag_config.tags
}

resource "azurerm_resource_group" "iuvgenerator_rg" {
  name     = "${local.project}-iuvgenerator-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "iuvgenerator_cosmosdb_snet" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v8.53.0"
  name                 = "${local.project}-iuvgenerator-cosmosdb-snet"
  address_prefixes     = var.cidr_subnet_iuvgenerator_cosmosdb
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.vnet_name

  private_endpoint_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]
}

module "iuvgenerator_cosmosdb_account" {
  source   = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_account?ref=v8.93.1"
  name     = "${local.project}-iuv-gen-cosmos-account"
  location = var.location
  domain   = var.domain

  resource_group_name = azurerm_resource_group.iuvgenerator_rg.name
  offer_type          = var.cosmos_iuvgenerator_db_params.offer_type
  kind                = var.cosmos_iuvgenerator_db_params.kind

  public_network_access_enabled    = var.cosmos_iuvgenerator_db_params.public_network_access_enabled
  main_geo_location_zone_redundant = var.cosmos_iuvgenerator_db_params.main_geo_location_zone_redundant

  enable_free_tier                             = var.cosmos_iuvgenerator_db_params.enable_free_tier
  enable_automatic_failover                    = true
  enable_provisioned_throughput_exceeded_alert = false

  capabilities       = var.cosmos_iuvgenerator_db_params.capabilities
  consistency_policy = var.cosmos_iuvgenerator_db_params.consistency_policy

  main_geo_location_location = var.location
  additional_geo_locations   = var.cosmos_iuvgenerator_db_params.additional_geo_locations
  backup_continuous_enabled  = var.cosmos_iuvgenerator_db_params.backup_continuous_enabled

  is_virtual_network_filter_enabled = var.cosmos_iuvgenerator_db_params.is_virtual_network_filter_enabled

  ip_range = ""

  # add data.azurerm_subnet.<my_service>.id
  allowed_virtual_network_subnet_ids = var.cosmos_iuvgenerator_db_params.public_network_access_enabled ? [] : [data.azurerm_subnet.aks_subnet.id]

  # private endpoint
  private_endpoint_sql_name  = "${local.project}-iuv-gen-cosmosdb-endpoint"
  private_endpoint_enabled   = var.cosmos_iuvgenerator_db_params.private_endpoint_enabled
  subnet_id                  = module.iuvgenerator_cosmosdb_snet.id
  private_dns_zone_sql_ids   = [data.azurerm_private_dns_zone.cosmos.id]
  private_dns_zone_table_ids = [data.azurerm_private_dns_zone.cosmos_table.id]

  tags = module.tag_config.tags
}

# cosmosdb table storage
resource "azurerm_cosmosdb_table" "iuvgenerator_cosmosdb_tables" {
  for_each = { for c in local.iuvgenerator_cosmosdb_tables : c.name => c }

  name                = replace("${each.value.name}-table", "-", "")
  resource_group_name = azurerm_resource_group.iuvgenerator_rg.name
  account_name        = module.iuvgenerator_cosmosdb_account.name
  throughput          = each.value.throughput
}
