prefix         = "pagopa"
env_short      = "p"
env            = "prod"
location       = "westeurope"
location_short = "weu"

storage_account_replication_type = "GZRS"
use_private_endpoint             = true


#
# Feature Flags
#
enabled_resource = {
  container_app_tools_cae = true
}
synthetic_alerts_enabled = true

law_sku               = "CapacityReservation" # TODO verify why it is changed from PerGB2018 to CapacityReservation
law_retention_in_days = 30
law_daily_quota_gb    = -1

#
# monitoring template variables
#
check_position_body = {
  fiscal_code   = "00876220633"
  notice_number = "001000000136265862"
}
verify_payment_internal_expected_outcome = "OK"
nexi_node_ip                             = "10.79.20.34"
nexi_ndp_host                            = "nodo-p.npc.sia.eu"
nexi_ndp_host_2                          = "nodo-dei-pagamenti.npc.sia.eu"
