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

lock_enable = true

terraform_remote_state_core = {
  resource_group_name  = "io-infra-rg"
  storage_account_name = "pagopainfraterraformdev"
  container_name       = "azurermstate"
  key                  = "dev.terraform.tfstate"
}

dns_zone_prefix = "dev.platform.pagopa.it"
external_domain = "pagopa.it"
