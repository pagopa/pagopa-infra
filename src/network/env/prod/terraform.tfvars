env_short      = "p"
env            = "prod"
location       = "italynorth"
location_short = "itn"


nsg_regions = ["westeurope", "italynorth"]


enabled_features = {
  nsg_metabase             = true
  data_factory_proxy       = false
  vpn_database_access      = false
  nsg                      = true
  all_vnet_database_access = true
}
