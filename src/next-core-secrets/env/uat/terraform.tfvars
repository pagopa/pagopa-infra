prefix         = "pagopa"
env_short      = "u"
env            = "uat"
domain         = "core"
location       = "westeurope"
location_short = "weu"
instance       = "uat"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/printit-secrets"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

input_file = "./secret/uat/configs.json"

enable_iac_pipeline = true





