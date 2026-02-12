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

#
# location
#
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

### Italy location
variable "location_ita" {
  type        = string
  description = "Main location"
  default     = "italynorth"
}

variable "location_short_ita" {
  type = string
  validation {
    condition = (
      length(var.location_short_ita) == 3
    )
    error_message = "Length must be 3 chars."
  }
  description = "Location short for italy: itn"
  default     = "itn"
}


variable "application_insisght_name" {
  type        = string
  description = "The name of the Application Insights resource for monitoring and alerting"
}

variable "application_insisght_resource_group_name" {
  type        = string
  description = "The name of the resource group where the Application Insights resource is located"
}

###################
### ClouDO Vars ###
###################
variable "cloudo_orchestrator" {
  type = object({
    image_name        = optional(string, "pagopa/cloudo-orchestrator")
    image_tag         = optional(string, "0.0.0")
    registry_url      = optional(string, "https://ghcr.io")
    registry_username = optional(string)
    registry_password = optional(string)
  })
  description = "Configuration for the ClouDO orchestrator container, including container image details and registry authentication."
}

variable "cloudo_ui" {
  type = object({
    image_name        = optional(string, "pagopa/cloudo-ui")
    image_tag         = optional(string, "0.0.0")
    registry_url      = optional(string, "https://ghcr.io")
    registry_username = optional(string)
    registry_password = optional(string)
  })
  description = "Configuration for the ClouDO UI App Service, including container image details and registry authentication."
}

variable "cloudo_worker" {
  type = object({
    image_name        = optional(string, "pagopa/cloudo-worker")
    image_tag         = optional(string, "0.0.0")
    registry_url      = optional(string, "https://ghcr.io")
    registry_username = optional(string)
    registry_password = optional(string)
  })
  description = "Configuration for the ClouDO worker container, including container image details and registry authentication."
}