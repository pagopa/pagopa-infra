prefix         = "pagopa"
env_short      = "p"
env            = "prod"
location       = "italynorth"
location_short = "itn"


metabase_pgflex_params = {
  idh_tier                               = "pgflex2" # https://github.com/pagopa/terraform-azurerm-v4/blob/44df8cdf0615a2d1c39efd05996edc4bf28e0dec/IDH/postgres_flexible_server/LIBRARY.md
  db_version                             = "16"
  pgres_flex_diagnostic_settings_enabled = false
  alerts_enabled                         = true
  private_dns_registration_enabled       = false
  storage_mb                             = 32768
}


metabase_plan_idh_tier = "premium_low_load"

enabled_features = {
  db_vdi = true
}

db_vdi_settings = {
  location              = "westeurope"
  location_short        = "weu"
  size                  = "Standard_B4ms"
  auto_shutdown_enabled = true
  auto_shutdown_time    = "1900"
  session_limit         = 1
  host_pool_type        = "Pooled"
}

route_table_routes = [{
  name                   = "dbsecurity-subnet-to-nexi-postgres-onprem-subnet"
  address_prefix         = "10.102.1.93/32"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.230.10.150"
}]