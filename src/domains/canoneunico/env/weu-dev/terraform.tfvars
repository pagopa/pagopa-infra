# general
env_short = "d"
env       = "dev"


# dns/network
external_domain                           = "pagopa.it"
dns_zone_prefix                           = "dev.platform"
cidr_subnet_canoneunico_common            = ["10.1.140.0/24"]
private_endpoint_network_policies_enabled = false
public_network_access_enabled             = true
lock_enable                               = false

# acr
acr_enabled = true

# docker image
image_name = "canone-unico"
image_tag  = "latest"

# canone unico
canoneunico_plan_sku_tier = "Standard"
canoneunico_plan_sku_size = "S1"

# each 15 minutes
canoneunico_schedule_batch = "0 */15 * * * *"

canoneunico_function_autoscale_minimum = 1
canoneunico_function_autoscale_maximum = 3
canoneunico_function_autoscale_default = 1

# storage
storage_queue_private_endpoint_enabled = true
storage_account_info = {
  account_kind                      = "StorageV2"
  account_tier                      = "Standard"
  account_replication_type          = "LRS"
  access_tier                       = "Hot"
  advanced_threat_protection_enable = false
}


corporate_cup_users = [
  {
    username : "testcorporate01"
  },
  {
    username : "testcorporate02"
  },
]

### External resources
monitor_resource_group_name = "pagopa-d-monitor-rg"
