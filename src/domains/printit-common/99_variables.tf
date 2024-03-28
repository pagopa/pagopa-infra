# general

variable "prefix" {
  type = string
  validation {
    condition = (
      length(var.prefix) <= 6
    )
    error_message = "Max length is 6 chars."
  }
}

variable "env" {
  type = string
}

variable "env_short" {
  type = string
  validation {
    condition = (
      length(var.env_short) == 1
    )
    error_message = "Length must be 1 chars."
  }
}

variable "domain" {
  type = string
  validation {
    condition = (
      length(var.domain) <= 12
    )
    error_message = "Max length is 12 chars."
  }
}

variable "location" {
  type        = string
  description = "One of westeurope, northeurope"
}

variable "location_short" {
  type = string
  validation {
    condition = (
      length(var.location_short) == 3
    )
    error_message = "Length must be 3 chars."
  }
  description = "One of wue, neu"
}

variable "instance" {
  type        = string
  description = "One of beta, prod01, prod02"
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}

### External resources

variable "monitor_resource_group_name" {
  type        = string
  description = "Monitor resource group name"
}

variable "log_analytics_workspace_name" {
  type        = string
  description = "Specifies the name of the Log Analytics Workspace."
}

variable "log_analytics_workspace_resource_group_name" {
  type        = string
  description = "The name of the resource group in which the Log Analytics workspace is located in."
}

# DNS

variable "dns_zone_prefix" {
  type        = string
  default     = null
  description = "The wallet dns subdomain."
}

variable "external_domain" {
  type        = string
  default     = null
  description = "Domain for delegation"
}

variable "dns_zone_platform" {
  type        = string
  default     = null
  description = "The platform dns subdomain."
}

variable "dns_zone_internal_prefix" {
  type        = string
  default     = null
  description = "The dns subdomain."
}

variable "ingress_load_balancer_ip" {
  type = string
}

# CosmosDB
variable "cidr_subnet_cosmosdb_printit" {
  type        = list(string)
  description = "Cosmos DB address space for printit."
}

variable "cosmos_mongo_db_notices_params" {
  type = object({
    enabled        = bool
    capabilities   = list(string)
    offer_type     = string
    server_version = string
    kind           = string
    consistency_policy = object({
      consistency_level       = string
      max_interval_in_seconds = number
      max_staleness_prefix    = number
    })
    main_geo_location_zone_redundant = bool
    enable_free_tier                 = bool
    additional_geo_locations = list(object({
      location          = string
      failover_priority = number
      zone_redundant    = bool
    }))
    private_endpoint_enabled          = bool
    public_network_access_enabled     = bool
    is_virtual_network_filter_enabled = bool
    backup_continuous_enabled         = bool
    enable_serverless                 = bool
    enable_autoscaling                = bool
    throughput                        = number
    max_throughput                    = number
    container_default_ttl             = number
  })
}

variable "notices_storage_account" {
  type = object({
    account_kind                  = string
    account_tier                  = string
    account_replication_type      = string
    advanced_threat_protection    = bool
    blob_versioning_enabled       = bool
    public_network_access_enabled = bool
    blob_delete_retention_days    = number
    enable_low_availability_alert = bool
    backup_enabled                = optional(bool, false)
    backup_retention              = optional(number, 0)
  })

  default = {
    account_kind                  = "StorageV2"
    account_tier                  = "Standard"
    account_replication_type      = "LRS"
    blob_versioning_enabled       = false
    advanced_threat_protection    = true
    public_network_access_enabled = false
    blob_delete_retention_days    = 30
    enable_low_availability_alert = false
    backup_enabled                = false
    backup_retention              = 0
  }
}

variable "templates_storage_account" {
  type = object({
    account_kind                  = string
    account_tier                  = string
    account_replication_type      = string
    advanced_threat_protection    = bool
    blob_versioning_enabled       = bool
    public_network_access_enabled = bool
    blob_delete_retention_days    = number
    enable_low_availability_alert = bool
    backup_enabled                = optional(bool, false)
    backup_retention              = optional(number, 0)
  })

  default = {
    account_kind                  = "StorageV2"
    account_tier                  = "Standard"
    account_replication_type      = "LRS"
    blob_versioning_enabled       = false
    advanced_threat_protection    = true
    public_network_access_enabled = false
    blob_delete_retention_days    = 30
    enable_low_availability_alert = false
    backup_enabled                = false
    backup_retention              = 0
  }
}

variable "institutions_storage_account" {
  type = object({
    account_kind                  = string
    account_tier                  = string
    account_replication_type      = string
    advanced_threat_protection    = bool
    blob_versioning_enabled       = bool
    public_network_access_enabled = bool
    blob_delete_retention_days    = number
    enable_low_availability_alert = bool
    backup_enabled                = optional(bool, false)
    backup_retention              = optional(number, 0)
  })

  default = {
    account_kind                  = "StorageV2"
    account_tier                  = "Standard"
    account_replication_type      = "LRS"
    blob_versioning_enabled       = false
    advanced_threat_protection    = true
    public_network_access_enabled = false
    blob_delete_retention_days    = 30
    enable_low_availability_alert = false
    backup_enabled                = false
    backup_retention              = 0
  }
}

# Storage account
variable "cidr_subnet_storage_account" {
  type        = list(string)
  description = "Storage account network address space."
}

