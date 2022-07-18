prefix         = "pagopa"
env_short      = "d"
env            = "dev"
domain         = "gps"
location       = "westeurope"
location_short = "weu"
instance       = "dev"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "IO"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/gps"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

lock_enable = true

terraform_remote_state_core = {
  resource_group_name  = "io-infra-rg"
  storage_account_name = "pagopainfraterraformdev"
  container_name       = "azurermstate"
  key                  = "dev.terraform.tfstate"
}

### External resources

monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"

### Aks

ingress_load_balancer_ip = "10.1.100.250"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.dev.platform"

# CosmosDb GPS
cosmos_gps_db_params = {
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

cidr_subnet_gps_cosmosdb = ["10.1.149.0/24"]
