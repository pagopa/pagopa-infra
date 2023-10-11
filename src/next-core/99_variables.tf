locals {
  product = "${var.prefix}-${var.env_short}"
  project = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"

  monitor_appinsights_name        = "${local.product}-appinsights"
  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "PagoPA"

  ingress_hostname_prefix               = "${var.instance}.${var.domain}"
  internal_dns_zone_name                = "${var.dns_zone_internal_prefix}.${var.external_domain}"
  internal_dns_zone_resource_group_name = "${local.product}-vnet-rg"

  vnet_core_name                = "${local.product}-vnet"
  vnet_core_resource_group_name = "${local.product}-vnet-rg"

  #
  # KeyVault
  #
  key_vault_domain_name           = "dvopla-d-diego-kv"
  key_vault_domain_resource_group = "dvopla-d-diego-sec-rg"

  #
  # Container App
  #
  container_app_dns_forwarder_environment_resource_group = "dvopla-${var.env_short}-diego-container-app-rg"

  container_app_dns_forwarder_environment_name              = "dvopla-${var.env_short}-dns-forwarder-cappenv"
  container_app_dapr_environment_name               = "dvopla-d-dapr-cappenv"
  container_app_dapr_environment_component_cosmosdb = "/tmp/${local.container_app_dapr_environment_name}.yaml"


  container_app_devops_java_springboot_color_name           = "devops-color-java-capp"
  container_app_devops_java_springboot_color_revision_id    = "v1"
  container_app_devops_java_springboot_color_yaml_file_name = "/tmp/${local.container_app_devops_java_springboot_color_revision_id}-${local.container_app_devops_java_springboot_color_name}.yaml"

  container_app_devops_ambassador_name           = "ambassador-capp"
  container_app_devops_ambassador_revision_id    = "v3"
  container_app_devops_ambassador_yaml_file_name = "/tmp/${local.container_app_devops_java_springboot_color_revision_id}-${local.container_app_devops_ambassador_name}.yaml"

  cosmosdb_db_name         = "mydbsqldapr"
  cosmosdb_collection_name = "mycollectiondapr"
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

variable "terraform_remote_state_core" {
  type = object({
    resource_group_name  = string,
    storage_account_name = string,
    container_name       = string,
    key                  = string
  })
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

variable "k8s_kube_config_path_prefix" {
  type    = string
  default = "~/.kube"
}

# DNS
variable "external_domain" {
  type        = string
  default     = "pagopa.it"
  description = "Domain for delegation"
}

variable "dns_zone_prefix" {
  type        = string
  description = "The dns subdomain."
}

variable "dns_zone_internal_prefix" {
  type        = string
  default     = null
  description = "The dns subdomain."
}
