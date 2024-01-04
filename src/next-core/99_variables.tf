locals {
  product             = "${var.prefix}-${var.env_short}"
  project             = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  geo_replica_project = "${var.prefix}-${var.env_short}-${var.geo_replica_location_short}-${var.domain}-replica"

  monitor_appinsights_name        = "${local.product}-appinsights"
  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "PagoPA"

  ingress_hostname_prefix               = "${var.instance}.${var.domain}"
  internal_dns_zone_name                = "${var.dns_zone_internal_prefix}.${var.external_domain}"
  internal_dns_zone_resource_group_name = "${local.product}-vnet-rg"

  vnet_core_name                = "${local.product}-vnet"
  vnet_core_resource_group_name = "${local.product}-vnet-rg"

  data_resource_group_name = "${local.product}-data-rg"

  vnet_integration_name                = "${local.product}-vnet-integration"
  vnet_integration_resource_group_name = "${local.product}-vnet-rg"

  dns_forwarder_backup_name = "${local.product}-dns-forwarder-backup-vmss"

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

variable "cidr_subnet_tools_cae" {
  type        = list(string)
  description = "Tool container app env, network address space."
}

variable "instance" {
  type        = string
  description = "One of beta, prod01, prod02"
}

variable "lock_enable" {
  type        = bool
  default     = false
  description = "Apply locks to block accedentaly deletions."
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}
### Network

variable "cidr_subnet_dns_forwarder_backup" {
  type        = list(string)
  description = "Address prefixes subnet dns forwarder backup."
  default     = null
}


### External resources

variable "monitor_resource_group_name" {
  type        = string
  description = "Monitor resource group name"
}

variable "log_analytics_workspace_name" {
  type        = string
  description = "Specifies the name of the Log Analytics Workspace."
}

variable "log_analytics_workspace_resource_group_name" {
  type        = string
  description = "The name of the resource group in which the Log Analytics workspace is located in."
}

# DNS
variable "external_domain" {
  type        = string
  default     = "pagopa.it"
  description = "Domain for delegation"
}

variable "dns_zone_internal_prefix" {
  type        = string
  default     = null
  description = "The dns subdomain."
}

#
# dns forwarder
#
variable "dns_forwarder_backup_is_enabled" {
  type        = bool
  description = "Allow to enable or disable dns forwarder backup"
}

variable "dns_forwarder_vm_image_name" {
  type        = string
  description = "Image name for dns forwarder"
  default     = null
}


#
# replica variables
#
variable "geo_replica_enabled" {
  type        = bool
  description = "(Optional) True if geo replica should be active for key data components i.e. PostgreSQL Flexible servers"
  default     = false
}

variable "geo_replica_location" {
  type        = string
  description = "(Optional) Location of the geo replica"
  default     = "northeurope"
}

variable "geo_replica_location_short" {
  type        = string
  description = "(Optional) Short Location of the geo replica"
  default     = "neu"
}

variable "geo_replica_cidr_vnet" {
  type        = list(string)
  description = "(Required) Cidr block for replica vnet address space"
  default     = null
}

variable "geo_replica_ddos_protection_plan" {
  type = object({
    id     = string
    enable = bool
  })
  default = null
}

variable "postgres_private_dns_enabled" {
  type        = bool
  description = "(Optional) If true creates a private dns that can be used to access the postgres databases"
  default     = false
}


variable "logos_donations_storage_account_replication_type" {
  type        = string
  default     = "LRS"
  description = "(Optional) Logos donations storage account replication type"
}

variable "enable_logos_backup" {
  type        = bool
  default     = true
  description = "(Optional) Enables nodo sftp storage account backup"
}

variable "logos_backup_retention" {
  type        = number
  default     = 7
  description = "(Optional) Blob backup retention"
}

#
# Feature flags
#
variable "is_resource" {
  type = object({
    container_app_tools_cae = optional(bool, false),
  })
}
