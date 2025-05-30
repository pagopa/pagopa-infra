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


# api_config_fe
variable "api_config_fe_enabled" {
  type        = bool
  description = "Api Config FE enabled"
  default     = true
}


# api_config

variable "cidr_subnet_api_config" {
  type        = list(string)
  description = "Address prefixes subnet api config"
  default     = null
}

variable "api_config_always_on" {
  type        = bool
  description = "Api Config always on property"
  default     = true
}

variable "db_port" {
  type        = number
  description = "Port number of the DB"
  default     = 1521
}

variable "db_service_name" {
  type        = string
  description = "Service Name of DB"
  default     = null
}

variable "apiconfig_logging_level" {
  type        = string
  description = "Logging level of Api Config"
  default     = "INFO"
}

variable "xsd_ica" {
  type        = string
  description = "XML Schema of Informatica Conto Accredito"
  default     = "https://raw.githubusercontent.com/pagopa/pagopa-api/SANP3.2.0/xsd/InformativaContoAccredito_1_2_1.xsd"
}

variable "xsd_counterpart" {
  type        = string
  description = "XML Schema of Tabelle delle Controparti"
  default     = "https://raw.githubusercontent.com/pagopa/pagopa-api/SANP3.2.0/xsd/TabellaDelleControparti_1_0_8.xsd"
}

variable "xsd_cdi" {
  type        = string
  description = "XML Schema of Catalogo Dati Informativi"
  default     = "https://raw.githubusercontent.com/pagopa/pagopa-api/SANP3.2.0/xsd/CatalogoDatiInformativiPSP.xsd"
}

# DNS
variable "dns_default_ttl_sec" {
  type        = number
  description = "value"
  default     = 3600
}

variable "private_dns_zone_db_nodo_pagamenti" {
  type = string
}

variable "sku_name" {
  type    = string
  default = "S1"
}

variable "ica_cron_job_enable" {
  type        = bool
  description = "ICA cron job enable"
  default     = false
}

variable "ica_cron_schedule" {
  type        = string
  description = "ICA cron scheduling (NCRON example '*/35 * * * * *')"
  default     = "0 0 0 * * *"
}

variable "cdn_storage_account_replication_type" {
  type        = string
  default     = "GRS"
  description = "(Optional) Cdn storage account replication type"
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

variable "gh_runner_job_location" {
  type        = string
  description = "(Optional) The GH runner container app job location. Consistent with the container app environment location"
  default     = "westeurope"
}
