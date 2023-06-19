prefix         = "pagopa"
env_short      = "u"
env            = "uat"
domain         = "mock"
location       = "westeurope"
location_short = "weu"
instance       = "uat"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/src/domains/mock-common"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name = "pagopa-u-monitor-rg"


cidr_subnet_mock_ec              = ["10.1.137.0/29"]
cidr_subnet_mock_payment_gateway = ["10.1.137.8/29"]

mock_ec_enabled              = true
mock_ec_secondary_enabled    = true
mock_payment_gateway_enabled = true
mock_ec_always_on            = true

external_domain = "pagopa.it"
dns_zone_prefix = "dev.platform"