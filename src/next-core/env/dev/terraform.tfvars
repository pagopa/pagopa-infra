prefix          = "pagopa"
env_short       = "d"
env             = "dev"
domain          = "core"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "dev"

tags = {
  CreatedBy   = "Terraform"
  Environment = "DEV"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### Network
cidr_subnet_tools_cae  = ["10.1.252.0/23"]

### External resources

monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"

#
# Dns
#
external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.dev.platform"

#
# CIRDs
#

dns_forwarder_backup_is_enabled = false

#
# replica settings
#
geo_replica_enabled          = false
postgres_private_dns_enabled = false

#
# Feature Flags
#
is_resource = {
  container_app_tools_cae = true
}
