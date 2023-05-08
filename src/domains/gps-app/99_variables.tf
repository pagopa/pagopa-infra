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

variable "reporting_function" {
  type        = bool
  description = "Enable reporting_function"
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

variable "cidr_subnet_reporting_functions" {
  type        = list(string)
  description = "Address prefixes subnet reporting_common function"
  default     = null
}
# Network
variable "ddos_protection_plan" {
  type = object({
    id     = string
    enable = bool
  })
  default = null
}

# Reporting

variable "gpd_reporting_schedule_batch" {
  type        = string
  description = "Cron scheduling (NCRON example '*/45 * * * * *')"
  default     = "0 0 1 * * *"
}

variable "gpd_max_retry_queuing" {
  type        = number
  description = "Max retry queuing when the node calling fails."
  default     = 5
}

variable "gpd_queue_retention_sec" {
  type        = number
  description = "The maximum time to allow the message to be in the queue."
  default     = 86400
}

variable "gpd_queue_delay_sec" {
  type        = number
  description = "The length of time during which the message will be invisible, starting when it is added to the queue."
  default     = 3600
}

variable "gpd_paa_id_intermediario" {
  type        = string
  description = "PagoPA Broker ID"
  default     = false
}

variable "gpd_paa_stazione_int" {
  type        = string
  description = "PagoPA Station ID"
  default     = false
}

variable "cname_record_name" {
  type = string
}

variable "reporting_batch_function_always_on" {
  type        = bool
  description = "Always on property"
  default     = false
}

variable "reporting_service_function_always_on" {
  type        = bool
  description = "Always on property"
  default     = false
}

variable "reporting_analysis_function_always_on" {
  type        = bool
  description = "Always on property"
  default     = false
}

variable "reporting_functions_app_sku" {
  type = object({
    kind     = string
    sku_tier = string
    sku_size = string
  })
  description = "Reporting functions app plan SKU"
}

variable "reporting_function_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "reporting_function_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 10
}

variable "reporting_function_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 5
}
