prefix          = "pagopa"
env_short       = "p"
env             = "prod"
domain          = "core"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "prod"

tags = {
  CreatedBy   = "Terraform"
  Environment = "PROD"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"

#
# Dns
#
external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.platform"

#
# CIRDs
#
cidr_subnet_dns_forwarder_backup = ["10.1.251.0/29"]

dns_forwarder_backup_is_enabled = {
  prod = true
}
dns_forwarder_vm_image_name = "pagopa-p-dns-forwarder-ubuntu2204-image-v1"
