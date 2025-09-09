# general
variable "env_short" {
  type = string
  validation {
    condition = (
      length(var.env_short) == 1
    )
    error_message = "Length must be 1 chars."
  }
}

variable "env" {
  type = string
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

variable "enable_neu_nsg" {
  type = bool
  default = false
  description = "(Optional) Enable NSG in neu vnet"
}


variable "nsg_regions" {
  type = list(string)
  default = ["westeurope"]
  description = "(Optional) Regions where NSG must be created"
}
