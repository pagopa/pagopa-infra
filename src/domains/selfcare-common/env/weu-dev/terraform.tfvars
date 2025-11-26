prefix         = "pagopa"
env_short      = "d"
env            = "dev"
domain         = "selfcare"
location       = "westeurope"
location_short = "weu"
instance       = "dev"
env_capital    = "Dev"


### External resources

monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"
application_insights_name                   = "pagopa-d-appinsights"

### Aks

ingress_load_balancer_ip = "10.1.100.250"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.dev.platform"

enable_iac_pipeline = true


# CosmosDB BO pagopa Datastore
bopagopa_datastore_cosmos_db_params = {
  kind         = "MongoDB"
  capabilities = ["EnableMongo", "EnableServerless", "EnableMongo16MBDocumentSupport"]
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
}

# CosmosDb MongoDb
cidr_subnet_cosmosdb_mongodb        = ["10.1.166.0/24"]
cosmosdb_mongodb_extra_capabilities = ["EnableServerless"]
