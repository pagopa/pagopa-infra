prefix         = "pagopa"
env_short      = "d"
env            = "dev"
location       = "westeurope"
location_short = "weu"


storage_account_replication_type = "LRS"
use_private_endpoint             = false

#
# Feature Flags
#
enabled_resource = {
  test_nexi_postgres = false
}


# monitoring
law_sku               = "PerGB2018"
law_retention_in_days = 30
law_daily_quota_gb    = 10
self_alert_enabled    = false

force = "v1"

#
# monitoring template variables
#
check_position_body = {
  fiscal_code   = "66666666666"
  notice_number = "310115803416020234"
}
verify_payment_internal_expected_outcome = "KO"
nexi_node_ip                             = "10.79.20.63"
nexi_node_ip_postgres                    = "10.79.20.63"
nexi_ndp_host                            = "sit.nexi.ndp.pagopa.it"
nexi_ndp_host_postgres                   = "sit.nexi.ndp.pagopa.it"
