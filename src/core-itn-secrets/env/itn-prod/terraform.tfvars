prefix         = "pagopa"
env_short      = "p"
env            = "prod"
domain         = "core-itn"
location       = "italynorth"
location_short = "itn"
instance       = "prod"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/printit-secrets"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
  domain      = "core"
}

input_file = "./secret/itn-prod/configs.json"

enable_iac_pipeline = true





