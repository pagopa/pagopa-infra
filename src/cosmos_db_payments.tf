resource "azurerm_resource_group" "cosmosdb_rg" {
  name     = format("%s-cosmosdb-paymentsdb-rg", local.project)
  location = var.location

  tags = var.tags
}

locals {
  cosmosdb_paymentsdb_enable_serverless = contains(var.cosmosdb_paymentsdb_extra_capabilities, "EnableServerless")
}

module "cosmosdb_paymentsdb_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.15.1"
  name                 = format("%s-cosmosb-paymentsdb-snet", local.project)
  address_prefixes     = var.cidr_subnet_cosmosdb_paymentsdb
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = module.vnet.name

  enforce_private_link_endpoint_network_policies = true
  service_endpoints                              = ["Microsoft.Web"]
}


module "cosmos_payments_account" {
  source   = "git::https://github.com/pagopa/azurerm.git//cosmosdb_account?ref=v2.1.18"
  name     = format("%s-payments-cosmos-account", local.project)
  location = var.location

  resource_group_name = azurerm_resource_group.cosmosdb_rg.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  public_network_access_enabled    = var.cosmosdb_paymentsdb_public_network_access_enabled
  main_geo_location_zone_redundant = false

  enable_free_tier          = false
  enable_automatic_failover = true


  consistency_policy = {
    consistency_level       = "Strong"
    max_interval_in_seconds = null
    max_staleness_prefix    = null
  }

  main_geo_location_location = "westeurope"

  additional_geo_locations = [
    {
      location          = "northeurope"
      failover_priority = 1
      zone_redundant    = true
    }
  ]

  backup_continuous_enabled = true

  is_virtual_network_filter_enabled = true

  ip_range = ""

  # add data.azurerm_subnet.<my_service>.id
  allowed_virtual_network_subnet_ids = [module.logic_app_biz_evt_snet.id]

  # private endpoint
  private_endpoint_name    = format("%s-cosmos-payments-sql-endpoint", local.project)
  private_endpoint_enabled = true
  subnet_id                = module.cosmosdb_paymentsdb_snet.id
  private_dns_zone_ids     = [azurerm_private_dns_zone.privatelink_payments_cosmos_azure_com.id]

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
      partition_key_path = "/idPA"
      autoscale_settings = {
        max_throughput = 6000
      },
    },

  ]
}

module "payments_cosmosdb_containers" {
  source   = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_container?ref=v2.1.8"
  for_each = { for c in local.payments_cosmosdb_containers : c.name => c }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.cosmosdb_rg.name
  account_name        = module.cosmos_payments_account.name
  database_name       = module.payments_cosmos_db.name
  partition_key_path  = each.value.partition_key_path
  throughput          = lookup(each.value, "throughput", null)

  autoscale_settings = lookup(each.value, "autoscale_settings", null)

}