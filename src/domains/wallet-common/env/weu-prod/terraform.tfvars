prefix         = "pagopa"
env_short      = "p"
env            = "prod"
domain         = "wallet"
location       = "westeurope"
location_short = "weu"
instance       = "prod"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/wallet-common"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"

### Aks

ingress_load_balancer_ip = "10.1.100.250"

## DNS

dns_zone_prefix          = "payment-wallet"
dns_zone_platform        = "platform"
external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.platform"

### Cosmos

cosmos_mongo_db_params = {
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

  additional_geo_locations          = []
  private_endpoint_enabled          = true
  public_network_access_enabled     = false
  is_virtual_network_filter_enabled = true

  backup_continuous_enabled = false

}

cidr_subnet_cosmosdb_wallet = ["10.1.169.0/24"]
cidr_subnet_redis_wallet    = ["10.1.174.0/24"]
cidr_subnet_storage_wallet  = ["10.1.175.0/24"]

cosmos_mongo_db_wallet_params = {
  enable_serverless  = false
  enable_autoscaling = true
  max_throughput     = 1000
  throughput         = 1000
}

redis_wallet_params = {
  capacity = 1
  sku_name = "Premium"
  family   = "P"
  version  = 6
  zones    = [1, 2, 3]
}

enable_iac_pipeline = true

wallet_storage_params = {
  enabled                       = true
  tier                          = "Standard"
  kind                          = "StorageV2"
  account_replication_type      = "GZRS",
  advanced_threat_protection    = true,
  retention_days                = 30,
  public_network_access_enabled = false,
}
