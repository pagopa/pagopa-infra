prefix          = "pagopa"
env_short       = "u"
env             = "uat"
domain          = "gps"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "uat"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/gps-secret"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
  domain      = "gps"
}

### External resources

input_file = "./secret/weu-uat/configs.json"

enable_iac_pipeline = true