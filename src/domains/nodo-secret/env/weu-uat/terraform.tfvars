prefix          = "pagopa"
env_short       = "u"
env             = "uat"
domain          = "nodo"
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

az_nodo_sa_share_name_firmatore = "firmatore"
upload_firmatore = {
  "firmatore.zip" = "./env/weu-uat/resources/firmatore.zip"
}

cacerts_path = "./env/weu-uat/resources/cacerts"
