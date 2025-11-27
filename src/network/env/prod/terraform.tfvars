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

trino_xmx = "8G"
vmss_size = "Standard_D4ds_v5"

external_database_connection = {
  nexi = {
    connector_name       = "postgresql"
    url                  = "jdbc:postgresql://10.102.1.93:6432/ndpspcp_ro?ssl=false"
    user_secret_name     = "nexi-db-user"
    password_secret_name = "nexi-db-password"
    params = {
      case-insensitive-name-matching = true
      unsupported-type-handling      = "CONVERT_TO_VARCHAR"
    }
  }
  nexi_re = {
    connector_name       = "postgresql"
    url                  = "jdbc:postgresql://10.102.1.93:6433/ndparehp_ro?ssl=false"
    user_secret_name     = "nexi-db-user"
    password_secret_name = "nexi-db-password"
    params = {
      case-insensitive-name-matching = true
      unsupported-type-handling      = "CONVERT_TO_VARCHAR"
    }
  }
}
