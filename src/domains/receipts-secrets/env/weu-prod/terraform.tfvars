prefix          = "pagopa"
env_short       = "p"
env             = "prod"
domain          = "receipts"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "prod"


### External resources

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"

input_file = "./secret/weu-prod/configs.json"

enable_iac_pipeline = true
