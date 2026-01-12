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

variable "location_hub_spoke" {
  type        = string
  description = "One of westeurope, northeurope"
}

variable "location_short_hub_spoke" {
  type = string
  validation {
    condition = (
      length(var.location_short_hub_spoke) == 3
    )
    error_message = "Length must be 3 chars."
  }
  description = "One of wue, neu"
}


variable "nsg_regions" {
  type        = list(string)
  default     = ["westeurope"]
  description = "(Optional) Regions where NSG must be created"
}

variable "nsg_network_watcher_enabled" {
  type        = bool
  description = "(Optional) Enable Network Watcher for all NSG (subnet associated to nsg)"
  default     = false
}

variable "enabled_features" {
  type = object({
    nsg_metabase             = optional(bool, false)
    data_factory_proxy       = optional(bool, false)
    vpn_database_access      = optional(bool, true)
    nsg                      = optional(bool, true)
    db_replica_nsg           = optional(bool, false)
    all_vnet_database_access = optional(bool, false)
  })
  default = {
    nsg_metabase             = false
    data_factory_proxy       = false
    vpn_database_access      = true
    nsg                      = true
    db_replica_nsg           = false
    all_vnet_database_access = false
  }
  description = "(Optional) Enable/Disable features"
}

variable "vpn_gateway_address_space" {
  type    = string
  default = "172.16.1.0/24"
}

variable "trino_xmx" {
  type    = string
  default = "4G"
}
variable "vmss_size" {
  type    = string
  default = "Standard_D2ds_v5"
}

variable "external_database_connection" {
  type = map(object({
    connector_name       = string
    url                  = string
    params               = optional(map(string), {})
    user_secret_name     = string
    password_secret_name = string
  }))
  description = "Map of external database connection configurations"
  default     = {}
}

variable "vnet_ita_ddos_protection_plan" {
  type = object({
    id     = string
    enable = bool
  })
  default = null
}
