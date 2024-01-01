locals {
  product = "${var.prefix}-${var.env_short}"
  project = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"

  vnet_core_name                = "${local.product}-vnet"
  vnet_core_resource_group_name = "${local.product}-vnet-rg"

  dns_zone_private_name_postgres = "privatelink.postgres.database.azure.com"

  # Service account
  azure_devops_app_service_account_name        = "azure-devops"
  azure_devops_app_service_account_secret_name = "${local.azure_devops_app_service_account_name}-token"

  aks_name                = var.aks_name
  aks_resource_group_name = var.aks_resource_group_name

  internal_dns_zone_name                = "internal.dev.cstar.pagopa.it"
  internal_dns_zone_resource_group_name = "cstar-d-vnet-rg"
  ingress_hostname_prefix               = "dev01.zabbix"

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

variable "cidr_subnet_zabbix_server" {
  type        = list(string)
  description = "Subnet for zabbix vm"
}

variable "cidr_subnet_pg_flex_zabbix" {
  type        = list(any)
  description = "values for cidr_subnet_pg_flex_zabbix"
}

variable "image_rg_name" {
  type        = string
  description = "Resource group name that contains the image"
}

variable "image_name" {
  type        = string
  description = "Image name"
}

#
# Feature flags
#
variable "is_resource" {
  type = object({
    zabbix_pgflexi_enabled = bool,
  })
}

variable "k8s_kube_config_path_prefix" {
  type    = string
  default = "~/.kube"
}

### Aks

variable "aks_name" {
  type        = string
  description = "AKS cluster name"
}

variable "aks_resource_group_name" {
  type        = string
  description = "AKS cluster resource name"
}
