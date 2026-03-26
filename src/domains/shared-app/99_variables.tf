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

variable "influxdb_helm" {
  type = object({
    chart_version = string,
    image = object({
      name = string,
      tag  = string
    })
  })
  default = {
    chart_version = "4.12.0",
    image = {
      name = "influxdb",
      tag  = "1.8.10-alpine@sha256:c436689dc135f204734d63b82fd03044fa3a5205127cb2d1fa7398ff224936b1"
    }
  }
  description = "influxdb helm chart configuration"
}

variable "influxdb2_helm" {
  type = object({
    chart_version = string,
    image = object({
      name = string,
      tag  = string
    })
  })
  default = {
    chart_version = "2.1.0",
    image = {
      name = "influxdb",
      tag  = "2.2.0-alpine@sha256:f3b54d91cae591fc3fde20299bd0b262f6f6d9a1f73b98d623b501e82c49d5fb"
    }
  }
  description = "influxdb2 helm chart configuration"
}


variable "cidr_subnet_authorizer_functions" {
  type        = string
  description = "CIDR subnet for Authorizer functions"
}

variable "authorizer_function_always_on" {
  type        = bool
  description = "Should authorizer-functions app be always on?"
}

variable "authorizer_functions_app_sku" {
  type = object({
    kind     = string
    sku_size = string
  })
  description = "Authorizer functions app plan SKU"
}

variable "authorizer_functions_app_image_tag" {
  type        = string
  default     = "latest"
  description = "Authorizer functions app docker image tag. Defaults to 'latest'"
}

variable "authorizer_functions_autoscale" {
  type = object({
    default = number
    minimum = number
    maximum = number
  })
  description = "Authorizer functions autoscaling parameters"
}

# taxonomy
variable "taxonomy_function_subnet" {
  type        = list(string)
  description = "Address prefixes subnet"
  default     = null
}

variable "taxonomy_function_network_policies_enabled" {
  type        = bool
  description = "Network policies enabled"
  default     = false
}

variable "taxonomy_function" {
  type = object({
    always_on                    = bool
    kind                         = string
    sku_size                     = string
    maximum_elastic_worker_count = number
  })
  description = "Taxonomy function"
}

variable "taxonomy_function_app_image_tag" {
  type        = string
  default     = "latest"
  description = "Taxonomy function app docker image tag. Defaults to 'latest'"
}

variable "taxonomy_function_autoscale" {
  type = object({
    default = number
    minimum = number
    maximum = number
  })
  description = "Taxonomy function autoscaling parameters"
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

variable "function_app_storage_account_replication_type" {
  type        = string
  default     = "ZRS"
  description = "(Optional) Storage account replication type used for function apps"
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

variable "pagopa_shared_toolbox_enabled" {
  type        = bool
  description = "pagoPA Shared Toolbox enabled"
  default     = true
}

variable "cname_record_name" {
  type    = string
  default = "shared"
}

variable "cdn_storage_account_replication_type" {
  type        = string
  default     = "GRS"
  description = "(Optional) Cdn storage account replication type"
}

variable "pagopa_shared_toolbox_singlepageapp" {
  type        = list(string)
  description = "Single Page Applications root directories"
  default     = ["ui"]
}

variable "robots_indexed_paths" {
  type        = list(string)
  description = "List of cdn paths to allow robots index"
}

// wallet session token
variable "io_backend_base_path" {
  type        = string
  default     = null
  description = "io backend api base path"
}

variable "pdv_api_base_path" {
  type        = string
  default     = null
  description = "Personal data vault api base path"
}

variable "function_app_ip_restriction_default_action" {
  type        = string
  description = "(Optional) The Default action for traffic that does not match any ip_restriction rule. possible values include Allow and Deny. Defaults to Allow."
  default     = "Allow"
}

variable "gh_runner_job_location" {
  type        = string
  description = "(Optional) The GH runner container app job location. Consistent with the container app environment location"
  default     = "westeurope"
}