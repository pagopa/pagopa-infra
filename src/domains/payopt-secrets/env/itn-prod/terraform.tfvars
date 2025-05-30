prefix         = "pagopa"
env_short      = "p"
env            = "prod"
domain         = "payopt"
location       = "italynorth"
location_short = "itn"
instance       = "prod"


### External resources

monitor_italy_resource_group_name                 = "pagopa-p-itn-core-monitor-rg"
log_analytics_italy_workspace_name                = "pagopa-p-itn-core-law"
log_analytics_italy_workspace_resource_group_name = "pagopa-p-itn-core-monitor-rg"

input_file = "./secret/itn-prod/configs.json"

enable_iac_pipeline = true

