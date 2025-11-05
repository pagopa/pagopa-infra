prefix         = "pagopa"
env_short      = "p"
env            = "prod"
domain         = "bizevents"
location       = "westeurope"
location_short = "weu"
instance       = "prod"


### External resources

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"
application_insights_name                   = "pagopa-p-appinsights"

### Aks

ingress_load_balancer_ip = "10.1.100.250"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.platform"
apim_dns_zone_prefix     = "platform"

# CosmosDB Biz Events Datastore
bizevents_datastore_cosmos_db_params = {
  kind         = "GlobalDocumentDB"
  capabilities = []
  offer_type   = "Standard"
  consistency_policy = {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  server_version                   = "4.0"
  main_geo_location_zone_redundant = true
  enable_free_tier                 = false

  private_endpoint_enabled      = true
  public_network_access_enabled = true

  additional_geo_locations = [{
    location          = "northeurope"
    failover_priority = 1
    zone_redundant    = false
  }]

  is_virtual_network_filter_enabled = false

  //set ip_range_filter to allow azure services (0.0.0.0) and azure portal.
  ip_range_filter = "104.42.195.92,40.76.54.131,52.176.6.30,52.169.50.45,52.187.184.26,0.0.0.0"

  backup_continuous_enabled = true

  container_default_ttl = 315576000 # 10 year in second

  max_throughput          = 42000
  max_throughput_view     = 44000
  max_throughput_view_alt = 80000
}

# CosmosDB Negative Biz Events Datastore
negative_bizevents_datastore_cosmos_db_params = {
  kind         = "GlobalDocumentDB"
  capabilities = []
  offer_type   = "Standard"
  consistency_policy = {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  server_version                   = "4.0"
  main_geo_location_zone_redundant = true
  enable_free_tier                 = false

  private_endpoint_enabled      = true
  public_network_access_enabled = false

  additional_geo_locations = [{
    location          = "northeurope"
    failover_priority = 1
    zone_redundant    = false
  }]

  is_virtual_network_filter_enabled = true

  backup_continuous_enabled = true

  container_default_ttl = 315576000 # 10 year in second

  max_throughput = 4000
}

cidr_subnet_bizevents_datastore_cosmosdb = ["10.1.156.0/24"]

enable_iac_pipeline              = true
storage_account_replication_type = "GZRS"
redis_ha_enabled                 = true

