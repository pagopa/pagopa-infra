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

variable "location_string" {
  type        = string
  description = "One of West Europe, North Europe"
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

variable "monitor_resource_group_name" {
  type        = string
  description = "Monitor resource group name"
}

# Network

variable "cidr_subnet_checkout_be" {
  type        = list(string)
  description = "Address prefixes subnet checkout function"
  default     = null
}

# DNS

variable "dns_zone_checkout" {
  type        = string
  default     = null
  description = "The checkout dns subdomain."
}

variable "external_domain" {
  type        = string
  default     = null
  description = "Domain for delegation"
}

variable "dns_zone_prefix" {
  type        = string
  default     = null
  description = "The dns subdomain."
}

variable "apim_dns_zone_prefix" {
  type        = string
  default     = null
  description = "The dns subdomain for apim."
}

# APIM

variable "apim_logger_resource_id" {
  type        = string
  description = "Resource id for the APIM logger"
  default     = null
}

# pagopa-proxy

variable "checkout_pagopaproxy_host" {
  type        = string
  description = "pagopaproxy host"
  default     = null
}

variable "cidr_subnet_pagopa_proxy" {
  type        = list(string)
  description = "Address prefixes subnet proxy"
  default     = null
}

variable "pagopa_proxy_tier" {
  type        = string
  description = "pagopa-proxy Plan tier"
  default     = null
}

variable "pagopa_proxy_size" {
  type        = string
  description = "pagopa-proxy Plan size"
  default     = null
}

variable "pagopa_proxy_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "pagopa_proxy_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 10
}

variable "pagopa_proxy_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 5
}

# Checkout functions

variable "checkout_function_kind" {
  type        = string
  description = "App service plan kind"
  default     = null
}

variable "checkout_function_sku_tier" {
  type        = string
  description = "App service plan sku tier"
  default     = null
}

variable "checkout_function_sku_size" {
  type        = string
  description = "App service plan sku size"
  default     = null
}

variable "checkout_function_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "checkout_function_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 3
}

variable "checkout_function_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 1
}

variable "checkout_function_always_on" {
  type        = bool
  description = "Always on property"
  default     = false
}

# Checkout APIM

variable "ecommerce_ingress_hostname" {
  type        = string
  description = "ecommerce ingress hostname"
  default     = null
}

variable "ecommerce_xpay_psps_list" {
  type        = string
  description = "psps list using xpay as comma separated value"
  default     = ""
}

variable "ecommerce_vpos_psps_list" {
  type        = string
  description = "psps list using vpos as comma separated value"
  default     = ""
}

variable "function_app_storage_account_info" {
  type = object({
    account_kind                      = optional(string, "StorageV2")
    account_tier                      = optional(string, "Standard")
    account_replication_type          = optional(string, "LRS")
    access_tier                       = optional(string, "Hot")
    advanced_threat_protection_enable = optional(bool, true)
  })

  default = {
    account_kind                      = "StorageV2"
    account_tier                      = "Standard"
    account_replication_type          = "LRS"
    access_tier                       = "Hot"
    advanced_threat_protection_enable = true
  }
}

variable "checkout_cdn_storage_replication_type" {
  type        = string
  default     = "GRS"
  description = "(Optional) Checkout cnd storage replication type"
}
