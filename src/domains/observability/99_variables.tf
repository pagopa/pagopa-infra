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


# Data Explorer

variable "dexp_params" {
  type = object({
    enabled = bool
    sku = object({
      name     = string
      capacity = number
    })
    autoscale = object({
      enabled       = bool
      min_instances = number
      max_instances = number
    })
    public_network_access_enabled = bool
    double_encryption_enabled     = bool
    disk_encryption_enabled       = bool
    purge_enabled                 = bool
  })
}

variable "dexp_db" {
  type = object({
    enable             = bool
    hot_cache_period   = string
    soft_delete_period = string
  })
}

variable "dexp_re_db_linkes_service" {
  type = object({
    enable = bool
  })
}

variable "app_forwarder_enabled" {
  type        = bool
  description = "Enable app_forwarder"
  default     = false
}