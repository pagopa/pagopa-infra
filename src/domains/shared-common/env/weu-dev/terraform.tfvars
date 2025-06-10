prefix               = "pagopa"
env_short            = "d"
env                  = "dev"
domain               = "shared"
location             = "westeurope"
location_short       = "weu"
instance             = "dev"
location_short_italy = "itn"
location_italy       = "italynorth"


### External resources

monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"

### Aks

ingress_load_balancer_ip = "10.1.100.250"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.dev.platform"

# CosmosDb IUV Generator
cosmos_iuvgenerator_db_params = {
  kind         = "GlobalDocumentDB"
  capabilities = ["EnableTable"]
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

}

# CosmosDb Authorizer
cosmos_authorizer_db_params = {
  kind         = "GlobalDocumentDB"
  capabilities = ["EnableServerless"]
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
}


cidr_subnet_iuvgenerator_cosmosdb = ["10.1.150.0/24"]
cidr_subnet_authorizer_cosmosdb   = ["10.1.168.0/24"]

cidr_subnet_taxonomy_storage_account = ["10.1.186.0/24"]
taxonomy_storage_account = {
  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  blob_versioning_enabled       = false
  advanced_threat_protection    = false
  public_network_access_enabled = true
  blob_delete_retention_days    = 0
  enable_low_availability_alert = false
}

cidr_subnet_test_data_storage_account = ["10.1.188.0/24"]
test_data_storage_account = {
  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  blob_versioning_enabled       = false
  advanced_threat_protection    = false
  public_network_access_enabled = true
  blob_delete_retention_days    = 7
  enable_low_availability_alert = false
}

redis_ha_enabled = false

github_runner_ita_enabled = true
