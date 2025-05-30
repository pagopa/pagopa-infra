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



variable "nodo_switcher" {
  type = object({
    pagopa_nodo_url                  = string
    trigger_max_age_minutes          = number
    enable_switch_approval           = bool
    force_execution_for_old_triggers = bool
    apim_variables = list(object({
      name  = string
      value = string
    }))
  })
  default = {
    pagopa_nodo_url                  = "https://httpbin.org/status/200"
    trigger_max_age_minutes          = 30
    enable_switch_approval           = true
    force_execution_for_old_triggers = false
    apim_variables = [
      {
        name  = "apim_enable_nm3_decoupler_switch"
        value = "false"
      },
      {
        name  = "apim_enable_routing_decoupler_switch"
        value = "false"
      },
      {
        name  = "default_node_id"
        value = "NDP003PROD"
      },
      {
        name  = "default-nodo-backend"
        value = "https://10.79.20.34"
      }
    ]
  }
}


