prefix          = "pagopa"
env_short       = "d"
env             = "dev"
domain          = "printit"
location        = "italynorth"
location_short  = "itn"
location_string = "Italy North"
instance        = "dev"


### External resources

monitor_italy_resource_group_name                 = "pagopa-d-itn-core-monitor-rg"
log_analytics_italy_workspace_name                = "pagopa-d-itn-core-law"
log_analytics_italy_workspace_resource_group_name = "pagopa-d-itn-core-monitor-rg"

monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.dev.platform"
dns_zone_prefix          = "printit.itn"
apim_dns_zone_prefix     = "dev.platform"
### Aks

ingress_load_balancer_ip = "10.3.2.250"

is_feature_enabled = {
  pdf_engine = true
  printit    = true
}

app_service_pdf_engine_sku_name               = "S1"
app_service_pdf_engine_autoscale_enabled      = false
app_service_pdf_engine_always_on              = true
app_service_pdf_engine_zone_balancing_enabled = false

app_service_pdf_engine_sku_name_java                        = "S1"
app_service_pdf_engine_sku_name_java_zone_balancing_enabled = false
