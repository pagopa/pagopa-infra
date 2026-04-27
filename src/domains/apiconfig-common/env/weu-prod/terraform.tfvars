prefix         = "pagopa"
env_short      = "p"
env            = "prod"
domain         = "apiconfig"
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

# CosmosDb AFM Marketplace
enable_iac_pipeline         = true
api_config_replication_type = "GZRS"

enable_apiconfig_sa_backup                 = true
api_config_reporting_delete_retention_days = 31
api_config_reporting_backup_retention_days = 30
api_config_enable_versioning               = true
redis_ha_enabled                           = true
