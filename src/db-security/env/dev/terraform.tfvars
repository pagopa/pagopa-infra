prefix         = "pagopa"
env_short      = "d"
env            = "dev"
location       = "italynorth"
location_short = "itn"

metabase_pgflex_params = {
  idh_tier = "pgflex2" # https://github.com/pagopa/terraform-azurerm-v4/blob/44df8cdf0615a2d1c39efd05996edc4bf28e0dec/IDH/postgres_flexible_server/LIBRARY.md
  db_version   = "16"
  zone                                   = 1
  backup_retention_days                  = 7
  geo_redundant_backup_enabled           = false
  standby_availability_zone              = 2
  pgres_flex_diagnostic_settings_enabled = false
  public_network_access_enabled          = true
  alerts_enabled                         = false
  pgres_flex_ha_enabled                  = false
  pgres_flex_private_endpoint_enabled    = false
  private_dns_registration_enabled       = false
  storage_mb                             = 32768
}
