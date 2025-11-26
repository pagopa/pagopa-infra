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

variable "github" {
  type = object({
    org = string
  })
  default = { org = "pagopa" }
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

variable "cname_record_name" {
  type    = string
  default = "config"
}

# reporting
variable "cidr_subnet_reporting_fdr" {
  type        = list(string)
  description = "Address prefixes subnet reporting_fdr function"
  default     = null
}

variable "private_endpoint_network_policies_enabled" {
  type        = bool
  description = "Enables or network policies for private endpoints in Azure."
}

variable "reporting_fdr_function_always_on" {
  type        = bool
  description = "Always on property"
  default     = false
}

variable "reporting_fdr_function_kind" {
  type        = string
  description = "App service plan kind"
  default     = null
}

variable "reporting_fdr_function_sku_tier" {
  type        = string
  description = "App service plan sku tier"
  default     = null
}

variable "reporting_fdr_function_sku_size" {
  type        = string
  description = "App service plan sku size"
  default     = null
}

variable "image_name" {
  type        = string
  default     = null
  description = "The image name to use with a function app"
}

variable "image_tag" {
  type        = string
  default     = null
  description = "The image tag to use with a function app"
}

variable "eventhub_name" {
  type        = string
  default     = null
  description = "EventHub name"
}

variable "event_name" {
  type        = string
  default     = null
  description = "Event name related to an EventHub"
}

variable "fn_app_runtime_version" {
  type        = string
  description = "Function app runtime version."
  default     = "~4"
}

variable "reporting_fdr_function_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "reporting_fdr_function_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 3
}

variable "reporting_fdr_function_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 1
}

# Storage account
variable "storage_account_info" {
  type = object({
    account_kind                      = string
    account_tier                      = string
    account_replication_type          = string
    access_tier                       = string
    advanced_threat_protection_enable = bool
    use_legacy_defender_version       = bool
    public_network_access_enabled     = bool
  })

  default = {
    account_kind                      = "StorageV2"
    account_tier                      = "Standard"
    account_replication_type          = "LRS"
    access_tier                       = "Hot"
    advanced_threat_protection_enable = true
    use_legacy_defender_version       = false
    public_network_access_enabled     = false
  }
}

# Storage account
variable "reporting_fdr_storage_account_info" {
  type = object({
    account_kind                      = string
    account_tier                      = string
    account_replication_type          = string
    access_tier                       = string
    advanced_threat_protection_enable = bool
    use_legacy_defender_version       = bool
    public_network_access_enabled     = bool
  })


  default = {
    account_kind                      = "StorageV2"
    account_tier                      = "Standard"
    account_replication_type          = "LRS"
    access_tier                       = "Hot"
    advanced_threat_protection_enable = true
    use_legacy_defender_version       = false
    public_network_access_enabled     = false
  }
}

# App service plan
variable "app_service_plan_info" {
  type = object({
    kind                         = string # The kind of the App Service Plan to create. Possible values are Windows (also available as App), Linux, elastic (for Premium Consumption) and FunctionApp (for a Consumption Plan).
    sku_size                     = string # Specifies the plan's instance size.
    sku_tier                     = string
    maximum_elastic_worker_count = number # The maximum number of total workers allowed for this ElasticScaleEnabled App Service Plan.
    worker_count                 = number # The number of Workers (instances) to be allocated.
    zone_balancing_enabled       = bool   # Should the Service Plan balance across Availability Zones in the region. Changing this forces a new resource to be created.
  })

  description = "Allows to configurate the internal service plan"

  default = {
    kind                         = "Linux"
    sku_tier                     = "PremiumV3"
    sku_size                     = "P1v3"
    maximum_elastic_worker_count = 0
    worker_count                 = 0
    zone_balancing_enabled       = false
  }
}

# apim
variable "apim_fdr_nodo_pagopa_enable" {
  type        = bool
  default     = false
  description = "Enable Fdr Service Nodo pagoPA side"
}

variable "nodo_pagamenti_subkey_required" {
  type        = bool
  description = "Enabled subkeys for nodo dei pagamenti api"
  default     = false
}


# FdR xml to json
variable "fdr_xml_to_json_function_subnet" {
  type        = list(string)
  description = "Address prefixes subnet"
  default     = null
}

variable "fdr_xml_to_json_function_network_policies_enabled" {
  type        = bool
  description = "Network policies enabled"
  default     = false
}
variable "fdr_xml_to_json_function" {
  type = object({
    always_on                    = bool
    kind                         = string
    sku_size                     = string
    sku_tier                     = string
    maximum_elastic_worker_count = number
  })
  description = "FdR XML to JSON function"
  default = {
    always_on                    = true
    kind                         = "Linux"
    sku_size                     = "B1"
    sku_tier                     = "Basic"
    maximum_elastic_worker_count = 1
  }
}

variable "fdr_xml_to_json_function_app_image_tag" {
  type        = string
  default     = "latest"
  description = "FdR XML to JSON function app docker image tag. Defaults to 'latest'"
}

variable "fdr_xml_to_json_function_autoscale" {
  type = object({
    default = number
    minimum = number
    maximum = number
  })
  description = "FdR function autoscaling parameters"
}


variable "function_app_storage_account_replication_type" {
  type        = string
  default     = "ZRS"
  description = "(Optional) Storage account replication type used for function apps"
}

variable "ftp_organization" {
  type        = string
  description = "Organization configured with FTP"
  default     = null
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

variable "enabled_features" {
  type = object({
  })
  default = {
  }
  description = "Features enabled in this domain"
}

variable "gh_runner_job_location" {
  type        = string
  description = "(Optional) The GH runner container app job location. Consistent with the container app environment location"
  default     = "westeurope"
}

variable "enable_fdr_ci_soap_request" {
  type        = bool
  description = "Switch to pagoPA FdR SOAP request for Orgs"
}

variable "enable_fdr_psp_soap_request" {
  type        = bool
  description = "Switch to pagoPA FdR SOAP request for PSP"
}

variable "fdr_soap_request_psp_whitelist" {
  type = string
  # default     = "*" # No Default to explicits set into ENV settings
  description = "String list comma separated"
}

variable "fdr_soap_request_ci_whitelist" {
  type = string
  # default     = "*" # No Default to explicits set into ENV settings
  description = "String list comma separated"
}
