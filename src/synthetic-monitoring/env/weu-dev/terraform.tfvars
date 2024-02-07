prefix         = "pagopa"
env_short      = "d"
location       = "westeurope"
location_short = "weu"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/elk-monitoring"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

storage_account_replication_type = "LRS"
use_private_endpoint             = false

#
# Feature Flags
#
enabled_resource = {
  container_app_tools_cae = true
}
