prefix          = "pagopa"
env_short       = "u"
env             = "uat"
domain          = "apiconfig"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "uat"


### External resources

monitor_resource_group_name                 = "pagopa-u-monitor-rg"
log_analytics_workspace_name                = "pagopa-u-law"
log_analytics_workspace_resource_group_name = "pagopa-u-monitor-rg"

input_file = "./secret/weu-uat/configs.json"

enable_iac_pipeline = true

cacerts_path = "./env/weu-uat/resources/cacerts"
