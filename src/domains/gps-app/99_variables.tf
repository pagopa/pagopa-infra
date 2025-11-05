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


### External resources

variable "monitor_resource_group_name" {
  type        = string
  description = "Monitor resource group name"
  default     = "pagopa-p-monitor-rg"
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

variable "gpd_cache_path" {
  type        = string
  description = "Api-Config cache path"
  default     = "/cache?keys=creditorInstitutionStations,stations"
}

variable "enable_client_retry" {
  type        = bool
  description = "Enable client retry"
  default     = false
}

variable "initial_interval_millis" {
  type        = number
  description = "The initial interval in milliseconds"
  default     = 500
}

variable "max_elapsed_time_millis" {
  type        = number
  description = "The maximum elapsed time in milliseconds"
  default     = 1000
}

variable "max_interval_millis" {
  type        = number
  description = "The maximum interval in milliseconds"
  default     = 1000
}

variable "multiplier" {
  type        = number
  description = "Multiplier for the client backoff procedure"
  default     = 1.5
}

variable "randomization_factor" {
  type        = number
  description = "Randomization factor for the backoff procedure"
  default     = 0.5
}

variable "cname_record_name" {
  type = string
}


variable "reporting_analysis_function_always_on" {
  type        = bool
  description = "Always on property"
  default     = false
}

variable "reporting_analysis_image" {
  type        = string
  description = "reporting_analysis_function docker image"
  default     = ""
}

variable "reporting_analysis_function_client_certificate_mode" {
  type        = string
  description = "client_certificate_mode property"
  default     = "Required"
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

# Function app Framework choice
variable "reporting_analysis_dotnet_version" {
  type    = string
  default = null
}

## GPD-core variables ##
variable "gpd_plan_kind" {
  type        = string
  description = "App service plan kind"
  default     = null
}

variable "gpd_plan_sku_tier" {
  type        = string
  description = "App service plan sku tier"
  default     = null
}

variable "gpd_plan_sku_size" {
  type        = string
  description = "App service plan sku size"
  default     = null
}

variable "gpd_always_on" {
  type        = bool
  description = "Always on property"
  default     = true
}

variable "cidr_subnet_gpd" {
  type        = list(string)
  description = "Address prefixes subnet gpd service"
  default     = null
}

variable "gpd_cron_job_enable" {
  type        = bool
  description = "GPD cron job enable"
  default     = false
}

variable "gpd_cron_schedule_valid_to" {
  type        = string
  description = "GPD cron scheduling (NCRON example '*/35 * * * * *')"
  default     = null
}

variable "gpd_cron_schedule_expired_to" {
  type        = string
  description = "GDP cron scheduling (NCRON example '*/55 * * * * *')"
  default     = null
}

variable "gpd_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "gpd_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 3
}

variable "gpd_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 1
}

// gpd Database
variable "gpd_db_name" {
  type        = string
  description = "Name of the DB to connect to"
  default     = "apd"
}

variable "gpd_dbms_port" {
  type        = number
  description = "Port number of the DBMS"
  default     = 5432
}

variable "pgbouncer_enabled" {
  type        = bool
  description = "Built-in connection pooling solution"
  default     = false
}

#APIM

variable "apim_logger_resource_id" {
  type        = string
  description = "Resource id for the APIM logger"
  default     = null
}


variable "fn_app_storage_account_info" {
  type = object({
    account_kind                      = optional(string, "StorageV2")
    account_tier                      = optional(string, "Standard")
    account_replication_type          = optional(string, "LRS")
    advanced_threat_protection_enable = optional(bool, true)
    access_tier                       = optional(string, "Hot")
    public_network_access_enabled     = optional(bool, false)
    use_legacy_defender_version       = optional(bool, false)
  })

  default = {
    account_kind                      = "StorageV2"
    account_tier                      = "Standard"
    account_replication_type          = "LRS"
    access_tier                       = "Hot"
    advanced_threat_protection_enable = true
    public_network_access_enabled     = false
    use_legacy_defender_version       = true
  }
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

variable "create_wisp_converter" {
  type        = bool
  default     = false
  description = "CREATE WISP dismantling system infra"
}


variable "flag_responsetime_alert" {
  type        = number
  description = "Flag to enable if payments-pull response time alert is available"
  default     = 0
}

### debezium kafka conn

variable "zookeeper_replicas" {
  type        = number
  description = "Zookeeper Replicas"
  default     = 1
}

variable "zookeeper_request_memory" {
  type        = string
  description = "Zookeeper Request Memory"
  default     = "512m"
}

variable "zookeeper_request_cpu" {
  type        = string
  description = "Zookeeper Request CPU"
  default     = "0.5"
}

variable "zookeeper_limits_memory" {
  type        = string
  description = "Zookeeper Limit Memory"
  default     = "512mi"
}

variable "zookeeper_limits_cpu" {
  type        = string
  description = "Zookeeper Limit CPU"
  default     = "0.5"
}

variable "zookeeper_jvm_xms" {
  type        = string
  description = "Zookeeper Jvm Xms"
  default     = "512mi"
}

variable "zookeeper_jvm_xmx" {
  type        = string
  description = "Zookeeper Jvm Xmx"
  default     = "512mi"
}

variable "zookeeper_storage_size" {
  type        = string
  description = "Zookeeper Storage Size"
  default     = "100Gi"
}

variable "container_registry" {
  type        = string
  description = "Container Registry"
}

variable "postgres_db_name" {
  type        = string
  description = "Postgres Database Name"
  default     = "apd"
}

variable "tasks_max" {
  type        = string
  description = "Number of tasks"
  default     = "1"
}

variable "replicas" {
  type        = number
  description = "Number of replicas in cluster"
  default     = 1
}

variable "request_memory" {
  type        = string
  description = "Connect Request Memory"
  default     = "512m"
}

variable "request_cpu" {
  type        = string
  description = "Connect Request CPU"
  default     = "0.5"
}

variable "limits_memory" {
  type        = string
  description = "Connect Limit Memory"
  default     = "512mi"
}

variable "limits_cpu" {
  type        = string
  description = "Connect Limit CPU"
  default     = "0.5"
}

variable "max_threads" {
  type        = number
  description = "Number of max_threads"
  default     = 1
}

variable "gh_runner_job_location" {
  type        = string
  description = "(Optional) The GH runner container app job location. Consistent with the container app environment location"
  default     = "westeurope"
}

variable "gpd_cdc_enabled" {
  type        = bool
  description = "Enable CDC for GDP"
  default     = false
}
