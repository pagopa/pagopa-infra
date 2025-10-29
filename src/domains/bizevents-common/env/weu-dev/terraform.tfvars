prefix         = "pagopa"
env_short      = "d"
env            = "dev"
domain         = "bizevents"
location       = "westeurope"
location_short = "weu"
instance       = "dev"


### External resources

monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"
application_insights_name                   = "pagopa-d-appinsights"

### Aks

ingress_load_balancer_ip = "10.1.100.250"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.dev.platform"

# CosmosDB Biz Events Datastore
bizevents_datastore_cosmos_db_params = {
  kind         = "GlobalDocumentDB"
  capabilities = ["EnableServerless"]
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
  private_endpoint_enabled          = false
  public_network_access_enabled     = true
  is_virtual_network_filter_enabled = false

  ip_range_filter = ""

  backup_continuous_enabled = false

  container_default_ttl = 2629800 # 1 month in second

  max_throughput          = 1000
  max_throughput_view     = 1000
  max_throughput_view_alt = 1000

  burst_capacity_enabled  = true
}

# CosmosDB Negative Biz Events Datastore
negative_bizevents_datastore_cosmos_db_params = {
  kind         = "GlobalDocumentDB"
  capabilities = ["EnableServerless"]
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
  private_endpoint_enabled          = false
  public_network_access_enabled     = true
  is_virtual_network_filter_enabled = false

  backup_continuous_enabled = false

  container_default_ttl = 2629800 # 1 month in second

  max_throughput = 1000

  burst_capacity_enabled  = true
}

cidr_subnet_bizevents_datastore_cosmosdb = ["10.1.156.0/24"]

enable_iac_pipeline = true
redis_ha_enabled    = false

