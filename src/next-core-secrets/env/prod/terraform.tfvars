prefix         = "pagopa"
env_short      = "p"
env            = "prod"
domain         = "core"
location       = "westeurope"
location_short = "weu"
instance       = "prod"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/printit-secrets"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
  domain      = "core"
}

input_file = "./secret/prod/configs.json"

enable_iac_pipeline = true





