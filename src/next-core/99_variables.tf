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

variable "cidr_subnet_tools_cae" {
  type        = list(string)
  description = "Tool container app env, network address space."
}

variable "instance" {
  type        = string
  description = "One of beta, prod01, prod02"
}

variable "lock_enable" {
  type        = bool
  default     = false
  description = "Apply locks to block accedentaly deletions."
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}
### Network

variable "cidr_subnet_dns_forwarder_backup" {
  type        = list(string)
  description = "Address prefixes subnet dns forwarder backup."
  default     = null
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
variable "external_domain" {
  type        = string
  default     = "pagopa.it"
  description = "Domain for delegation"
}

variable "dns_zone_internal_prefix" {
  type        = string
  default     = null
  description = "The dns subdomain."
}

#
# dns forwarder
#
variable "dns_forwarder_backup_is_enabled" {
  type        = bool
  description = "Allow to enable or disable dns forwarder backup"
}

variable "dns_forwarder_vm_image_name" {
  type        = string
  description = "Image name for dns forwarder"
  default     = null
}


#
# replica variables
#
variable "geo_replica_enabled" {
  type        = bool
  description = "(Optional) True if geo replica should be active for key data components i.e. PostgreSQL Flexible servers"
  default     = false
}

variable "geo_replica_location" {
  type        = string
  description = "(Optional) Location of the geo replica"
  default     = "northeurope"
}

variable "geo_replica_location_short" {
  type        = string
  description = "(Optional) Short Location of the geo replica"
  default     = "neu"
}

variable "geo_replica_cidr_vnet" {
  type        = list(string)
  description = "(Required) Cidr block for replica vnet address space"
  default     = null
}

variable "geo_replica_ddos_protection_plan" {
  type = object({
    id     = string
    enable = bool
  })
  default = null
}

variable "postgres_private_dns_enabled" {
  type        = bool
  description = "(Optional) If true creates a private dns that can be used to access the postgres databases"
  default     = false
}


variable "logos_donations_storage_account_replication_type" {
  type        = string
  default     = "LRS"
  description = "(Optional) Logos donations storage account replication type"
}

variable "enable_logos_backup" {
  type        = bool
  default     = true
  description = "(Optional) Enables nodo sftp storage account backup"
}

variable "logos_backup_retention" {
  type        = number
  default     = 7
  description = "(Optional) Blob backup retention"
}

#
# Feature flags
#
variable "enabled_resource" {
  type = object({
    container_app_tools_cae = optional(bool, false),
  })
}


variable "cidr_subnet_apim" {
  type = list(string)
  description = "(Required) APIM v2 subnet cidr"
}

variable "apim_v2_zones" {
  type = list(string)
  description = "(Optional) Zones in which the apim will be deployed"
  default = ["1"]
}

variable "apim_v2_subnet_nsg_security_rules" {
  type        = list(any)
  description = "Network security rules for APIM subnet"
}

variable "apim_v2_publisher_name" {
  type = string
}

variable "apim_v2_sku" {
  type = string
}

variable "redis_cache_enabled" {
  type        = bool
  description = "redis cache enabled"
  default     = false
}

variable "dns_zone_prefix" {
  type        = string
  default     = null
  description = "The dns subdomain."
}

variable "dns_zone_prefix_prf" {
  type        = string
  default     = "" # null
  description = "The dns subdomain."
}

variable "apim_v2_autoscale" {
  type = object(
    {
      enabled                       = bool
      default_instances             = number
      minimum_instances             = number
      maximum_instances             = number
      scale_out_capacity_percentage = number
      scale_out_time_window         = string
      scale_out_value               = string
      scale_out_cooldown            = string
      scale_in_capacity_percentage  = number
      scale_in_time_window          = string
      scale_in_value                = string
      scale_in_cooldown             = string
    }
  )
  default = {
    enabled                       = false
    default_instances             = 1
    minimum_instances             = 1
    maximum_instances             = 5
    scale_out_capacity_percentage = 60
    scale_out_time_window         = "PT10M"
    scale_out_value               = "2"
    scale_out_cooldown            = "PT45M"
    scale_in_capacity_percentage  = 30
    scale_in_time_window          = "PT30M"
    scale_in_value                = "1"
    scale_in_cooldown             = "PT30M"
  }
  description = "Configure Apim autoscale on capacity metric"
}

variable "apim_v2_alerts_enabled" {
  type        = bool
  description = "Enable alerts"
  default     = true
}

#
# Event hub
#
variable "ehns_auto_inflate_enabled" {
  type        = bool
  description = "Is Auto Inflate enabled for the EventHub Namespace?"
  default     = false
}

variable "ehns_sku_name" {
  type        = string
  description = "Defines which tier to use."
  default     = "Standard"
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

variable "ehns_zone_redundant" {
  type        = bool
  description = "Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones)."
  default     = false
}

variable "eventhubs_03" {
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

variable "eventhubs_04" {
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

variable "ehns_alerts_enabled" {
  type        = bool
  default     = false
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

