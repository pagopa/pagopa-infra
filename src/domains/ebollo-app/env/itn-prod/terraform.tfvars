prefix          = "pagopa"
env_short       = "p"
env             = "prod"
domain          = "ebollo"
location        = "italynorth"
location_short  = "itn"
location_string = "Italy North"
instance        = "prod"


### External resources

monitor_italy_resource_group_name                 = "pagopa-p-itn-core-monitor-rg"
log_analytics_italy_workspace_name                = "pagopa-p-itn-core-law"
log_analytics_italy_workspace_resource_group_name = "pagopa-p-itn-core-monitor-rg"

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.platform"
dns_zone_prefix          = "ebollo.itn"
apim_dns_zone_prefix     = "platform"
### Aks

ingress_load_balancer_ip = "10.3.2.250"

pod_disruption_budgets = {
  "mbd-service" = {
    minAvailable = 2
    matchLabels = {
      "app.kubernetes.io/instance" = "mbd-service"
    }
  },
}
