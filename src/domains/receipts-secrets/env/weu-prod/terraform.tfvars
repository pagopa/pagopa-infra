prefix          = "pagopa"
env_short       = "p"
env             = "prod"
domain          = "receipts"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "prod"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/fdr-secret"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
  domain      = "receipts"
}

### External resources

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"

input_file = "./secret/weu-prod/configs.json"

enable_iac_pipeline = true
