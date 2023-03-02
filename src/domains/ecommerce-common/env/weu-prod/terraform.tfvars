prefix          = "pagopa"
env_short       = "p"
env             = "prod"
domain          = "ecommerce"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "prod"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/ecommerce-app"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.platform"

### AKS

ingress_load_balancer_ip = "10.1.100.250"

### Cosmos DBs

cosmos_mongo_db_params_strong = {
  enabled      = true
  kind         = "MongoDB"
  capabilities = ["EnableMongo"]
  offer_type   = "Standard"
  consistency_policy = {
    consistency_level       = "Strong"
    max_interval_in_seconds = null
    max_staleness_prefix    = null
  }
  server_version                   = "4.0"
  main_geo_location_zone_redundant = false
  enable_free_tier                 = false

  additional_geo_locations = [{
    location          = "northeurope"
    failover_priority = 1
    zone_redundant    = false
  }]
  private_endpoint_enabled          = true
  public_network_access_enabled     = true
  is_virtual_network_filter_enabled = true

  backup_continuous_enabled = false
}

cosmos_mongo_db_params = {
  enabled      = true
  kind         = "MongoDB"
  capabilities = ["EnableMongo"]
  offer_type   = "Standard"
  consistency_policy = {
    consistency_level       = "Session"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  server_version                   = "4.0"
  main_geo_location_zone_redundant = false
  enable_free_tier                 = false

  additional_geo_locations = [{
    location          = "northeurope"
    failover_priority = 1
    zone_redundant    = false
  }]
  private_endpoint_enabled          = true
  public_network_access_enabled     = true
  is_virtual_network_filter_enabled = true

  backup_continuous_enabled = false
}

# TODO: check IP stack
cidr_subnet_cosmosdb_ecommerce = ["10.1.153.0/24"]
cidr_subnet_redis_ecommerce    = ["10.1.148.0/24"]
cidr_subnet_storage_ecommerce  = ["10.1.154.0/24"]

cosmos_mongo_db_ecommerce_params = {
  enable_serverless  = true
  enable_autoscaling = true
  max_throughput     = 5000
  throughput         = 1000
}

redis_ecommerce_params = {
  capacity = 0
  sku_name = "Basic"
  family   = "C"
}

ecommerce_storage_params = {
  enabled                    = true
  tier                       = "Standard"
  kind                       = "StorageV2"
  account_replication_type   = "LRS",
  advanced_threat_protection = true,
  retention_days             = 7
}

enable_iac_pipeline = true