prefix          = "pagopa"
env_short       = "d"
env             = "dev"
domain          = "nodo"
location        = "northeurope"
location_short  = "neu"
location_string = "North Europe"
instance        = "dev"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/nodo-secret"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "pagopa-d-neu-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-neu-law"
log_analytics_workspace_resource_group_name = "pagopa-d-neu-monitor-rg"

input_file = "./secret/neu-dev/configs.json"

enable_iac_pipeline = true

az_nodo_sa_share_name_firmatore = "firmatore"
upload_firmatore = {
  "firmatore.zip" = "./env/neu-dev/resources/firmatore.zip"
}

cacerts_path = "./env/neu-dev/resources/cacerts"