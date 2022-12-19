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

variable "elastic_node_pool" {
  type = object({
    enabled               = bool,
    name                  = string,
    vm_size               = string,
    os_disk_type          = string,
    os_disk_size_gb       = string,
    node_count_min        = number,
    node_count_max        = number,
    node_labels           = map(any),
    node_taints           = list(string),
    node_tags             = map(any),
    elastic_pool_max_pods = number,
  })
  description = "AKS node pool user configuration"
}

variable "elastic_hot_storage" {
  type = object({
    storage_type           = string,
    allow_volume_expansion = bool,
    initialStorageSize     = string
  })
}
variable "elastic_warm_storage" {
  type = object({
    storage_type           = string,
    allow_volume_expansion = bool,
    initialStorageSize     = string
  })
}
variable "elastic_cold_storage" {
  type = object({
    storage_type           = string,
    allow_volume_expansion = bool,
    initialStorageSize     = string
  })
}

variable "elastic_cluster_config" {
  type = object({
    num_node_balancer     = string
    num_node_master       = string
    num_node_hot          = string
    num_node_warm         = string
    num_node_cold         = string
    storage_size_balancer = string
    storage_size_master   = string
    storage_size_hot      = string
    storage_size_warm     = string
    storage_size_cold     = string
  })
}

variable "enable_iac_pipeline" {
  type        = bool
  description = "If true create the key vault policy to allow used by azure devops iac pipelines."
  default     = false
}
variable "ingress_load_balancer_ip" {
  type = string
}