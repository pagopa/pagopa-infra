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

variable "instance" {
  type        = string
  description = "One of beta, prod01, prod02"
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

### Aks

variable "k8s_kube_config_path_prefix" {
  type    = string
  default = "~/.kube"
}

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

variable "tls_cert_check_helm" {
  type = object({
    chart_version = string,
    image_name    = string,
    image_tag     = string
  })
  description = "tls cert helm chart configuration"
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

variable "dns_zone_checkout" {
  type        = string
  default     = null
  description = "The checkout dns subdomain."
}

variable "pod_disruption_budgets" {
  type = map(object({
    name         = optional(string, null)
    minAvailable = optional(number, null)
    matchLabels  = optional(map(any), {})
  }))
  description = "Pod disruption budget for domain namespace"
  default     = {}
}

variable "io_backend_base_path" {
  type        = string
  default     = null
  description = "io backend api base path"
}

variable "ecommerce_io_with_pm_enabled" {
  type        = bool
  default     = false
  description = "ecommerce for IO using Payment Manager enabled"
}

variable "pdv_api_base_path" {
  type        = string
  default     = null
  description = "Personal data vault api base path"
}

variable "enabled_payment_wallet_method_ids_pm" {
  type        = string
  default     = ""
  description = "Comma separated list of eCommerce payment method ids that are enabled with PM APIs"
}

variable "pagopa_vpn" {
  type = object({
    ips = list(string)
  })
  description = "pagoPA on prem VPN"
}

variable "pagopa_vpn_dr" {
  type = object({
    ips = list(string)
  })
  description = "pagoPA on prem VPN DR"
}

variable "ecommerce_payment_requests_api_key_use_primary" {
  type        = bool
  description = "If true the current active API key used for payment requests will be the primary one."
  default     = true
}

variable "ecommerce_payment_methods_api_key_use_primary" {
  type        = bool
  description = "If true the current active API key used for payment methods will be the primary one."
  default     = true
}

variable "ecommerce_notification_service_api_key_use_primary" {
  type        = bool
  description = "If true the current active API key used for notification service will be the primary one."
  default     = true
}

variable "ecommerce_user_stats_service_api_key_use_primary" {
  type        = bool
  description = "Whenever to use primary or secondary key invoking user-stats-service"
  default     = true
}