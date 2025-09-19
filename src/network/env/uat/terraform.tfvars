env_short          = "u"
env                = "uat"
location           = "westeurope"
location_short     = "weu"


nsg_regions = ["westeurope", "italynorth"]

nsg_network_watcher_enabled = false


enabled_features = {
  metabase = false
  data_factory_proxy = true
  vpn_database_access = true
  nsg = true
}
