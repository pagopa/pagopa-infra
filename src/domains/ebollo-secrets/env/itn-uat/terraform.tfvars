prefix         = "pagopa"
env_short      = "u"
env            = "uat"
domain         = "ebollo"
location       = "italynorth"
location_short = "itn"
instance       = "uat"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/ebollo-secrets"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
  domain      = "ebollo"
}

### External resources

monitor_italy_resource_group_name                 = "pagopa-u-itn-core-monitor-rg"
log_analytics_italy_workspace_name                = "pagopa-u-itn-core-law"
log_analytics_italy_workspace_resource_group_name = "pagopa-u-itn-core-monitor-rg"

input_file = "./secret/itn-uat/configs.json"

enable_iac_pipeline = true


