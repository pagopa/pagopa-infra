prefix          = "pagopa"
env_short       = "u"
env             = "uat"
domain          = "core"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "uat"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "pagopa-u-monitor-rg"
log_analytics_workspace_name                = "pagopa-u-law"
log_analytics_workspace_resource_group_name = "pagopa-u-monitor-rg"

#
# Dns
#
external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.uat.platform"

#
# CIRDs
#
cidr_subnet_dns_forwarder_backup = ["10.1.251.0/29"]
cidr_subnet_tools_cae = ["10.1.248.0/23"]


dns_forwarder_backup_is_enabled = true

dns_forwarder_vm_image_name = "pagopa-u-dns-forwarder-ubuntu2204-image-v4"



#
# replica settings
#
geo_replica_enabled          = false
postgres_private_dns_enabled = true

#
# Feature Flags
#
enabled_resource = {
  container_app_tools_cae = true
}
