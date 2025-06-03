variable "is_feature_enabled" {
  type = object({
    container_app_tools_cae = optional(bool, false),
  })
  description = "Features enabled in this domain"
}

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

### Network

variable "cidr_vnet_italy" {
  type        = list(string)
  description = "Address prefixes for vnet in italy."
}

variable "cidr_eventhubs_italy" {
  type        = list(string)
  description = "Address prefixes for all evenhubs in italy."
}

variable "cidr_subnet_tools_cae" {
  type        = list(string)
  description = "Address prefixes for container apps Tools in italy."
}

variable "cidr_common_private_endpoint_snet" {
  type        = list(string)
  description = "Common Private Endpoint network address space."
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

variable "law_sku" {
  type        = string
  description = "Sku of the Log Analytics Workspace"
}

variable "law_retention_in_days" {
  type        = number
  description = "The workspace data retention in days"
}

variable "law_daily_quota_gb" {
  type        = number
  description = "The workspace daily quota for ingestion in GB."
}

variable "law_internet_query_enabled" {
  type        = bool
  description = "Should the Log Analytics Workspace support querying over the Public Internet? Defaults to true."
}

# DNS
variable "external_domain" {
  type        = string
  default     = "pagopa.it"
  description = "Domain for delegation"
}

variable "dns_zone_internal_prefix" {
  type        = string
  description = "The dns subdomain."
}

variable "platform_dns_zone_prefix" {
  type        = string
  description = "platform dns prefix"
}

variable "dns_default_ttl_sec" {
  type        = number
  description = "Dns default ttl secs"
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

# pdf-engine
variable "cidr_subnet_pdf_engine_app_service" {
  type        = list(string)
  description = "CIDR subnet for App Service"
  default     = null
}
