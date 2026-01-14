### Features flags

variable "is_feature_enabled" {
  type = object({
    cosmosdb_notice      = bool
    storage_institutions = bool
    storage_notice       = bool
    storage_templates    = bool
    eventhub             = bool
    cosmos_hub_spoke_pe_dns = optional(bool, false),
  })
  default = {
    cosmosdb_notice      = false
    storage_institutions = false
    storage_notice       = false
    storage_templates    = false
    eventhub             = false
    cosmos_hub_spoke_pe_dns = false
  }
}

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
  default     = "itn"
}

variable "instance" {
  type        = string
  description = "One of beta, prod01, prod02"
}


#
# CIRDs
#

variable "cidr_printit_cosmosdb_italy" {
  type        = list(string)
  description = "Address prefixes for all cosmosdb in italy."
}

variable "cidr_printit_storage_italy" {
  type        = list(string)
  description = "Address prefixes for all storage accounts in italy."
}

variable "cidr_printit_redis_italy" {
  type        = list(string)
  description = "Address prefixes for all redis accounts in italy."
}
variable "cidr_printit_pdf_engine_italy" {
  type        = list(string)
  description = "Address prefixes for all pdf engine accounts in italy."
}

variable "cidr_printit_eventhub_italy" {
  type        = list(string)
  description = "Address prefixes for all evh accounts in italy."
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

variable "monitor_italy_resource_group_name" {
  type        = string
  description = "Monitor Italy resource group name"
}

variable "log_analytics_italy_workspace_name" {
  type        = string
  description = "Specifies the name of the Log Analytics Workspace Italy."
}

variable "log_analytics_italy_workspace_resource_group_name" {
  type        = string
  description = "The name of the resource group in which the Log Analytics workspace Italy is located in."
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
variable "cosmos_mongo_db_notices_params" {
  type = object({
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

#
# Storage account
#
variable "notices_storage_account" {
  type = object({
    account_kind                        = string
    account_tier                        = string
    account_replication_type            = string
    advanced_threat_protection          = bool
    blob_versioning_enabled             = bool
    public_network_access_enabled       = bool
    blob_delete_retention_days          = number
    enable_low_availability_alert       = bool
    backup_enabled                      = optional(bool, false)
    backup_retention                    = optional(number, 0)
    blob_tier_to_cool_after_last_access = number
    #     blob_tier_to_archive_after_days_since_last_access_time_greater_than = number
    blob_delete_after_last_access = number
  })

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

}

#
# Eventhub
#

variable "ehns_public_network_access" {
  type        = bool
  description = "(Required) enables public network access to the event hubs"
}

variable "ehns_private_endpoint_is_present" {
  type        = bool
  description = "(Required) create private endpoint to the event hubs"
}

variable "ehns_sku_name" {
  type        = string
  description = "Defines which tier to use."
}

variable "ehns_capacity" {
  type        = number
  description = "Specifies the Capacity / Throughput Units for a Standard SKU namespace."
}

variable "ehns_maximum_throughput_units" {
  type        = number
  description = "Specifies the maximum number of throughput units when Auto Inflate is Enabled"
}

variable "ehns_auto_inflate_enabled" {
  type        = bool
  description = "Is Auto Inflate enabled for the EventHub Namespace?"
}

variable "ehns_zone_redundant" {
  type        = bool
  description = "Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones)."
}

variable "ehns_alerts_enabled" {
  type        = bool
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
