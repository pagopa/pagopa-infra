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


variable "checkout_enabled" {
  type    = bool
  default = false
}

variable "checkout_apim_frontend_enabled" {
  type        = bool
  default     = false
  description = "Feature flag to enable/disable the APIM frontend proxy for checkout. When 'false', APIM redirects all traffic to checkout CDN."
}


variable "monitor_resource_group_name" {
  type        = string
  description = "Monitor resource group name"
}

# Network

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

# pagopa-proxy

# Checkout APIM

variable "ecommerce_ingress_hostname" {
  type        = string
  description = "ecommerce ingress hostname"
  default     = null
}

variable "checkout_ingress_hostname" {
  type        = string
  description = "checkout ingress hostname"
  default     = null
}

variable "checkout_cdn_storage_replication_type" {
  type        = string
  default     = "GRS"
  description = "(Optional) Checkout cnd storage replication type"
}

variable "tls_cert_check_helm" {
  type = object({
    chart_version = string,
    image_name    = string,
    image_tag     = string
  })
  description = "tls cert helm chart configuration"
}

variable "instance" {
  type        = string
  description = "One of beta, prod01, prod02"
}

variable "k8s_kube_config_path_prefix" {
  type    = string
  default = "~/.kube"
}

variable "dns_default_ttl_sec" {
  type        = number
  description = "The DNS default TTL in seconds"
  default     = 3600
}
