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
  Owner       = "IO"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/afm"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

lock_enable = true

terraform_remote_state_core = {
  resource_group_name  = "io-infra-rg"
  storage_account_name = "pagopainfraterraformprod"
  container_name       = "azureadstate"
  key                  = "prod.terraform.tfstate"
}

### External resources

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"
ingress_load_balancer_ip                    = "10.1.100.250"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.platform"
apim_dns_zone_prefix     = "platform"

# CosmosDb AFM Marketplace
afm_marketplace_cosmos_db_params = {
  kind         = "GlobalDocumentDB"
  capabilities = ["EnableServerless"]
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

cidr_subnet_afm_marketplace_cosmosdb = ["10.1.151.0/24"]
cidr_subnet_afm_storage              = ["10.1.155.0/24"]

afm_storage_params = {
  enabled                    = true
  tier                       = "Standard"
  kind                       = "StorageV2"
  account_replication_type   = "LRS",
  advanced_threat_protection = true,
  retention_days             = 7
}

storage_private_endpoint_enabled = false
