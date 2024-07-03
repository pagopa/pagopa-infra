resource "azurerm_resource_group" "cosmosdb_rg" {
  name     = "${local.project}-cosmosdb-paymentsdb-rg"
  location = var.location

  tags = var.tags
}

module "cosmosdb_paymentsdb_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.15.1"
  name                 = "${local.project}-cosmosb-paymentsdb-snet"
  address_prefixes     = var.cidr_subnet_cosmosdb_paymentsdb
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = module.vnet.name

  enforce_private_link_endpoint_network_policies = true
  service_endpoints                              = ["Microsoft.Web"]
}

module "cosmos_payments_account" {
  source   = "git::https://github.com/pagopa/azurerm.git//cosmosdb_account?ref=v2.1.18"
  name     = "${local.project}-payments-cosmos-account"
  location = var.location

  resource_group_name = azurerm_resource_group.cosmosdb_rg.name
  offer_type          = var.cosmos_document_db_params.offer_type
  kind                = var.cosmos_document_db_params.kind

  public_network_access_enabled    = var.cosmos_document_db_params.public_network_access_enabled
  main_geo_location_zone_redundant = var.cosmos_document_db_params.main_geo_location_zone_redundant

  enable_free_tier          = var.cosmos_document_db_params.enable_free_tier
  enable_automatic_failover = true

  capabilities       = var.cosmos_document_db_params.capabilities
  consistency_policy = var.cosmos_document_db_params.consistency_policy

  main_geo_location_location = var.location
  additional_geo_locations   = var.cosmos_document_db_params.additional_geo_locations
  backup_continuous_enabled  = var.cosmos_document_db_params.backup_continuous_enabled

  is_virtual_network_filter_enabled = var.cosmos_document_db_params.is_virtual_network_filter_enabled

  ip_range = ""

  # add data.azurerm_subnet.<my_service>.id
  allowed_virtual_network_subnet_ids = var.cosmos_document_db_params.public_network_access_enabled ? [] : []

  # private endpoint
  private_endpoint_name    = "${local.project}-cosmos-payments-sql-endpoint"
  private_endpoint_enabled = var.cosmos_document_db_params.private_endpoint_enabled
  subnet_id                = module.cosmosdb_paymentsdb_snet.id
  private_dns_zone_ids     = [data.azurerm_private_dns_zone.privatelink_documents_azure_com.id]

  tags = var.tags

}

## Database
module "payments_cosmos_db" {
  source              = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_database?ref=v2.1.15"
  name                = "db"
  resource_group_name = azurerm_resource_group.cosmosdb_rg.name
  account_name        = module.cosmos_payments_account.name
}

### Containers
locals {
  payments_cosmosdb_containers = [
    # https://pagopa.atlassian.net/wiki/spaces/PAG/pages/497746877/Design+Review+-+Evento+di+pagamento#Struttura-JSON-evento-business
    {
      name               = "payments-events"
      partition_key_path = "/creditor/idPA"
      autoscale_settings = { max_throughput = 6000 }
    },

  ]
}

module "payments_cosmosdb_containers" {
  source   = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_container?ref=v3.2.4"
  for_each = { for c in local.payments_cosmosdb_containers : c.name => c }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.cosmosdb_rg.name
  account_name        = module.cosmos_payments_account.name
  database_name       = module.payments_cosmos_db.name
  partition_key_path  = each.value.partition_key_path
  throughput          = lookup(each.value, "throughput", null)

  autoscale_settings = contains(var.cosmos_document_db_params.capabilities, "EnableServerless") ? null : lookup(each.value, "autoscale_settings", null)
}
