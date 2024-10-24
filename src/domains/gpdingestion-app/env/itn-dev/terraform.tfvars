prefix          = "pagopa"
env_short       = "d"
env             = "dev"
domain          = "gpdingestion"
location        = "italynorth"
location_short  = "itn"
location_string = "Italy North"
instance        = "dev"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/gpdingestion-app"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_italy_resource_group_name                 = "pagopa-d-itn-core-monitor-rg"
log_analytics_italy_workspace_name                = "pagopa-d-itn-core-law"
log_analytics_italy_workspace_resource_group_name = "pagopa-d-itn-core-monitor-rg"

monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.dev.platform"
dns_zone_prefix          = "gpdingestion.itn"
apim_dns_zone_prefix     = "dev.platform"
### Aks

ingress_load_balancer_ip = "10.3.2.250"

is_feature_enabled = {
  gpdingestion      = true
}

zookeeper_replicas = 1
zookeeper_request_memory = "512mi"
zookeeper_request_cpu = "0.5"
zookeeper_limits_memory = "512mi"
zookeeper_limits_cpu = "0.5"
zookeeper_jvm_xms = "512mi"
zookeeper_jvm_xmx = "512mi"
zookeeper_storage_size = "100Gi"
replicas = 1
request_cpu = "0.5"
request_memory = "512mi"
limits_memory = "512mi"
limits_cpu = "0.5"
postgres_db_name = "apd"
tasks_max = "1"
container_registry = "TBD"
