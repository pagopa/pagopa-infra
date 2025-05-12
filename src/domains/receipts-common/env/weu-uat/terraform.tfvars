prefix         = "pagopa"
env_short      = "u"
env            = "uat"
domain         = "receipts"
location       = "westeurope"
location_short = "weu"
instance       = "uat"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/receipts"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
  domain      = "receipts"
}

### External resources

monitor_resource_group_name                 = "pagopa-u-monitor-rg"
log_analytics_workspace_name                = "pagopa-u-law"
log_analytics_workspace_resource_group_name = "pagopa-u-monitor-rg"
application_insights_name                   = "pagopa-u-appinsights"

### Aks

ingress_load_balancer_ip = "10.1.100.250"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.uat.platform"

# CosmosDB Receipts Datastore
receipts_datastore_cosmos_db_params = {
  kind         = "GlobalDocumentDB"
  capabilities = []
  offer_type   = "Standard"
  consistency_policy = {
    consistency_level       = "Strong"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  server_version                   = "4.0"
  main_geo_location_zone_redundant = false
  enable_free_tier                 = false

  additional_geo_locations          = []
  private_endpoint_enabled          = true
  public_network_access_enabled     = false
  is_virtual_network_filter_enabled = true

  backup_continuous_enabled = false

  container_default_ttl = 2629800 # 1 month in second

  max_throughput     = 1000
  max_throughput_alt = 1000
}

cidr_subnet_receipts_datastore_cosmosdb = ["10.1.171.0/24"]
cidr_subnet_receipts_datastore_storage  = ["10.1.172.0/24"]

enable_iac_pipeline = true
