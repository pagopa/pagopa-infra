prefix         = "pagopa"
env_short      = "p"
env            = "prod"
domain         = "ecommerce"
location       = "westeurope"
location_short = "weu"
instance       = "prod"


### External resources

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"

### Aks

ingress_load_balancer_ip = "10.1.100.250"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.platform"

### Cosmos

cosmos_mongo_db_params = {
  enabled      = true
  kind         = "MongoDB"
  capabilities = ["EnableMongo", "DisableRateLimitingResponses"]
  offer_type   = "Standard"
  consistency_policy = {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  server_version                   = "6.0"
  main_geo_location_zone_redundant = true
  enable_free_tier                 = false
  additional_geo_locations = [{
    location          = "northeurope"
    failover_priority = 1
    zone_redundant    = false
  }]
  private_endpoint_enabled                     = true
  public_network_access_enabled                = false
  is_virtual_network_filter_enabled            = true
  backup_continuous_enabled                    = true
  enable_provisioned_throughput_exceeded_alert = false

}

cidr_subnet_cosmosdb_ecommerce = ["10.1.153.0/24"]
cidr_subnet_redis_ecommerce    = ["10.1.148.0/24"]
cidr_subnet_storage_ecommerce  = ["10.1.154.0/24"]

cosmos_mongo_db_ecommerce_params = {
  enable_serverless  = false
  enable_autoscaling = true
  max_throughput     = 25000
  throughput         = 1000
}

cosmos_mongo_db_ecommerce_history_params = {
  enable_serverless  = false
  enable_autoscaling = true
  max_throughput     = 15000
  throughput         = 1000
}

redis_ecommerce_params = {
  capacity   = 1
  sku_name   = "Premium"
  family     = "P"
  version    = 6
  ha_enabled = true
  zones      = [1, 2, 3]
}

ecommerce_storage_transient_params = {
  enabled                       = true
  tier                          = "Standard"
  kind                          = "StorageV2"
  account_replication_type      = "GZRS",
  advanced_threat_protection    = true,
  retention_days                = 30,
  public_network_access_enabled = false,
}

ecommerce_storage_deadletter_params = {
  enabled                       = true
  tier                          = "Standard"
  kind                          = "StorageV2"
  account_replication_type      = "GZRS",
  advanced_threat_protection    = true,
  retention_days                = 30,
  public_network_access_enabled = false,
}

enable_iac_pipeline = true

ecommerce_jwt_issuer_api_key_use_primary = true
