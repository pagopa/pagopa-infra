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

dns_forwarder_backup_is_enabled = true
dns_forwarder_vm_image_name     = "pagopa-p-dns-forwarder-ubuntu2204-image-v1"


#
# replica settings
#
geo_replica_enabled        = true
geo_replica_location       = "northeurope"
geo_replica_location_short = "neu"
geo_replica_cidr_vnet      = ["10.2.0.0/16"]
geo_replica_ddos_protection_plan = {
  id     = "/subscriptions/0da48c97-355f-4050-a520-f11a18b8be90/resourceGroups/sec-p-ddos/providers/Microsoft.Network/ddosProtectionPlans/sec-p-ddos-protection"
  enable = true
}

postgres_private_dns_enabled = true


enable_logos_backup                              = true
logos_backup_retention                           = 30
logos_donations_storage_account_replication_type = "GZRS"
