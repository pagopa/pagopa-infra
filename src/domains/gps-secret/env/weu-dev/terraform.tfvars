prefix          = "pagopa"
env_short       = "d"
env             = "dev"
domain          = "gps"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "dev"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/gps-secret"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
  domain      = "gps"
}

### External resources

input_file = "./secret/weu-dev/configs.json"

enable_iac_pipeline = true
