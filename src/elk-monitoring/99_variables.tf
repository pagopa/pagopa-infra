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

variable "enable_iac_pipeline" {
  type        = bool
  description = "If true create the key vault policy to allow used by azure devops iac pipelines."
  default     = false
}
variable "ingress_load_balancer_ip" {
  type = string
}

variable "subscription_name" {
  type        = string
  description = "Subscription name"
}

variable "nginx_helm" {
  type = object({
    version = string,
    controller = object({
      image = object({
        registry     = string,
        image        = string,
        tag          = string,
        digest       = string,
        digestchroot = string,
      }),
      config = object({
        proxy-body-size : string
      })
    })
  })
  description = "nginx ingress helm chart configuration"
}

variable "ingress_elk_load_balancer_ip" {
  type = string
}

variable "ingress_min_replica_count" {
  type = string
}

variable "ingress_max_replica_count" {
  type = string
}

variable "nodeset_config" {
  type = map(object({
    count            = string
    roles            = list(string)
    storage          = string
    storageClassName = string
  }))
  default = {
    default = {
      count            = 1
      roles            = ["master", "data", "data_content", "data_hot", "data_warm", "data_cold", "data_frozen", "ingest", "ml", "remote_cluster_client", "transform"]
      storage          = "5Gi"
      storageClassName = "standard"
    }
  }
}

variable "opentelemetry_operator_helm" {
  type = object({
    chart_version = string,
    values_file   = string
  })
  description = "open-telemetry/opentelemetry-operator helm chart configuration"
}

variable "elk_snapshot_sa" {
  type = object({
    blob_delete_retention_days = number
    backup_enabled             = bool
    blob_versioning_enabled    = bool
    advanced_threat_protection = bool
  })
  default = {
    blob_delete_retention_days = 0
    backup_enabled             = false
    blob_versioning_enabled    = true
    advanced_threat_protection = true
  }
}
