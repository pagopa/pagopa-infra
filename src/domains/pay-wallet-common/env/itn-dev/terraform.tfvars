prefix         = "pagopa"
env_short      = "d"
env            = "dev"
domain         = "pay-wallet"
location       = "italynorth"
cdn_location   = "westeurope"
location_short = "itn"
instance       = "dev"


### FEATURES FLAGS
is_feature_enabled = {
  cosmos  = true
  redis   = true
  storage = true
}


### External resources

monitor_italy_resource_group_name                 = "pagopa-d-itn-core-monitor-rg"
log_analytics_italy_workspace_name                = "pagopa-d-itn-core-law"
log_analytics_italy_workspace_resource_group_name = "pagopa-d-itn-core-monitor-rg"

### NETWORK

cidr_subnet_cosmosdb_pay_wallet = ["10.3.5.0/27"]
cidr_subnet_redis_pay_wallet    = ["10.3.5.64/27"]
cidr_subnet_storage_pay_wallet  = ["10.3.5.96/27"]
cidr_subnet_pay_wallet_user_aks = ["10.3.6.0/24"]

### AKS
ingress_load_balancer_ip = "10.3.2.250"

### DNS

external_domain          = "pagopa.it"
dns_zone_prefix          = "dev.payment-wallet"
dns_zone_internal_prefix = "internal.dev.platform"
dns_zone_platform        = "dev.platform"

### Cosmos

cosmos_mongo_db_params = {
  kind         = "MongoDB"
  capabilities = ["EnableMongo", "EnableServerless"]
  offer_type   = "Standard"
  consistency_policy = {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 5
    max_staleness_prefix    = 100000
  }
  server_version                   = "6.0"
  main_geo_location_zone_redundant = false
  enable_free_tier                 = false

  additional_geo_locations                     = []
  private_endpoint_enabled                     = false
  public_network_access_enabled                = true
  is_virtual_network_filter_enabled            = false
  enable_provisioned_throughput_exceeded_alert = false
  backup_continuous_enabled                    = false
  ip_range_filter                              = []
}

cosmos_mongo_db_pay_wallet_params = {
  enable_serverless  = true
  enable_autoscaling = true
  max_throughput     = 2000
  throughput         = 2000
}


### Redis

redis_pay_wallet_params = {
  capacity = 0
  sku_name = "Basic"
  family   = "C"
  version  = 6
  zones    = []
}

redis_std_pay_wallet_params = {
  capacity = 0
  sku_name = "Basic"
  family   = "C"
  version  = 6
  zones    = []
}

### Storage

pay_wallet_storage_params = {
  enabled                       = true
  tier                          = "Standard"
  kind                          = "StorageV2"
  account_replication_type      = "LRS",
  advanced_threat_protection    = false,
  retention_days                = 7,
  public_network_access_enabled = true,
}

# AKS
aks_user_node_pool = {
  enabled         = true,
  name            = "padakswalusr",
  vm_size         = "Standard_B8ms",
  os_disk_type    = "Managed",
  os_disk_size_gb = 75,
  node_count_min  = 1,
  node_count_max  = 3,
  node_labels     = { node_name : "aks-pay-wallet-user", node_type : "user", domain : "paywallet" },
  node_taints     = ["paymentWalletOnly=true:NoSchedule"],
  node_tags       = { payWallet : "true" },
}
payment_wallet_service_api_key_use_primary = true

pay_wallet_jwt_issuer_api_key_use_primary = true
