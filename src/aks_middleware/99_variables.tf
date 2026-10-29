
variable "https_endpoint" {
  type        = string
  description = "Https endpoint to check"
}

variable "location_string" {
  type        = string
  description = "(Required) Location string"
}

variable "alert_name" {
  type        = string
  description = "(Optional) Alert name"
  default     = null
}

variable "alert_enabled" {
  type        = bool
  description = "(Optional) Is this alert enabled?"
  default     = true
}

variable "namespace" {
  type        = string
  description = "(Required) Namespace where the helm chart will be installed"
}

variable "helm_chart_present" {
  type        = bool
  description = "Is this helm chart present?"
  default     = true
}

variable "keyvault_name" {
  type        = string
  description = "(Required) Keyvault name"
}

variable "keyvault_tenant_id" {
  type        = string
  description = "(Required) Keyvault tenant id"
}

variable "kv_secret_name_for_application_insights_connection_string" {
  type        = string
  description = "(Required) The name of the secret inside the kv that contains the application insights connection string"
}

variable "application_insights_resource_group" {
  type        = string
  description = "(Required) Application Insights resource group"
}

variable "application_insights_id" {
  type        = string
  description = "(Required) Application Insights id"
}

variable "application_insights_action_group_ids" {
  type        = list(string)
  description = "(Required) Application insights action group ids"
}

variable "workload_identity_service_account_name" {
  type        = string
  description = "Service account name linked to workload identity"
  default     = null
}

variable "workload_identity_client_id" {
  type        = string
  description = "ClientID in form of 'qwerty123-a1aa-1234-xyza-qwerty123' linked to workload identity"
  default     = null
}