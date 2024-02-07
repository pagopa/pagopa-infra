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


variable "env_short" {
  type = string
  validation {
    condition = (
      length(var.env_short) == 1
    )
    error_message = "Length must be 1 chars."
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



variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}
#
# Feature flags
#
variable "enabled_resource" {
  type = object({
    container_app_tools_cae = optional(bool, false),
  })
}

variable "storage_account_replication_type" {
  type        = string
  description = "(Required) table storage replication type"
}

variable "use_private_endpoint" {
  type        = bool
  description = "(Required) if true enables the usage of private endpoint"
}



