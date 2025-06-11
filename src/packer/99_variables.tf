# general

locals {
  product                       = "${var.prefix}-${var.env_short}"
  vnet_core_name                = "${local.product}-vnet"
  vnet_core_resource_group_name = "${local.product}-vnet-rg"
}

variable "prefix" {
  type    = string
  default = "dvopla"
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
    error_message = "Max length is 3 chars."
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
  type    = string
  default = "westeurope"
}

variable "location_short" {
  type        = string
  description = "Location short like eg: neu, weu.."
}


variable "dns_forwarder_backup_image_version" {
  type        = string
  description = "Version string to allow to force the creation of the image"
}

variable "azdo_agent_image_version" {
  type        = string
  description = "Version string to allow to force the creation of the image"
}

