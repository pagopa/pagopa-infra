prefix         = "pagopa"
env_short      = "d"
env            = "dev"
domain         = "payopt"
location       = "italynorth"
location_short = "itn"
instance       = "dev"


### External resources

monitor_italy_resource_group_name                 = "pagopa-d-itn-core-monitor-rg"
log_analytics_italy_workspace_name                = "pagopa-d-itn-core-law"
log_analytics_italy_workspace_resource_group_name = "pagopa-d-itn-core-monitor-rg"

input_file = "./secret/itn-dev/configs.json"

enable_iac_pipeline = true

