prefix          = "pagopa"
env_short       = "u"
env             = "uat"
domain          = "nodo"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "uat"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/nodo-secret"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "pagopa-u-monitor-rg"
log_analytics_workspace_name                = "pagopa-u-law"
log_analytics_workspace_resource_group_name = "pagopa-u-monitor-rg"

input_file = "./secret/weu-uat/configs.json"

enable_iac_pipeline = true

### SP for use keyvault with access read only
az_nodo_app_kv_ro_policy_name = "app-kv-ro-nodo-uat"

az_nodo_sa_share_name_cert      = "certificates"
az_nodo_sa_share_name_firmatore = "firmatore"
upload_certificates = {
  "java_cacerts" = "./env/uat/resources/cacerts"
}

upload_firmatore = {
  "firmatore.zip" = "./env/uat/resources/firmatore-sit.zip"
}