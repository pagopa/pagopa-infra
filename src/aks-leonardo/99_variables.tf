variable "prefix" {
  type    = string
  default = "pagopa"
  validation {
    condition = (
      length(var.prefix) <= 6
    )
    error_message = "Max length is 6 chars."
  }
}

variable "env" {
  type = string
  validation {
    condition = (
      length(var.env) <= 4
    )
    error_message = "Max length is 4 chars."
  }
}

variable "env_short" {
  type = string
  validation {
    condition = (
      length(var.env_short) <= 1
    )
    error_message = "Max length is 1 chars."
  }
}

variable "location" {
  type        = string
  description = "Location name complete"
}

variable "location_short" {
  type        = string
  description = "Location short like eg: itn, weu.."
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

#
# Network
#
variable "cidr_subnet_system_aks" {
  type        = list(string)
  description = "Subnet for system nodepool."
}

variable "cidr_subnet_user_aks" {
  type        = list(string)
  description = "Subnet for generic user nodepool."
}



variable "aks_private_cluster_enabled" {
  type        = bool
  description = "Enable or not public visibility of AKS"
  default     = false
}

variable "aks_kubernetes_version" {
  type        = string
  description = "Kubernetes version of cluster aks"
}

variable "aks_sku_tier" {
  type        = string
  description = "The SKU Tier that should be used for this Kubernetes Cluster."
  default     = "Free"
}

variable "aks_alerts_enabled" {
  type        = bool
  default     = true
  description = "Aks alert enabled?"
}

variable "aks_system_node_pool" {
  type = object({
    name                         = string,
    vm_size                      = string,
    os_disk_type                 = string,
    os_disk_size_gb              = string,
    node_count_min               = number,
    node_count_max               = number,
    node_labels                  = map(any),
    node_tags                    = map(any),
    only_critical_addons_enabled = optional(bool, true)
    zones                        = optional(list(any), [1, 2, 3])
  })
  description = "AKS node pool system configuration"
}

variable "aks_user_node_pool" {
  type = object({
    enabled                    = optional(bool, true),
    name                       = string,
    vm_size                    = string,
    os_disk_type               = string,
    os_disk_size_gb            = string,
    node_count_min             = number,
    node_count_max             = number,
    node_labels                = map(any),
    node_taints                = list(string),
    node_tags                  = map(any),
    ultra_ssd_enabled          = optional(bool, false),
    enable_host_encryption     = optional(bool, true),
    max_pods                   = optional(number, 250),
    upgrade_settings_max_surge = optional(string, "30%"),
    zones                      = optional(list(any), [1, 2, 3]),
  })
  description = "AKS node pool user configuration"
}

#
# Kubernetes Cluster Configurations
#
variable "k8s_kube_config_path_prefix" {
  type    = string
  default = "~/.kube"
}

variable "ingress_replica_count" {
  type = string
}

variable "ingress_load_balancer_ip" {
  type = string
}

variable "nginx_helm_version" {
  type        = string
  description = "NGINX helm verison"
}

variable "keda_helm_version" {
  type = string
}

### Monitor

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

variable "monitor_appinsights_italy_name" {
  type        = string
  description = "App insight in Italy name"
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

variable "monitor_appinsights_name" {
  type        = string
  description = "App insight in europe name"
}

variable "aks_enable_workload_identity" {
  type    = bool
  default = false
}

variable "enable_elastic_agent" {
  type    = bool
  default = true
}
