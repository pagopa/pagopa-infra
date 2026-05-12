env_short      = "u"
env            = "uat"
location       = "westeurope"
location_short = "weu"


location_hub_spoke       = "italynorth"
location_short_hub_spoke = "itn"

nsg_regions = ["westeurope", "italynorth"]

nsg_network_watcher_enabled = false


enabled_features = {
  nsg_metabase        = false
  data_factory_proxy  = true
  vpn_database_access = true
  nsg                 = true
}

platform_dns_zone_prefix = "uat.platform"
