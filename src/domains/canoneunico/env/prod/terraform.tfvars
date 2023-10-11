# general
env_short = "p"
env       = "prod"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}
# dns/network
external_domain                           = "pagopa.it"
dns_zone_prefix                           = "platform"
cidr_subnet_canoneunico_common            = ["10.1.140.0/24"]
private_endpoint_network_policies_enabled = false
public_network_access_enabled             = true

lock_enable = true

# acr
acr_enabled = true

# docker image
image_name = "canone-unico"
image_tag  = "0.0.14"

# canone unico
canoneunico_plan_sku_tier = "PremiumV3"
canoneunico_plan_sku_size = "P1v3"

canoneunico_function_always_on         = true
canoneunico_function_autoscale_minimum = 1
canoneunico_function_autoscale_maximum = 3
canoneunico_function_autoscale_default = 1

canoneunico_queue_message_delay = 3600 // in seconds = 1h

canoneunico_runtime_version = "~3"

storage_account_info = {
    account_kind                      = "StorageV2"
    account_tier                      = "Standard"
    account_replication_type          = "GZRS"
    access_tier                       = "Hot"
    advanced_threat_protection_enable = true
}


canoneunico_delete_retention_days = 31
canoneunico_backup_retention_days = 30
enable_canoneunico_backup         = true
canoneunico_enable_versioning     = true

# storage
storage_queue_private_endpoint_enabled = true
storage_account_info = {
  account_kind                      = "StorageV2"
  account_tier                      = "Standard"
  account_replication_type          = "LRS"
  access_tier                       = "Hot"
  advanced_threat_protection_enable = true
}
