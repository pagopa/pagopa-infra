env_short      = "d"
env            = "dev"
location       = "italynorth"
location_short = "itn"



external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.dev.platform"

alert_use_opsgenie = false

redis_idh_resource_tier = "basic"

cosmos_idh_resource_tier = "cosmos_mongo6"

cosmos_mongo_db_params = {
  ip_range_filter = []
}

cosmos_mongo_db_pos_gateway_params = {
  enable_autoscaling = true
  max_throughput     = 2000
  throughput         = 2000
}
