prefix         = "pagopa"
env_short      = "u"
env            = "uat"
domain         = "core-itn"
location       = "italynorth"
location_short = "itn"
instance       = "uat"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/printit-secrets"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
  domain      = "core"
}

input_file = "./secret/itn-uat/configs.json"

enable_iac_pipeline = true





