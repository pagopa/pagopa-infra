variable "location" {
  type    = string
  default = "westeurope"
}

variable "prefix" {
  type    = string
  default = "pagopa"
}

variable "env_short" {
  type = string
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}
variable "plan_name" {
  type        = string
  description = "Name of the service plan"
}
# variable "name" {
#   description = "Function App Name"
#   type        = string
#   deformat("%s-auth-ms", var.prefix)
# }
variable "law_sku" {
  type        = string
  description = "Sku of the Log Analytics Workspac"
  default     = "PerGB2018"
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
variable "law_daily_quota_gb" {
  type        = number
  description = "The workspace daily quota for ingestion in GB."
  default     = -1
}
variable "law_retention_in_days" {
  type        = number
  description = "The workspace data retention in days"
  default     = 30
}
variable "key_vault_owner_id" {
  type        = string
  description = "Key Vaut Owner id"
  default     = "standard"
}
variable "key_vault_sku" {
  type        = string
  description = "Key Vaut SKU"
  default     = "standard"
}

variable "cert_name" {
  type = string
  default = "ecpa-d-cert-client-auth"
}
# variable "app_service_certificate_name" {
#   type        = string
#   description = "Name of the SSL/TLS certificate for the App Service"
# }
