env_short      = "p"
env            = "prod"
location       = "italynorth"
location_short = "itn"


nsg_regions = ["westeurope", "italynorth"]


enabled_features = {
  metabase = true
  data_factory_proxy = false
  vpn_database_access = false
  nsg = true
}
