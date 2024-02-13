prefix         = "pagopa"
env_short      = "p"
env            = "prod"
location       = "westeurope"
location_short = "weu"

storage_account_replication_type = "GZRS"
use_private_endpoint             = true

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/elk-monitoring"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

#
# Feature Flags
#
enabled_resource = {
  container_app_tools_cae = true
}


law_sku               = "CapacityReservation" # TODO verify why it is changed from PerGB2018 to CapacityReservation
law_retention_in_days = 30
law_daily_quota_gb    = -1
