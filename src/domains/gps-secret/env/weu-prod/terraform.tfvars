prefix          = "pagopa"
env_short       = "p"
env             = "prod"
domain          = "gps"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "prod"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/gps-secret"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

input_file = "./secret/weu-prod/configs.json"

enable_iac_pipeline = true