prefix         = "pagopa"
env_short      = "u"
env            = "uat"
domain         = "ecommerce"
location       = "westeurope"
location_short = "weu"
instance       = "uat"


### External resources

monitor_resource_group_name                 = "pagopa-u-monitor-rg"
log_analytics_workspace_name                = "pagopa-u-law"
log_analytics_workspace_resource_group_name = "pagopa-u-monitor-rg"

### Aks

ingress_load_balancer_ip = "10.1.100.250"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.uat.platform"
dns_zone_ecommerce       = "uat.ecommerce"

### Cosmos

cosmos_mongo_db_params = {
  enabled      = true
  kind         = "MongoDB"
  capabilities = ["EnableMongo", "DisableRateLimitingResponses"]
  offer_type   = "Standard"
  consistency_policy = {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 5
    max_staleness_prefix    = 100000
  }
  server_version                   = "6.0"
  main_geo_location_zone_redundant = false
  enable_free_tier                 = false

  additional_geo_locations          = []
  private_endpoint_enabled          = true
  public_network_access_enabled     = false
  is_virtual_network_filter_enabled = true

  backup_continuous_enabled                    = false
  enable_provisioned_throughput_exceeded_alert = false

}

cidr_subnet_cosmosdb_ecommerce = ["10.1.153.0/24"]
cidr_subnet_redis_ecommerce    = ["10.1.148.0/24"]
cidr_subnet_storage_ecommerce  = ["10.1.154.0/24"]

cosmos_mongo_db_ecommerce_params = {
  enable_serverless  = false
  enable_autoscaling = true
  max_throughput     = 2000
  throughput         = 2000
}

cosmos_mongo_db_ecommerce_history_params = {
  enable_serverless  = false
  enable_autoscaling = true
  max_throughput     = 1000
  throughput         = 1000
}

redis_ecommerce_params = {
  capacity   = 0
  sku_name   = "Basic"
  family     = "C"
  version    = 6
  ha_enabled = false
  zones      = []
}

ecommerce_storage_transient_params = {
  enabled                       = true
  tier                          = "Standard"
  kind                          = "StorageV2"
  account_replication_type      = "LRS",
  advanced_threat_protection    = true,
  retention_days                = 7,
  public_network_access_enabled = false,
}

ecommerce_storage_deadletter_params = {
  enabled                       = true
  tier                          = "Standard"
  kind                          = "StorageV2"
  account_replication_type      = "LRS",
  advanced_threat_protection    = true,
  retention_days                = 7,
  public_network_access_enabled = false,
}

enable_iac_pipeline = true

ecommerce_jwt_issuer_api_key_use_primary = true
