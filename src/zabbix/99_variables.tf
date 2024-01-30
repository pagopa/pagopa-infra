locals {
  product = "${var.prefix}-${var.env_short}"
  project = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"

  vnet_core_name                = "${local.product}-vnet"
  vnet_core_resource_group_name = "${local.product}-vnet-rg"

  dns_zone_private_name_postgres = "privatelink.postgres.database.azure.com"

  tools_container_app_env    = "pagopa-${var.env_short}-tools-cae"
  tools_container_app_env_rg = "pagopa-${var.env_short}-core-tools-rg"
}

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

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}

variable "cidr_subnet_pg_flex_zabbix" {
  type        = list(any)
  description = "values for cidr_subnet_pg_flex_zabbix"
}

# variable "image_rg_name" {
#   type        = string
#   description = "Resource group name that contains the image"
# }

# variable "image_name" {
#   type        = string
#   description = "Image name"
# }

#
# Feature flags
#
variable "enabled_resource" {
  type = object({
    zabbix_kv_enabled      = optional(bool, false),
    zabbix_pgflexi_enabled = optional(bool, false),
  })
}
