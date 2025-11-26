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

variable "application_insights_name" {
  type        = string
  description = "Specifies the name of the Application Insights."
}

variable "ingress_load_balancer_ip" {
  type = string
}

variable "external_domain" {
  type        = string
  default     = null
  description = "Domain for delegation"
}

variable "dns_zone_internal_prefix" {
  type        = string
  default     = null
  description = "The dns subdomain."
}

variable "receipts_datastore_cosmos_db_params" {
  type = object({
    kind           = string
    capabilities   = list(string)
    offer_type     = string
    server_version = string
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
    container_default_ttl             = number
    max_throughput                    = number
    max_throughput_alt                = number
  })
}

variable "cidr_subnet_receipts_datastore_cosmosdb" {
  type        = list(string)
  description = "Cosmos DB address space"
  default     = null
}

variable "cidr_subnet_receipts_datastore_storage" {
  type        = list(string)
  description = "Storage address space"
  default     = null
}


variable "receipts_datastore_fn_sa_enable_versioning" {
  type        = bool
  description = "Enable sa versioning"
  default     = false
}

variable "receipts_datastore_fn_sa_advanced_threat_protection" {
  type        = bool
  description = "Enable contract threat advanced protection"
  default     = false
}

variable "receipts_datastore_fn_sa_delete_retention_days" {
  type        = number
  description = "Number of days to retain deleted."
  default     = 0
}

variable "receipts_datastore_fn_sa_backup_retention_days" {
  type        = number
  description = "Number of days to retain backups."
  default     = 0
}

variable "receipts_datastore_fn_sa_tier_to_cool_after_last_access" {
  type        = number
  description = "Number of days since last access to blob before moving to cool tier"
  default     = 183
}

variable "receipts_tier_to_archive_after_days_since_last_access_time_greater_than" {
  type        = number
  description = "Number of days since last access to blob before moving to archive tier"
  default     = 730
}

variable "receipts_datastore_fn_sa_delete_after_last_access" {
  type        = number
  description = "Number of days since modification to blob before deleting"
  default     = 3650
}

variable "receipts_datastore_queue_fn_sa_advanced_threat_protection" {
  type        = bool
  description = "Enable contract threat advanced protection"
  default     = false
}

variable "receipts_datastore_queue_fn_sa_delete_retention_days" {
  type        = number
  description = "Number of days to retain deleted."
  default     = 30
}

variable "enable_iac_pipeline" {
  type        = bool
  description = "If true create the key vault policy to allow used by azure devops iac pipelines."
  default     = false
}

variable "receipts_max_retry_queuing" {
  type        = number
  description = "Max retry queuing when the node calling fails."
  default     = 5
}

variable "receipts_queue_retention_sec" {
  type        = number
  description = "The maximum time to allow the message to be in the queue."
  default     = 86400
}

variable "receipts_queue_delay_sec" {
  type        = number
  description = "The length of time during which the message will be invisible, starting when it is added to the queue."
  default     = 3600
}


variable "receipts_storage_account_replication_type" {
  type        = string
  default     = "LRS"
  description = "(Optional) Receipts datastore storage account replication type"
}


variable "enable_sa_backup" {
  type        = bool
  default     = false
  description = "(Optional) Enables storage account backup PIT restore"
}
