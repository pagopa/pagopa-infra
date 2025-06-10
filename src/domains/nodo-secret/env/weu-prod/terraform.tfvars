prefix          = "pagopa"
env_short       = "p"
env             = "prod"
domain          = "nodo"
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

az_nodo_sa_share_name_firmatore = "firmatore"
upload_firmatore = {
  "firmatore.zip" = "./env/weu-prod/resources/firmatore.zip"
}

cacerts_path = "./env/weu-prod/resources/cacerts"

certs_storage_account_replication_type = "GZRS"


nodo_cert_storage_account = {
  blob_versioning_enabled       = true
  advanced_threat_protection    = false
  blob_delete_retention_days    = 31
  public_network_access_enabled = false
  backup_enabled                = true
  backup_retention              = 30
}
