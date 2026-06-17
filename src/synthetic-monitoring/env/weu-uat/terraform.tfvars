prefix         = "pagopa"
env_short      = "u"
env            = "uat"
location       = "westeurope"
location_short = "weu"

storage_account_replication_type = "ZRS"
use_private_endpoint             = true


#
# Feature Flags
#
enabled_resource = {
  test_nexi_postgres  = true,
  cloudo_ndp_switch   = true
  synthetic_on_demand = true
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
nexi_node_ip_postgres                    = "10.79.20.63"
nexi_ndp_host_postgres                   = "test.nexi.ndp.pagopa.it"
nexi_ndphost_header                      = "nodo-p-uat.nexigroup.com"
