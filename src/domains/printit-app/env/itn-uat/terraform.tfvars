prefix          = "pagopa"
env_short       = "u"
env             = "uat"
domain          = "printit"
location        = "italynorth"
location_short  = "itn"
location_string = "Italy North"
instance        = "uat"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/printit-app"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_italy_resource_group_name                 = "pagopa-u-itn-core-monitor-rg"
log_analytics_italy_workspace_name                = "pagopa-u-itn-core-law"
log_analytics_italy_workspace_resource_group_name = "pagopa-u-itn-core-monitor-rg"

monitor_resource_group_name                 = "pagopa-u-monitor-rg"
log_analytics_workspace_name                = "pagopa-u-law"
log_analytics_workspace_resource_group_name = "pagopa-u-monitor-rg"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.uat.platform"
dns_zone_prefix          = "printit.itn"
apim_dns_zone_prefix     = "uat.platform"
### Aks

ingress_load_balancer_ip = "10.3.2.250"

is_feature_enabled = {
  pdf_engine = true
  printit    = true
}

app_service_pdf_engine_autoscale_enabled = true
app_service_pdf_engine_always_on         = true
app_service_pdf_engine_sku_name          = "S1"

app_service_pdf_engine_sku_name_java = "S1"
