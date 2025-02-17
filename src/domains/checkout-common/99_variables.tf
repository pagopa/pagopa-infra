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

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}

variable "checkout_enabled" {
  type    = bool
  default = false
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

# DNS

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

variable "apim_dns_zone_prefix" {
  type        = string
  default     = null
  description = "The dns subdomain for apim."
}

variable "dns_zone_checkout" {
  type        = string
  default     = null
  description = "The checkout dns subdomain."
}

variable "dns_default_ttl_sec" {
  type        = number
  description = "value"
  default     = 3600
}


# pagopa-proxy Redis

variable "cidr_subnet_pagopa_proxy_redis" {
  type        = list(string)
  description = "Address prefixes subnet redis for pagopa proxy"
  default     = null
}

variable "pagopa_proxy_redis_capacity" {
  type    = number
  default = 1
}


variable "pagopa_proxy_redis_sku_name" {
  type    = string
  default = null
}




variable "pagopa_proxy_redis_family" {
  type    = string
  default = "C"
}

variable "redis_private_endpoint_enabled" {
  type        = bool
  description = "Enable private endpoints for redis instances?"
  default     = true
}


variable "redis_zones" {
  type        = list(number)
  description = "(Required) redis deployment zones"
}

variable "redis_version" {
  type        = string
  default     = "6"
  description = "(Optional) redis version"
}

variable "enable_iac_pipeline" {
  type        = bool
  description = "If true create the key vault policy to allow used by azure devops iac pipelines."
  default     = false
}

