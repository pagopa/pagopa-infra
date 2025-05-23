prefix          = "pagopa"
env_short       = "d"
env             = "dev"
domain          = "receipts"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "dev"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/fdr-secret"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
  domain      = "receipts"
}

### External resources

monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"

input_file = "./secret/weu-dev/configs.json"

enable_iac_pipeline = true
