prefix          = "pagopa"
env_short       = "d"
env             = "dev"
domain          = "nodo"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "dev"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/nodo-secret"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"

input_file = "./secret/weu-dev/configs.json"

enable_iac_pipeline = true

### SP for use keyvault with access read only
az_nodo_app_kv_ro_policy_name = "app-kv-ro-nodo-dev"

az_nodo_sa_share_name = "certificates"
upload_certificates = {
  "cacerts-dev" = "./env/dev/resources/dev/cacerts"
  "casogei-dev" = "./env/dev/resources/dev/CASogeiTest.pem"
  "cacerts-sit" = "./env/dev/resources/sit/cacerts"
  "casogei-sit" = "./env/dev/resources/sit/CASogeiTest.pem"
}

