prefix          = "pagopa"
env_short       = "d"
env             = "dev"
domain          = "afm"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "dev"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/afm-secret"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
  domain      = "afm"
}

### External resources

input_file = "./secret/weu-dev/configs.json"

enable_iac_pipeline = true
