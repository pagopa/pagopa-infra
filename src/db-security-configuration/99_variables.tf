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

variable "databases" {
  type = map(object({
    type = string
    host = string
    port = optional(string, null)
    db_name = optional(string, null)
    username = string
    password_required = bool
    password_secret_kv_name = optional(string, null)
    password_secret_kv_rg = optional(string, null)
    password_secret_key = optional(string, null)
    catalog = optional(string, null)
    schema = optional(string, null)
    user_control_scheduling = optional(bool, null)
    advanced_options = optional(bool, null)
  }))

  description = "Map of database name and connection properties to be added to metabase"

  validation {
    condition = alltrue([for db in var.databases: contains(keys(local.database_properties), db.type)])
    error_message = "Allowed database type are: ${join(",", keys(local.database_properties))}"
  }

  validation {
    condition = alltrue([for db in var.databases: (db.password_required ? db.password_secret_key != null :  true )])
    error_message = "Field password_secret_key must be defined when password_required is true"
  }

  validation {
    condition = alltrue([for db in var.databases: (db.password_required ? db.password_secret_kv_name != null :  true )])
    error_message = "Field password_secret_kv_name must be defined when password_required is true"
  }

   validation {
    condition = alltrue([for db in var.databases: (db.password_required ? db.password_secret_kv_rg != null :  true )])
    error_message = "Field password_secret_kv_rg must be defined when password_required is true"
  }

  validation {
    condition = alltrue([ for db in var.databases : (db.type == "mongodb" ? db.catalog != null : true )])
    error_message = "Field catalog must be defined when type is mongodb"
  }

  validation {
    condition = alltrue([ for db in var.databases : (db.type == "postgresql" ? db.db_name != null : true )])
    error_message = "Field db_name must be defined when type is postgresql"
  }
}
