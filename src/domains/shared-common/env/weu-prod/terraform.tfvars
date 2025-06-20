prefix               = "pagopa"
env_short            = "p"
env                  = "prod"
domain               = "shared"
location             = "westeurope"
location_short       = "weu"
instance             = "prod"
location_short_italy = "itn"
location_italy       = "italynorth"


### External resources

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"

### Aks

ingress_load_balancer_ip = "10.1.100.250"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.platform"

# CosmosDb IUV Generator
cosmos_iuvgenerator_db_params = {
  kind         = "GlobalDocumentDB"
  capabilities = ["EnableTable"]
  offer_type   = "Standard"
  consistency_policy = {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  server_version                   = "4.0"
  main_geo_location_zone_redundant = true
  enable_free_tier                 = false

  additional_geo_locations = [{
    location          = "northeurope"
    failover_priority = 1
    zone_redundant    = false
  }]
  private_endpoint_enabled          = true
  public_network_access_enabled     = false
  is_virtual_network_filter_enabled = true

  backup_continuous_enabled = true

}

# CosmosDb Authorizer
cosmos_authorizer_db_params = {
  kind         = "GlobalDocumentDB"
  capabilities = []
  offer_type   = "Standard"
  consistency_policy = {
    consistency_level       = "Strong"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  server_version                   = "4.0"
  main_geo_location_zone_redundant = true
  enable_free_tier                 = false

  private_endpoint_enabled      = true
  public_network_access_enabled = false

  additional_geo_locations = [{
    location          = "northeurope"
    failover_priority = 1
    zone_redundant    = false
  }]

  is_virtual_network_filter_enabled = true

  backup_continuous_enabled = true
}


cidr_subnet_iuvgenerator_cosmosdb = ["10.1.150.0/24"]
cidr_subnet_authorizer_cosmosdb   = ["10.1.168.0/24"]
storage_private_endpoint_enabled  = true

# Taxonomy
cidr_subnet_taxonomy_storage_account = ["10.1.186.0/24"]
taxonomy_storage_account = {
  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  account_replication_type      = "GZRS"
  blob_versioning_enabled       = true
  advanced_threat_protection    = true
  public_network_access_enabled = true
  blob_delete_retention_days    = 31
  enable_low_availability_alert = true
  backup_enabled                = true
  backup_retention              = 30
}

taxonomy_network_rules = {
  default_action             = "Deny"
  ip_rules                   = ["18.159.227.69", "3.126.198.129", "18.192.147.151"]
  virtual_network_subnet_ids = []
  bypass                     = ["AzureServices"]
}

redis_ha_enabled          = true
github_runner_ita_enabled = true
