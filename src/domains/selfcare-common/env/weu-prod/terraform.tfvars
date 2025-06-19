prefix         = "pagopa"
env_short      = "p"
env            = "prod"
domain         = "selfcare"
location       = "westeurope"
location_short = "weu"
instance       = "prod"
env_capital    = "Prod"


### External resources

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"
application_insights_name                   = "pagopa-p-appinsights"

### Aks

ingress_load_balancer_ip = "10.1.100.250"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.platform"

enable_iac_pipeline = true

# CosmosDB Bo Pagopa Datastore
bopagopa_datastore_cosmos_db_params = {
  kind = "MongoDB"
  # capabilities = ["EnableMongo", "EnableServerless"]
  capabilities = ["EnableMongo", "EnableMongo16MBDocumentSupport"]
  offer_type   = "Standard"
  consistency_policy = {
    consistency_level       = "Strong" // "BoundedStaleness"
    max_interval_in_seconds = 5        // 300
    max_staleness_prefix    = 100      // 100000
  }
  server_version                   = "4.0"
  main_geo_location_zone_redundant = true
  enable_free_tier                 = false

  additional_geo_locations = [{
    location          = "northeurope"
    failover_priority = 1
    zone_redundant    = false
  }]
  private_endpoint_enabled      = true
  public_network_access_enabled = false

  is_virtual_network_filter_enabled = true

  backup_continuous_enabled = true

  container_default_ttl = 315576000 # 10 year in second
}

cosmosdb_mongodb_max_throughput = 8000 # increse see https://pagopa.atlassian.net/wiki/spaces/VAS/pages/884375607/Generazione+CSV+IBAN#Cron-Job

# CosmosDb MongoDb
cidr_subnet_cosmosdb_mongodb = ["10.1.166.0/24"]
# cosmosdb_mongodb_extra_capabilities = ["EnableServerless"]
cosmosdb_mongodb_enable_autoscaling = true
