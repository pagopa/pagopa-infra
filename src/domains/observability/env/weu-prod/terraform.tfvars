prefix         = "pagopa"
env_short      = "p"
env            = "prod"
domain         = "observ"
location       = "westeurope"
location_short = "weu"
instance       = "prod"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/observability"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name = "pagopa-p-monitor-rg"


# Data Explorer
dexp_params = {
  enabled = true
  sku = {
    name     = "Standard_D11_v2"
    capacity = 2
  }
  autoscale = {
    enabled       = true
    min_instances = 2
    max_instances = 5
  }
  public_network_access_enabled = true
  double_encryption_enabled     = true
  disk_encryption_enabled       = true
  purge_enabled                 = false
}

dexp_db = {
  enable             = true
  hot_cache_period   = "P5D"
  soft_delete_period = "P365D" // "P1Y"
}

dexp_re_db_linkes_service = {
  enable = true
}

external_domain      = "NOT_USED"
apim_dns_zone_prefix = "NOT_USED"