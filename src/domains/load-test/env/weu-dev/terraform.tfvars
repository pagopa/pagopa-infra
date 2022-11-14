prefix         = "pagopa"
env_short      = "d"
env            = "dev"
domain         = "shared"
location       = "westeurope"
location_short = "weu"
instance       = "dev"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "IO"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/load-test"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

dns_zone_prefix = "dev.platform"
external_domain = "pagopa.it"
