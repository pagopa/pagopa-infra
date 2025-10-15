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



variable "databases" {
  type = map(object({
    type = string
    host = string
    port = optional(string, null)
    schema_name = string
    username = string
    password_required = bool
    password_secret_key = optional(stirng, null)
  }))

  description = "Map of database name and connection properties to be added to metabase"

  validation {
    condition = alltrue([for db in var.databases: contains([keys(local.database_properties), db.type])])
    error_message = "Allowed database type are: ${join(",", keys(local.database_properties))}"
  }

  validation {
    condition = alltrue([for db in var.databases: (db.password_required ? db.password_secret_key != null :  true )])
    error_message = "Field password_Secret_key must be defined when password_required is true"
  }
}
