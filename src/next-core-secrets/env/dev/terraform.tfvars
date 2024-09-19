prefix         = "pagopa"
env_short      = "d"
env            = "dev"
domain         = "core"
location       = "westeurope"
location_short = "weu"
instance       = "dev"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/printit-secrets"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

input_file = "./secret/dev/configs.json"

enable_iac_pipeline = true





