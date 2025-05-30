variable "location" {
  type        = string
  description = "One of westeurope, northeurope"
  default     = "westeurope"
}

variable "prefix" {
  type    = string
  default = "pagopa"
  validation {
    condition = (
      length(var.prefix) <= 6
    )
    error_message = "Max length is 6 chars."
  }
}

variable "env_short" {
  type = string
}

variable "env" {
  type = string
}


variable "dns_zone_prefix" {
  type        = string
  default     = null
  description = "The dns subdomain."
}

variable "image_name" {
  type        = string
  default     = "pagopa/canone-unico"
  description = "The image name to use with a function app"
}

variable "image_tag" {
  type        = string
  default     = "latest"
  description = "The image tag to use with a function app"
}

variable "private_endpoint_network_policies_enabled" {
  type        = bool
  default     = false
  description = "Enable the private endpoint network policies"
}

variable "public_network_access_enabled" {
  type        = bool
  default     = false
  description = "Enable the public network access"
}

variable "external_domain" {
  type        = string
  default     = null
  description = "Domain for delegation"
}

variable "canoneunico_plan_kind" {
  type        = string
  description = "App service plan kind"
  default     = "Linux"
}

variable "canoneunico_plan_sku_tier" {
  type        = string
  description = "App service plan sku tier"
  default     = null
}

variable "canoneunico_plan_sku_size" {
  type        = string
  description = "App service plan sku size"
  default     = null
}

variable "canoneunico_batch_size_debt_pos_queue" {
  type        = number
  description = "Batch size Debt Position queue"
  default     = 25
}

variable "canoneunico_batch_size_debt_pos_table" {
  type        = number
  description = "Batch size Debt Position table"
  default     = 25
}

variable "cidr_subnet_canoneunico_common" {
  type        = list(string)
  description = "Address prefixes subnet canoneunico_common function"
  default     = null
}
variable "canoneunico_function_always_on" {
  type        = bool
  description = "Always on property"
  default     = false
}

variable "canoneunico_runtime_version" {
  type        = string
  description = "Version for the Azure function runtime"
  default     = "~4"
}

variable "canoneunico_enable_versioning" {
  type        = bool
  description = "Enable sa versioning"
  default     = false
}

variable "canoneunico_advanced_threat_protection" {
  type        = bool
  description = "Enable contract threat advanced protection"
  default     = false
}

variable "canoneunico_delete_retention_days" {
  type        = number
  description = "Number of days to retain deleted."
  default     = 30
}

variable "canoneunico_backup_retention_days" {
  type        = number
  description = "Number of days to retain backup."
  default     = 0
}

variable "canoneunico_schedule_batch" {
  type        = string
  description = "Cron scheduling (NCRON) default : every hour"
  default     = "0 0 */1 * * *"
}

variable "canoneunico_function_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "canoneunico_function_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 3
}

variable "canoneunico_function_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 1
}

variable "canoneunico_queue_message_delay" {
  type        = number
  description = "Queue message delay"
  default     = 120 // in seconds = 2 minutes
}


variable "storage_account_info" {
  type = object({
    account_kind                      = string
    account_tier                      = string
    account_replication_type          = string
    access_tier                       = string
    advanced_threat_protection_enable = bool
  })

  default = {
    account_kind                      = "StorageV2"
    account_tier                      = "Standard"
    account_replication_type          = "LRS"
    access_tier                       = "Hot"
    advanced_threat_protection_enable = true
  }
}



variable "function_storage_account_info" {
  type = object({
    account_kind                      = string
    account_tier                      = string
    account_replication_type          = string
    access_tier                       = string
    advanced_threat_protection_enable = bool
  })

  default = {
    account_kind                      = "StorageV2"
    account_tier                      = "Standard"
    account_replication_type          = "LRS"
    access_tier                       = "Hot"
    advanced_threat_protection_enable = true
  }
}

variable "enable_canoneunico_backup" {
  type        = bool
  default     = false
  description = "(Optional) Enables canoneunico storage account backup"
}

variable "corporate_cup_users" {
  description = "List of corporate CUP user."
  type = list(object({
    username = string
  }))
  default = []
}

### External resources

variable "monitor_resource_group_name" {
  type        = string
  description = "Monitor resource group name"
}
