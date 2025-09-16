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
    use_legacy_defender_version       = optional(bool, true)
    public_network_access_enabled     = optional(bool, false)
  })

  default = {
    account_kind                      = "StorageV2"
    account_tier                      = "Standard"
    account_replication_type          = "LRS"
    access_tier                       = "Hot"
    advanced_threat_protection_enable = true
    use_legacy_defender_version       = true
    public_network_access_enabled     = false
  }
}

variable "checkout_cdn_storage_replication_type" {
  type        = string
  default     = "GRS"
  description = "(Optional) Checkout cnd storage replication type"
}

variable "checkout_function_zone_balancing_enabled" {
  type        = bool
  description = "(Optional) Enables zone balancing for checkout function"
  default     = true
}

variable "checkout_function_worker_count" {
  type        = number
  description = "(Optional) checkout function worker count number"
  default     = 1
}

variable "checkout_ip_restriction_default_action" {
  type        = string
  description = "(Required) The Default action for traffic that does not match any ip_restriction rule. possible values include Allow and Deny. "
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

variable "checkout_feature_flag_map" {
  type        = string
  description = "Checkout feature flag JSON map"
  default = "{}"
}