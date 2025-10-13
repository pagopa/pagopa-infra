env_short      = "p"
env            = "prod"
location       = "westeurope"
location_short = "weu"


nsg_regions = ["westeurope", "italynorth"]


enabled_features = {
  nsg_metabase             = false
  data_factory_proxy       = true
  vpn_database_access      = false
  nsg                      = false
  all_vnet_database_access = true
}
