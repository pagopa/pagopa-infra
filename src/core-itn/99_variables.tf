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

#
# location
#
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

### Italy location
variable "location_ita" {
  type        = string
  description = "Main location"
  default     = "italynorth"
}

variable "location_short_ita" {
  type = string
  validation {
    condition = (
      length(var.location_short_ita) == 3
    )
    error_message = "Length must be 3 chars."
  }
  description = "Location short for italy: itn"
  default     = "itn"
}

variable "vnet_ita_ddos_protection_plan" {
  type = object({
    id     = string
    enable = bool
  })
  default = null
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

variable "cidr_vnet_italy" {
  type        = list(string)
  description = "Address prefixes for vnet in italy."
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
#
# #
# # Event hub
# #
# variable "ehns_auto_inflate_enabled" {
#   type        = bool
#   description = "Is Auto Inflate enabled for the EventHub Namespace?"
#   default     = false
# }
#
# variable "ehns_sku_name" {
#   type        = string
#   description = "Defines which tier to use."
#   default     = "Standard"
# }
#
# variable "ehns_capacity" {
#   type        = number
#   description = "Specifies the Capacity / Throughput Units for a Standard SKU namespace."
#   default     = null
# }
#
# variable "ehns_maximum_throughput_units" {
#   type        = number
#   description = "Specifies the maximum number of throughput units when Auto Inflate is Enabled"
#   default     = null
# }
#
# variable "ehns_zone_redundant" {
#   type        = bool
#   description = "Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones)."
#   default     = false
# }
#
# variable "eventhubs_03" {
#   description = "A list of event hubs to add to namespace."
#   type = list(object({
#     name              = string
#     partitions        = number
#     message_retention = number
#     consumers         = list(string)
#     keys = list(object({
#       name   = string
#       listen = bool
#       send   = bool
#       manage = bool
#     }))
#   }))
#   default = []
# }
#
# variable "eventhubs_04" {
#   description = "A list of event hubs to add to namespace."
#   type = list(object({
#     name              = string
#     partitions        = number
#     message_retention = number
#     consumers         = list(string)
#     keys = list(object({
#       name   = string
#       listen = bool
#       send   = bool
#       manage = bool
#     }))
#   }))
#   default = []
# }
#
# variable "ehns_alerts_enabled" {
#   type        = bool
#   default     = false
#   description = "Event hub alerts enabled?"
# }
#
# variable "ehns_public_network_access" {
#   type        = bool
#   description = "(Required) enables public network access to the event hubs"
# }
#
# variable "ehns_metric_alerts" {
#   default = {}
#
#   description = <<EOD
# Map of name = criteria objects
# EOD
#
#   type = map(object({
#     # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]
#     aggregation = string
#     metric_name = string
#     description = string
#     # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]
#     operator  = string
#     threshold = number
#     # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H
#     frequency = string
#     # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.
#     window_size = string
#
#     dimension = list(object(
#       {
#         name     = string
#         operator = string
#         values   = list(string)
#       }
#     ))
#   }))
# }

variable "is_feature_enabled" {
  type = object({
    vnet_ita                  = bool,
    container_app_tools_cae   = optional(bool, false),
    node_forwarder_ha_enabled = bool
    vpn                       = optional(bool, false)
    dns_forwarder_lb          = optional(bool, false)
    postgres_private_dns      = bool
  })
  description = "Features enabled in this domain"
}
