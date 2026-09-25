prefix    = "pagopa"
env       = "prod"
env_short = "p"
domain    = "gps"

location_short = "weu"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-gpd-payments"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

apim_dns_zone_prefix = "platform"
external_domain      = "pagopa.it"
hostname             = "weuprod.gps.internal.platform.pagopa.it"