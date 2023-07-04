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

variable "instance" {
  type        = string
  description = "One of beta, prod01, prod02"
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
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

variable "application_insights_name" {
  type        = string
  description = "Specifies the name of the Application Insights."
}

variable "mock_ec_enabled" {
  type        = bool
  description = "Mock EC enabled"
  default     = false
}

variable "mock_ec_secondary_enabled" {
  type        = bool
  description = "Mock Secondary EC enabled"
  default     = false
}

variable "cidr_subnet_mock_ec" {
  type        = list(string)
  description = "Address prefixes subnet mock ec"
  default     = null
}

variable "mock_ec_always_on" {
  type        = bool
  description = "Mock EC always on property"
  default     = false
}

variable "mock_ec_tier" {
  type        = string
  description = "Mock EC Plan tier"
  default     = "Standard"
}

variable "mock_ec_size" {
  type        = string
  description = "Mock EC Plan size"
  default     = "S1"
}

variable "mock_payment_gateway_enabled" {
  type        = bool
  description = "Mock payment gateway enabled"
  default     = false
}

variable "mock_payment_gateway_always_on" {
  type        = bool
  description = "Mock payment gateway always on property"
  default     = false
}

variable "mock_payment_gateway_tier" {
  type        = string
  description = "Mock payment gateway Plan tier"
  default     = "Standard"
}

variable "mock_payment_gateway_size" {
  type        = string
  description = "Mock payment gateway Plan size"
  default     = "S1"
}

variable "cidr_subnet_mock_payment_gateway" {
  type        = list(string)
  description = "Address prefixes subnet mock payment_gateway"
  default     = null
}

variable "external_domain" {
  type        = string
  default     = null
  description = "Domain for delegation"
}

variable "dns_zone_prefix" {
  type        = string
  default     = null
  description = "The dns subdomain."
}

variable "dns_zone_internal_prefix" {
  type        = string
  default     = null
  description = "The dns subdomain."
}

variable "ingress_load_balancer_ip" {
  type = string
}

variable "cidr_subnet_dbms" {
  type        = list(string)
  description = "Postgres Server network address space."
}

variable "cidr_subnet_pgflex_dbms" {
  type        = list(string)
  description = "Postgres Flexible Server network address space."
}

variable "mocker_db_name" {
  type        = string
  description = "Name of the DB to connect to"
  default     = "mocker"
}

# Postgres Flexible
variable "pgflex_params" {
  type = object({
    private_endpoint_enabled     = bool
    sku_name                     = string
    db_version                   = string
    storage_mb                   = string
    zone                         = number
    backup_retention_days        = number
    geo_redundant_backup_enabled = bool
    high_availability_enabled    = bool
    standby_availability_zone    = number
    pgbouncer_enabled            = bool
  })

  default = null
}

variable "postgresql_network_rules" {
  description = "Network rules restricting access to the postgresql server."
  type = object({
    ip_rules                       = list(string)
    allow_access_to_azure_services = bool
  })
  default = {
    ip_rules                       = []
    allow_access_to_azure_services = false
  }
}

variable "enable_iac_pipeline" {
  type        = bool
  description = "If true create the key vault policy to allow used by azure devops iac pipelines."
  default     = false
}
