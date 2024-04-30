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

variable "cidr_eventhubs_italy" {
  type        = list(string)
  description = "Address prefixes for all evenhubs in italy."
}

variable "cidr_cosmosdb_italy" {
  type        = list(string)
  description = "Address prefixes for all cosmosdb in italy."
}

variable "cidr_storage_italy" {
  type        = list(string)
  description = "Address prefixes for all storage accounts in italy."
}

variable "cird_redis_italy" {
  type        = list(string)
  description = "Address prefixes for all redis accounts in italy."
}

variable "cird_postgresql_italy" {
  type        = list(string)
  description = "Address prefixes for all postgresql accounts in italy."
}

### External resources

variable "monitor_resource_group_name" {
  type        = string
  description = "Monitor resource group name"
}

# variable "log_analytics_workspace_name" {
#   type        = string
#   description = "Specifies the name of the Log Analytics Workspace."
# }
#
# variable "log_analytics_workspace_resource_group_name" {
#   type        = string
#   description = "The name of the resource group in which the Log Analytics workspace is located in."
# }

# DNS
# variable "external_domain" {
#   type        = string
#   default     = "pagopa.it"
#   description = "Domain for delegation"
# }
#
# variable "dns_zone_internal_prefix" {
#   type        = string
#   default     = null
#   description = "The dns subdomain."
# }

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
}

variable "ehns_capacity" {
  type        = number
  description = "Specifies the Capacity / Throughput Units for a Standard SKU namespace."
}

variable "ehns_maximum_throughput_units" {
  type        = number
  description = "Specifies the maximum number of throughput units when Auto Inflate is Enabled"
}

variable "ehns_zone_redundant" {
  type        = bool
  description = "Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones)."
}

# variable "ehns_alerts_enabled" {
#   type        = bool
#   default     = false
#   description = "Event hub alerts enabled?"
# }

variable "ehns_public_network_access" {
  type        = bool
  description = "(Required) enables public network access to the event hubs"
}

variable "ehns_private_endpoint_is_present" {
  type        = bool
  description = "(Required) create private endpoint to the event hubs"
}

variable "ehns_metric_alerts_create" {
  type        = bool
  description = "Create metrics alerts for eventhub"
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

#
# Container registry
#
variable "container_registry_sku" {
  type        = string
  description = "Sku for ACR"
}

variable "container_registry_zone_redundancy_enabled" {
  type        = bool
  description = "Enabled AZ for container registry"
}

variable "eventhubs_meucci" {
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

# pdf-engine
variable "cidr_subnet_pdf_engine_app_service" {
  type        = list(string)
  description = "CIDR subnet for App Service"
  default     = null
}
