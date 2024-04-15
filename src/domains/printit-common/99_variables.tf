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
    account_kind                                                        = string
    account_tier                                                        = string
    account_replication_type                                            = string
    advanced_threat_protection                                          = bool
    blob_versioning_enabled                                             = bool
    public_network_access_enabled                                       = bool
    blob_delete_retention_days                                          = number
    enable_low_availability_alert                                       = bool
    backup_enabled                                                      = optional(bool, false)
    backup_retention                                                    = optional(number, 0)
    blob_tier_to_cool_after_last_access                                 = number
    blob_tier_to_archive_after_days_since_last_access_time_greater_than = number
    blob_delete_after_last_access                                       = number
  })

  default = {
    account_kind                                                        = "StorageV2"
    account_tier                                                        = "Standard"
    account_replication_type                                            = "LRS"
    blob_versioning_enabled                                             = false
    advanced_threat_protection                                          = false
    public_network_access_enabled                                       = false
    blob_delete_retention_days                                          = 30
    enable_low_availability_alert                                       = false
    backup_enabled                                                      = false
    backup_retention                                                    = 0
    blob_tier_to_cool_after_last_access                                 = 0
    blob_tier_to_archive_after_days_since_last_access_time_greater_than = 3650
    blob_delete_after_last_access                                       = 3650
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
    advanced_threat_protection    = false
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
    advanced_threat_protection    = false
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

# eventhub
variable "eventhub_enabled" {
  type        = bool
  default     = false
  description = "eventhub enable?"
}

variable "cidr_subnet_eventhub" {
  type        = list(string)
  description = "Address prefixes subnet eventhub"
  default     = null
}

variable "ehns_sku_name" {
  type        = string
  description = "Defines which tier to use."
  default     = "Basic"
}

variable "ehns_capacity" {
  type        = number
  description = "Specifies the Capacity / Throughput Units for a Standard SKU namespace."
  default     = null
}

variable "ehns_maximum_throughput_units" {
  type        = number
  description = "Specifies the maximum number of throughput units when Auto Inflate is Enabled"
  default     = null
}

variable "ehns_auto_inflate_enabled" {
  type        = bool
  description = "Is Auto Inflate enabled for the EventHub Namespace?"
  default     = false
}

variable "ehns_zone_redundant" {
  type        = bool
  description = "Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones)."
  default     = false
}

variable "ehns_alerts_enabled" {
  type        = bool
  default     = true
  description = "Event hub alerts enabled?"
}
variable "ehns_metric_alerts" {
  default = {}

  description = <<EOD
Map of name = criteria objects
EOD

  type = map(object({
    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]
    aggregation = string
    metric_name = string
    description = string
    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]
    operator  = string
    threshold = number
    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H
    frequency = string
    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.
    window_size = string

    dimension = list(object(
      {
        name     = string
        operator = string
        values   = list(string)
      }
    ))
  }))
}

variable "eventhubs" {
  description = "A list of event hubs to add to namespace."
  type = list(object({
    name              = string
    partitions        = number
    message_retention = number
    consumers         = list(string)
    keys = list(object({
      name   = string
      listen = bool
      send   = bool
      manage = bool
    }))
  }))
  default = []
}
