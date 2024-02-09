prefix         = "pagopa"
env_short      = "u"
location       = "westeurope"
location_short = "weu"

storage_account_replication_type = "ZRS"
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

# monitoring
law_sku               = "PerGB2018"
law_retention_in_days = 30
law_daily_quota_gb    = 10
