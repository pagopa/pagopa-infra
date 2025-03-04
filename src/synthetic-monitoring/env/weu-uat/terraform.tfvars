prefix         = "pagopa"
env_short      = "u"
env            = "uat"
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

#
# monitoring template variables
#
check_position_body = {
  fiscal_code   = "15376371009"
  notice_number = "351173232582781477"
}
verify_payment_internal_expected_outcome = "KO"
nexi_node_ip                             = "10.70.74.200"
nexi_ndp_host                            = "nodo-p-uat.tst-npc.sia.eu"
