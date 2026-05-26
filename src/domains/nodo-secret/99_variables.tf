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
  description = "One of weu, neu"
}


variable "k8s_kube_config_path_prefix" {
  type    = string
  default = "~/.kube"
}

### External resources

variable "input_file" {
  type        = string
  description = "secret json file"
}

variable "enable_iac_pipeline" {
  type        = bool
  description = "If true create the key vault policy to allow used by azure devops iac pipelines."
  default     = false
}


variable "az_nodo_sa_share_name_firmatore" {
  type        = string
  description = "Azure storage account share name"
}
variable "upload_firmatore" {
  type = map(string)
}

variable "cacerts_path" {
  type        = string
  description = "Java cacerts"
}

variable "certs_storage_account_replication_type" {
  type        = string
  default     = "LRS"
  description = "(Optional) Certificates storage account replication type"
}

variable "nodo_cert_storage_account" {
  type = object({
    advanced_threat_protection    = bool
    blob_delete_retention_days    = number
    blob_versioning_enabled       = bool
    public_network_access_enabled = bool
    backup_enabled                = bool
    backup_retention              = optional(number, 0)
  })
  default = {
    blob_versioning_enabled       = false
    advanced_threat_protection    = false
    blob_delete_retention_days    = 30
    public_network_access_enabled = false
    backup_enabled                = false
    backup_retention              = 0
  }
}
