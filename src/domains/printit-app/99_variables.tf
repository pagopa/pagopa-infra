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

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}

### External resources

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

variable "monitor_italy_resource_group_name" {
  type        = string
  description = "Monitor Italy resource group name"
}

variable "log_analytics_italy_workspace_name" {
  type        = string
  description = "Specifies the name of the Log Analytics Workspace Italy."
}

variable "log_analytics_italy_workspace_resource_group_name" {
  type        = string
  description = "The name of the resource group in which the Log Analytics workspace Italy is located in."
}


### Aks
variable "ingress_load_balancer_ip" {
  type = string
}

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

variable "payment_wallet_with_pm_enabled" {
  type        = bool
  default     = false
  description = "payment wallet using Payment Manager"
}

variable "pdv_api_base_path" {
  type        = string
  default     = null
  description = "Personal data vault api base path"
}

variable "io_backend_base_path" {
  type        = string
  default     = null
  description = "io backend api base path"
}

# DNS

variable "dns_zone_prefix" {
  type        = string
  default     = null
  description = "The wallet dns subdomain."
}

variable "payment_wallet_migrations_enabled" {
  type        = bool
  default     = false
  description = "Payment wallet migrations enabled"
}


# pdf-engine
variable "cidr_subnet_pdf_engine_app_service" {
  type        = list(string)
  description = "CIDR subnet for App Service"
  default     = null
}

variable "app_service_pdf_engine_autoscale_enabled" {
  type    = bool
  default = true
}

variable "app_service_pdf_engine_always_on" {
  type        = bool
  description = "Always on property"
  default     = true
}

variable "app_service_pdf_engine_sku_name" {
  type        = string
  description = "app service plan size"
  default     = "S1"
}
variable "app_service_pdf_engine_sku_name_java" {
  type        = string
  description = "app service plan size"
  default     = "S1"
}

### Features flags

variable "is_feature_enabled" {
  type = object({
    pdf_engine = bool
    printit    = bool
  })
  default = {
    pdf_engine = false
    printit    = false
  }
}
