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
variable "mock_ec_enabled" {
  type        = bool
  description = "Mock EC enabled"
  default     = false
}

variable "mock_ec_secondary_enabled" {
  type        = bool
  description = "Mock Secondary EC enabled"
  default     = false
}

variable "cidr_subnet_mock_ec" {
  type        = list(string)
  description = "Address prefixes subnet mock ec"
  default     = null
}

variable "mock_ec_always_on" {
  type        = bool
  description = "Mock EC always on property"
  default     = false
}

variable "mock_ec_tier" {
  type        = string
  description = "Mock EC Plan tier"
  default     = "Standard"
}

variable "mock_ec_size" {
  type        = string
  description = "Mock EC Plan size"
  default     = "S1"
}

variable "mock_payment_gateway_enabled" {
  type        = bool
  description = "Mock payment gateway enabled"
  default     = false
}

variable "mock_payment_gateway_always_on" {
  type        = bool
  description = "Mock payment gateway always on property"
  default     = false
}

variable "mock_payment_gateway_tier" {
  type        = string
  description = "Mock payment gateway Plan tier"
  default     = "Standard"
}

variable "mock_payment_gateway_size" {
  type        = string
  description = "Mock payment gateway Plan size"
  default     = "S1"
}

variable "cidr_subnet_mock_payment_gateway" {
  type        = list(string)
  description = "Address prefixes subnet mock payment_gateway"
  default     = null
}

variable "external_domain" {
  type        = string
  default     = null
  description = "Domain for delegation"
}

variable "dns_zone_internal_prefix" {
  type        = string
  default     = null
  description = "The dns internal subdomain."
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

variable "tls_cert_check_helm" {
  type = object({
    chart_version = string,
    image_name    = string,
    image_tag     = string
  })
  description = "tls cert helm chart configuration"
}

# Network
variable "ddos_protection_plan" {
  type = object({
    id     = string
    enable = bool
  })
  default = null
}

# mock_psp_service NEXI
variable "mock_psp_service_enabled" {
  type        = bool
  description = "Mock PSP service Nexi"
  default     = false
}
variable "mock_psp_secondary_service_enabled" {
  type        = bool
  description = "Mock Secondary PSP service Nexi"
  default     = false
}

variable "lb_aks" {
  type        = string
  description = "IP load balancer AKS Nexi/SIA"
  default     = "0.0.0.0"
}


variable "mock_enabled" {
  type        = bool
  description = "mock enabled on this environment"
  default     = false
}
