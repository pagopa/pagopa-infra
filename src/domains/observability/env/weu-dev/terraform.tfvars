prefix         = "pagopa"
env_short      = "d"
env            = "dev"
domain         = "observ"
location       = "westeurope"
location_short = "weu"
instance       = "dev"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/observability"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name = "pagopa-d-monitor-rg"

# Data Explorer
dexp_params = {
  enabled = true
  sku = {
    name     = "Dev(No SLA)_Standard_E2a_v4"
    capacity = 1
  }
  autoscale = {
    enabled       = false
    min_instances = 2
    max_instances = 3
  }
  public_network_access_enabled = true
  double_encryption_enabled     = false
  disk_encryption_enabled       = true
  purge_enabled                 = false
}

dexp_db = {
  enable             = true
  hot_cache_period   = "P5D"
  soft_delete_period = "P30D" // P1M
}

dexp_re_db_linkes_service = {
  enable = true
}

app_forwarder_enabled = true

external_domain      = "pagopa.it"
apim_dns_zone_prefix = "dev.platform"