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
variable "location_itn" {
  type        = string
  description = "italynorth"
}

variable "location_short_itn" {
  type = string
  validation {
    condition = (
      length(var.location_short_itn) == 3
    )
    error_message = "Length must be 3 chars."
  }
  description = "itn"
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


# Data Explorer

variable "dexp_params" {
  type = object({
    enabled = bool
    sku = object({
      name     = string
      capacity = number
    })
    autoscale = object({
      enabled       = bool
      min_instances = number
      max_instances = number
    })
    public_network_access_enabled = bool
    double_encryption_enabled     = bool
    disk_encryption_enabled       = bool
    purge_enabled                 = bool
  })
}

variable "dexp_db" {
  type = object({
    enable             = bool
    hot_cache_period   = string
    soft_delete_period = string
  })
}

variable "dexp_pm_db" {
  type = object({
    enable             = bool
    hot_cache_period   = string
    soft_delete_period = string
  })
  default = {
    enable             = false
    hot_cache_period   = "P5D"
    soft_delete_period = "P365D" // "P1Y"
  }
}

variable "dexp_re_db_linkes_service" {
  type = object({
    enable = bool
  })
}

variable "app_forwarder_enabled" {
  type        = bool
  description = "Enable app_forwarder"
  default     = false
}

variable "external_domain" {
  type        = string
  default     = null
  description = "Domain for delegation"
}

variable "apim_dns_zone_prefix" {
  type        = string
  default     = null
  description = "The dns subdomain for apim."
}

// observability
variable "observability_storage_account_replication_type" {
  type        = string
  default     = "LRS"
  description = "(Optional) observability datastore storage account replication type"
}

variable "enable_sa_backup" {
  type        = bool
  description = "(Optional) enables storage account point in time recovery"
  default     = false
}

variable "observability_sa_advanced_threat_protection" {
  type        = bool
  description = "Enable contract threat advanced protection"
  default     = false
}

variable "observability_sa_delete_retention_days" {
  type        = number
  description = "Number of days to retain deleted."
  default     = 0
}

variable "observability_sa_backup_retention_days" {
  type        = number
  description = "Number of days to retain backups."
  default     = 0
}

variable "observability_sa_tier_to_cool_after_last_access" {
  type        = number
  description = "Number of days since last access to blob before moving to cool tier"
  default     = 183
}

variable "observability_tier_to_archive_after_days_since_last_access_time_greater_than" {
  type        = number
  description = "Number of days since last access to blob before moving to archive tier"
  default     = 730
}

variable "observability_sa_delete_after_last_access" {
  type        = number
  description = "Number of days since modification to blob before deleting"
  default     = 3650
}

variable "cidr_subnet_observability_storage" {
  type        = list(string)
  description = "Storage address space"
  default     = null
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

variable "ehns_metric_alerts_gpd" {
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

# ################################
# INGESTION
# ################################

# evh subnet + topics GEC & WALLET
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

variable "cidr_subnet_observability_evh" {
  type        = list(string)
  description = "Address prefixes evh"
}

# evh subnet + topics GPD & Debezium

variable "eventhubs_gpd" {
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

variable "cidr_subnet_observability_gpd_evh" {
  type        = list(string)
  description = "Address prefixes evh"
}

# GPD ingestion sa

variable "gpd_ingestion_storage_account" {
  type = object({
    advanced_threat_protection    = bool
    blob_delete_retention_days    = number
    blob_versioning_enabled       = bool
    backup_enabled                = bool
    backup_retention              = optional(number, 0)
    account_replication_type      = string
    public_network_access_enabled = bool

  })
  default = {
    blob_versioning_enabled       = false
    advanced_threat_protection    = false
    blob_delete_retention_days    = 30
    backup_enabled                = false
    backup_retention              = 0
    account_replication_type      = "LRS" // changhe to GZRS for PROD
    public_network_access_enabled = true
  }
}

variable "is_feature_enabled" {
  type = object({

  })

  default = {
  }

}
