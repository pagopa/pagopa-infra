prefix          = "pagopa"
env_short       = "p"
env             = "prod"
domain          = "gpdingestion"
location        = "italynorth"
location_short  = "itn"
location_string = "Italy North"
instance        = "prod"

tags = {
  CreatedBy   = "Terraform"
  Environment = "prod"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/gpdingestion-app"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_italy_resource_group_name                 = "pagopa-p-itn-core-monitor-rg"
log_analytics_italy_workspace_name                = "pagopa-p-itn-core-law"
log_analytics_italy_workspace_resource_group_name = "pagopa-p-itn-core-monitor-rg"

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.platform"
dns_zone_prefix          = "gpdingestion.itn"
apim_dns_zone_prefix     = "platform"
### Aks

ingress_load_balancer_ip = "10.3.2.250"

is_feature_enabled = {
  gpdingestion      = true
}

pod_disruption_budgets = {
  "gpd-ingestion-manager" = {
    minAvailable = 2
    matchLabels = {
      "app.kubernetes.io/instance" = "gpd-ingestion-manager"
    }
  },
}

zookeeper_replicas = 3
zookeeper_request_memory = "1024mi"
zookeeper_request_cpu = "1"
zookeeper_limits_memory = "1024mi"
zookeeper_limits_cpu = "1"
zookeeper_jvm_xms = "1024mi"
zookeeper_jvm_xmx = "1024mi"
zookeeper_storage_size = "100Gi"
replicas = 3
request_cpu = "1"
request_memory = "512mi"
limits_memory = "1024mi"
limits_cpu = "1"
postgres_db_name = "apd"
tasks_max = "5"
container_registry = "TBD"
