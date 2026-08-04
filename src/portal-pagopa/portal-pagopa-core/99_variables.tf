# General
variable "prefix" {
  type = string
  validation {
    condition     = length(var.prefix) <= 6
    error_message = "Max length is 6 chars."
  }
}

variable "env" {
  type = string
}

variable "env_short" {
  type = string
  validation {
    condition     = length(var.env_short) == 1
    error_message = "Length must be 1 chars."
  }
}

variable "domain" {
  type = string
  validation {
    condition     = length(var.domain) <= 12
    error_message = "Max length is 12 chars."
  }
}

variable "location" {
  type        = string
  description = "One of westeurope, northeurope, italynorth"
}

variable "location_short" {
  type = string
  validation {
    condition     = length(var.location_short) == 3
    error_message = "Length must be 3 chars."
  }
  description = "One of weu, neu, itn"
}

variable "app_service_sku_name" {
  type        = string
  description = "App Service Plan SKU (example: B2, P1v3)"
  default     = "B2"
}

variable "app_service_slot_enabled" {
  type        = bool
  description = "Enable App Service deployment slot"
  default     = false
}

variable "app_service_slot_name" {
  type        = string
  description = "Deployment slot name"
  default     = "staging"
}

variable "container_image_name" {
  type        = string
  description = "Container image including registry host"
  default     = "pagopadcommonacr.azurecr.io/pagopa-portal:latest"
}

# PostgreSQL
variable "postgres_database_name" {
  type        = string
  description = "Portal DB name"
  default     = "dipartimento_pagamenti"
}

variable "allow_azure_services_to_postgres" {
  type        = bool
  description = "If true, creates firewall rule 0.0.0.0 to allow Azure services"
  default     = false
}

variable "pgres_flex_params" {
  type = object({
    idh_resource                           = optional(string, "pgflex2")
    pgres_flex_diagnostic_settings_enabled = bool
    alerts_enabled                         = bool
  })
  description = "IDH postgres flexible server configuration"
  default = {
    idh_resource                           = "pgflex2"
    pgres_flex_diagnostic_settings_enabled = true
    alerts_enabled                         = false
  }
}

variable "postgres_admin_login_secret_name" {
  type        = string
  description = "Secret name in Key Vault for Postgres admin login"
  default     = "db-administrator-login"
}

variable "postgres_admin_password_secret_name" {
  type        = string
  description = "Secret name in Key Vault for Postgres admin password"
  default     = "db-administrator-login-password"
}

variable "database_url_secret_name" {
  type        = string
  description = "Secret name in Key Vault for app DATABASE_URL"
  default     = "portal-database-url"
}

# App settings
variable "app_secret_names" {
  type = map(string)
  default = {
    AUTH_SECRET           = "portal-auth-secret"
    AUTH_GOOGLE_ID        = "portal-auth-google-id"
    AUTH_GOOGLE_SECRET    = "portal-auth-google-secret"
    AWS_ACCESS_KEY_ID     = "portal-aws-access-key-id"
    AWS_SECRET_ACCESS_KEY = "portal-aws-secret-access-key"
    BUDGET_AUTH_SECRET    = "portal-budget-auth-secret"
    GITHUB_ISSUES_TOKEN   = "portal-github-issues-token"
    ONEMAIL_API_KEY       = "portal-onemail-api-key"
    TIMETRACK_AUTH_SECRET = "portal-timetrack-auth-secret"
    TRAINING_AUTH_SECRET  = "portal-training-auth-secret"
    OKR_AUTH_SECRET       = "portal-okr-auth-secret"
    RESEND_API_KEY        = "portal-resend-api-key"
    TEST_RESULTS_TOKEN    = "portal-test-results-token"
  }
  description = "Map app setting key => Key Vault secret name"
}

variable "next_public_app_url" {
  type        = string
  description = "Public app URL exposed by frontend"
  default     = "https://<domain>"
}

variable "email_from" {
  type        = string
  description = "Sender email"
  default     = "noreply@pagopa.it"
}

variable "aws_region" {
  type        = string
  description = "AWS region used by SES integration"
  default     = "eu-south-1"
}

variable "email_fallback_provider" {
  type        = string
  description = "Email fallback provider"
  default     = "none"
}

variable "email_provider" {
  type        = string
  description = "Primary email provider"
  default     = "onemail"
}

variable "email_public_app_url" {
  type        = string
  description = "Public app URL used in email templates"
  default     = "https://<domain>"
}

variable "github_issues_owner" {
  type        = string
  description = "GitHub owner for issues integration"
  default     = "pagopa"
}

variable "github_issues_repo" {
  type        = string
  description = "GitHub repository for issues integration"
  default     = "pagopa-payments-department-centralhub"
}

variable "onemail_base_url" {
  type        = string
  description = "OnEmail base URL"
  default     = "https://uat.onemail.pagopa.it"
}

variable "onemail_env" {
  type        = string
  description = "OnEmail environment"
  default     = "uat"
}

variable "onemail_from_email" {
  type        = string
  description = "OnEmail sender address"
  default     = "noreply@uat.internal-apps.platform.pagopa.it"
}

variable "onemail_tenant_name" {
  type        = string
  description = "OnEmail tenant name"
  default     = "TEST"
}

variable "playwright_test" {
  type        = bool
  description = "Playwright test mode"
  default     = false
}

variable "websites_port" {
  type        = number
  description = "Container listen port"
  default     = 3000
}

variable "timetrack_email_disable_send" {
  type        = bool
  description = "Disable timetrack email sends"
  default     = false
}

variable "timetrack_email_force_to" {
  type        = string
  description = "Forced timetrack recipient"
  default     = "cristiano.sticca@pagopa.it"
}

variable "timetrack_onemail_from_email" {
  type        = string
  description = "Timetrack OnEmail sender address"
  default     = "noreply@uat.internal-apps.platform.pagopa.it"
}

variable "training_email_disable_send" {
  type        = bool
  description = "Disable training email sends"
  default     = false
}

variable "training_email_force_to" {
  type        = string
  description = "Forced training recipient"
  default     = "cristiano.sticca@pagopa.it"
}

variable "training_onemail_from_email" {
  type        = string
  description = "Training OnEmail sender address"
  default     = "noreply@uat.internal-apps.platform.pagopa.it"
}

variable "websites_enable_app_service_storage" {
  type        = bool
  description = "Enable App Service storage mount"
  default     = false
}
