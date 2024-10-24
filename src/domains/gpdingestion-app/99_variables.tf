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

### Features flags

variable "is_feature_enabled" {
  type = object({
    gpdingestion      = bool
  })
  default = {
    gpdingestion      = false
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

# DNS

variable "dns_zone_prefix" {
  type        = string
  default     = null
  description = "The wallet dns subdomain."
}

### PDB
variable "pod_disruption_budgets" {
  type = map(object({
    name         = optional(string, null)
    minAvailable = optional(number, null)
    matchLabels  = optional(map(any), {})
  }))
  description = "Pod disruption budget for domain namespace"
  default     = {}
}

variable "zookeeper_replicas" {
  type = number
  description = "Zookeeper Replicas"
  default = 1
}

variable "zookeeper_request_memory" {
  type = string
  description = "Zookeeper Request Memory"
  default = "512m"
}

variable "zookeeper_request_cpu" {
  type = string
  description = "Zookeeper Request CPU"
  default = "0.5"
}

variable "zookeeper_limits_memory" {
  type = string
  description = "Zookeeper Limit Memory"
  default = "512mi"
}

variable "zookeeper_limits_cpu" {
  type = string
  description = "Zookeeper Limit CPU"
  default = "0.5"
}

variable "zookeeper_jvm_xms" {
  type = string
  description = "Zookeeper Jvm Xms"
  default = "512mi"
}

variable "zookeeper_jvm_xmx" {
  type = string
  description = "Zookeeper Jvm Xmx"
  default = "512mi"
}

variable "zookeeper_storage_size" {
  type = string
  description = "Zookeeper Storage Size"
  default = "100Gi"
}

variable "container_registry" {
  type = string
  description = "Container Registry"
}

variable "postgres_db_name" {
  type = string
  description = "Postgres Database Name"
  default = "apd"
}

variable "tasks_max" {
  type = string
  description = "Number of tasks"
  default = "1"
}

variable "replicas" {
  type = number
  description = "Number of replicas in cluster"
  default = 1
}

variable "request_memory" {
  type = string
  description = "Connect Request Memory"
  default = "512m"
}

variable "request_cpu" {
  type = string
  description = "Connect Request CPU"
  default = "0.5"
}

variable "limits_memory" {
  type = string
  description = "Connect Limit Memory"
  default = "512mi"
}

variable "limits_cpu" {
  type = string
  description = "Connect Limit CPU"
  default = "0.5"
}
