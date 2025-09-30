env_short      = "d"
env            = "dev"
location       = "westeurope"
location_short = "weu"


nsg_regions = ["westeurope", "italynorth"]


enabled_features = {
  nsg_metabase        = true
  data_factory_proxy  = false
  vpn_database_access = true
  nsg                 = false
}

