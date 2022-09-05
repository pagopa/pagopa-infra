prefix         = "pagopa"
env_short      = "u"
env            = "uat"
domain         = "ecommerce"
location       = "westeurope"
location_short = "weu"
instance       = "uat"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/ecommerce-common"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

lock_enable = true

terraform_remote_state_core = {
  resource_group_name  = "io-infra-rg"
  storage_account_name = "pagopainfraterraformuat"
  container_name       = "azureadstate"
  key                  = "uat.terraform.tfstate"
}

### External resources

monitor_resource_group_name                 = "pagopa-u-monitor-rg"
log_analytics_workspace_name                = "pagopa-u-law"
log_analytics_workspace_resource_group_name = "pagopa-u-monitor-rg"

### Aks

ingress_load_balancer_ip = "10.1.100.250"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.uat.platform"

### Cosmos

cosmos_mongo_db_params = {
  enabled      = true
  kind         = "MongoDB"
  capabilities = ["EnableMongo", "EnableServerless"]
  offer_type   = "Standard"
  consistency_policy = {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  server_version                   = "4.0"
  main_geo_location_zone_redundant = false
  enable_free_tier                 = false

  additional_geo_locations          = []
  private_endpoint_enabled          = true
  public_network_access_enabled     = true
  is_virtual_network_filter_enabled = true

  backup_continuous_enabled = false

}

cidr_subnet_cosmosdb_ecommerce = ["10.1.153.0/24"]
cidr_subnet_redis_ecommerce    = ["10.1.148.0/24"]

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