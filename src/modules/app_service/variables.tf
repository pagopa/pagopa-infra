variable "location" {
  type    = string
  default = "westeurope"
}

variable "prefix" {
  type = string
}

variable "name" {
  type        = string
  description = "Name"
}

variable "always_on" {
  type        = bool
  default     = false
  description = "Should the app be loaded at all times?"

}
variable "linux_fx_version" {
  type        = string
  description = " Linux Framework and version for the Function App."
  default     = null
}
variable "app_command_line" {
  type        = string
  description = "App command line to launch"
  default     = null
}
variable "health_check_path" {
  type        = string
  description = "The health check path to be pinged by App Service."
  default     = null
}

variable "resource_group" {
  type        = string
}

variable "app_settings" {
  type = map(string)
}