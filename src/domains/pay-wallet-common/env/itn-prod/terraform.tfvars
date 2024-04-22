prefix         = "pagopa"
env_short      = "p"
env            = "prod"
domain         = "pay-wallet"
location       = "italynorth"
location_short = "itn"
instance       = "prod"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/pay-wallet-common"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### FEATURES FLAGS
is_feature_enabled = {
  cosmos = false
  redis = false
  storage = false
}

### NETWORK

cidr_subnet_cosmosdb_pay_wallet = ["10.3.8.0/24"]
cidr_subnet_eventhubs_pay_wallet = ["10.3.9.0/24"]
cidr_subnet_storage_pay_wallet  = ["10.3.10.0/24"]
cidr_subnet_redis_pay_wallet = ["10.3.11.0/24"]
cidr_subnet_postgresql_pay_wallet = ["10.3.12.0/24"]

### External resources

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"

ingress_load_balancer_ip = "10.3.2.250"

### dns

external_domain          = "pagopa.it"
dns_zone_prefix          = "payment-wallet"
dns_zone_internal_prefix = "internal.platform"

### Cosmos

cosmos_mongo_db_params = {
  kind         = "MongoDB"
  capabilities = ["EnableMongo"]
  offer_type   = "Standard"
  consistency_policy = {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 5
    max_staleness_prefix    = 100000
  }
  server_version                   = "4.0"
  main_geo_location_zone_redundant = true
  enable_free_tier                 = false

  additional_geo_locations = [{
    location          = "germanywestcentral"
    failover_priority = 1
    zone_redundant    = false
  }]
  private_endpoint_enabled          = true
  public_network_access_enabled     = false
  is_virtual_network_filter_enabled = false

  backup_continuous_enabled = true

}

cosmos_mongo_db_pay_wallet_params = {
  enable_serverless  = false
  enable_autoscaling = true
  max_throughput     = 1000
  throughput         = 1000
}


### Redis

redis_pay_wallet_params = {
  capacity = 0
  sku_name = "Premium"
  family   = "C"
  version  = 6
  zones    = []
}


### Storage

pay_wallet_storage_params = {
  enabled                       = true
  tier                          = "Standard"
  kind                          = "StorageV2"
  account_replication_type      = "GZRS",
  advanced_threat_protection    = true,
  retention_days                = 30,
  public_network_access_enabled = false,
}

