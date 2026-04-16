prefix          = "pagopa"
env_short       = "p"
env             = "prod"
domain          = "printit"
location        = "italynorth"
location_short  = "itn"
location_string = "Italy North"
instance        = "prod"

### IDH Variables
idh_app_service_resource_tier = "premium"

### External resources

monitor_italy_resource_group_name                 = "pagopa-p-itn-core-monitor-rg"
log_analytics_italy_workspace_name                = "pagopa-p-itn-core-law"
log_analytics_italy_workspace_resource_group_name = "pagopa-p-itn-core-monitor-rg"

monitor_resource_group_name = "pagopa-p-monitor-rg"
external_domain             = "pagopa.it"
dns_zone_internal_prefix    = "internal.platform"
dns_zone_prefix             = "printit.itn"
apim_dns_zone_prefix        = "platform"
### Aks

ingress_load_balancer_ip = "10.3.2.250"



# pdf-engine
is_feature_enabled = {
  pdf_engine = true
  printit    = true
}
app_service_pdf_engine_always_on = true
pod_disruption_budgets = {
  "print-payment-notice-functions" = {
    minAvailable = 2
    matchLabels = {
      "app.kubernetes.io/instance" = "print-payment-notice-functions"
    }
  },
  "print-payment-notice-generator" = {
    minAvailable = 2
    matchLabels = {
      "app.kubernetes.io/instance" = "print-payment-notice-generator"
    }
  },
  "print-payment-notice-service" = {
    minAvailable = 2
    matchLabels = {
      "app.kubernetes.io/instance" = "print-payment-notice-service"
    }
  },
}
