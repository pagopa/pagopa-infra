prefix         = "pagopa"
env_short      = "d"
env            = "dev"
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


metabase_plan_idh_tier = "basic_high_performance"
