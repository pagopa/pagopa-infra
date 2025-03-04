prefix         = "pagopa"
env_short      = "p"
env            = "prod"
domain         = "afm"
location       = "westeurope"
location_short = "weu"
instance       = "prod"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "pagopa"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/afm"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"
application_insights_name                   = "pagopa-p-appinsights"

### Aks

ingress_load_balancer_ip = "10.1.100.250"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.platform"
apim_dns_zone_prefix     = "platform"

# CosmosDb AFM Marketplace
afm_marketplace_cosmos_db_params = {
  kind         = "GlobalDocumentDB"
  capabilities = []
  offer_type   = "Standard"
  consistency_policy = {
    consistency_level       = "Strong" # "BoundedStaleness"
    max_interval_in_seconds = 5        # 300
    max_staleness_prefix    = 100      # 100000
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

  analytical_storage_enabled = true
}

cidr_subnet_afm_marketplace_cosmosdb = ["10.1.151.0/24"]
cidr_subnet_afm_storage              = ["10.1.155.0/24"]

afm_storage_params = {
  enable_backup                 = true
  enabled                       = true
  tier                          = "Standard"
  kind                          = "StorageV2"
  account_replication_type      = "GZRS",
  advanced_threat_protection    = true,
  retention_days                = 31,
  public_network_access_enabled = true,
  backup_retention_days         = 30
}

storage_private_endpoint_enabled = false

enable_iac_pipeline = true
