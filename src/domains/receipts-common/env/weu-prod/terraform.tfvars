prefix         = "pagopa"
env_short      = "p"
env            = "prod"
domain         = "receipts"
location       = "westeurope"
location_short = "weu"
instance       = "prod"


### External resources

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"
application_insights_name                   = "pagopa-p-appinsights"

### Aks

ingress_load_balancer_ip = "10.1.100.250"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.platform"

# CosmosDB Receipts Datastore
receipts_datastore_cosmos_db_params = {
  kind         = "GlobalDocumentDB"
  capabilities = []
  offer_type   = "Standard"
  consistency_policy = {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  server_version                   = "4.0"
  main_geo_location_zone_redundant = true
  enable_free_tier                 = false

  private_endpoint_enabled          = true
  public_network_access_enabled     = false
  is_virtual_network_filter_enabled = true

  additional_geo_locations = [{
    location          = "northeurope"
    failover_priority = 1
    zone_redundant    = false
  }]

  backup_continuous_enabled = true

  container_default_ttl = 315576000 # 10 year in second

  max_throughput     = 70000
  max_throughput_alt = 2000
}

cidr_subnet_receipts_datastore_cosmosdb = ["10.1.171.0/24"]
cidr_subnet_receipts_datastore_storage  = ["10.1.172.0/24"]

enable_iac_pipeline                       = true
receipts_storage_account_replication_type = "GZRS"

enable_sa_backup                               = true
receipts_datastore_fn_sa_delete_retention_days = 31
receipts_datastore_fn_sa_backup_retention_days = 30
