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
  description = "One of westeurope, northeurope, italynorth"
}
variable "location_alt" { # alt = alternative
  type        = string
  description = "One of westeurope, northeurope, italynorth"
}

variable "location_short" {
  type = string
  validation {
    condition = (
      length(var.location_short) == 3
    )
    error_message = "Length must be 3 chars."
  }
  description = "One of wue, neu, itn"
}
variable "location_short_alt" { # alt = alternative
  type = string
  validation {
    condition = (
      length(var.location_short_alt) == 3
    )
    error_message = "Length must be 3 chars."
  }
  description = "One of wue, neu, itn"
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

variable "ingress_load_balancer_ip" {
  type = string
}

variable "external_domain" {
  type        = string
  default     = null
  description = "Domain for delegation"
}

variable "dns_zone_internal_prefix" {
  type        = string
  default     = null
  description = "The dns subdomain."
}

variable "enable_iac_pipeline" {
  type        = bool
  description = "If true create the key vault policy to allow used by azure devops iac pipelines."
  default     = false
}

variable "qi_storage_params" {
  type = object({
    enabled                       = bool,
    kind                          = string,
    tier                          = string,
    account_replication_type      = string,
    advanced_threat_protection    = bool,
    retention_days                = number,
    public_network_access_enabled = bool,
    access_tier                   = string
  })
  default = {
    enabled                       = false,
    kind                          = "StorageV2"
    tier                          = "Standard",
    account_replication_type      = "LRS",
    advanced_threat_protection    = true,
    retention_days                = 7,
    public_network_access_enabled = false,
    access_tier                   = "Hot"
  }
  description = "Azure storage DB params for qi function."
}

## SMO configuration
variable "cidr_subnet_pg_flex_smo_dbms" {
  type        = list(string)
  description = "Postgres Flexible Server network address space."
  default     = ["0.0.0.0"]
}

# Postgres Flexible
variable "pgres_flex_smo_params" {
  type = object({
    private_endpoint_enabled        = bool
    sku_name                        = string
    db_version                      = string
    storage_mb                      = string
    zone                            = number
    backup_retention_days           = number
    geo_redundant_backup_enabled    = bool
    high_availability_enabled       = bool
    standby_availability_zone       = number
    pgbouncer_enabled               = bool
    alerts_enabled                  = bool
    max_connections                 = number
    enable_private_dns_registration = optional(bool, false)
  })

  default = null
}

variable "pgflex_smo_public_metric_alerts" {
  description = <<EOD
  Map of name = criteria objects
  EOD

  type = map(object({
    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]
    aggregation = string
    # "Insights.Container/pods" "Insights.Container/nodes"
    metric_namespace = string
    metric_name      = string
    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]
    operator  = string
    threshold = number
    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H
    frequency = string
    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.
    window_size = string
    # severity: The severity of this Metric Alert. Possible values are 0, 1, 2, 3 and 4. Defaults to 3. Lower is worst
    severity = number
  }))

  default = {
    cpu_percent = {
      frequency        = "PT5M"
      window_size      = "PT30M"
      metric_namespace = "Microsoft.DBforPostgreSQL/flexibleServers"
      aggregation      = "Average"
      metric_name      = "cpu_percent"
      operator         = "GreaterThan"
      threshold        = 80
      severity         = 2
    },
    memory_percent = {
      frequency        = "PT5M"
      window_size      = "PT30M"
      metric_namespace = "Microsoft.DBforPostgreSQL/flexibleServers"
      aggregation      = "Average"
      metric_name      = "memory_percent"
      operator         = "GreaterThan"
      threshold        = 80
      severity         = 2
    },
    storage_percent = {
      frequency        = "PT5M"
      window_size      = "PT30M"
      metric_namespace = "Microsoft.DBforPostgreSQL/flexibleServers"
      aggregation      = "Average"
      metric_name      = "storage_percent"
      operator         = "GreaterThan"
      threshold        = 80
      severity         = 2
    },
    active_connections = {
      frequency        = "PT5M"
      window_size      = "PT30M"
      metric_namespace = "Microsoft.DBforPostgreSQL/flexibleServers"
      aggregation      = "Average"
      metric_name      = "active_connections"
      operator         = "GreaterThan"
      threshold        = 4000 // 80% of current active connections (5000)
      severity         = 2
    },
    connections_failed = {
      frequency        = "PT5M"
      window_size      = "PT30M"
      metric_namespace = "Microsoft.DBforPostgreSQL/flexibleServers"
      aggregation      = "Total"
      metric_name      = "connections_failed"
      operator         = "GreaterThan"
      threshold        = 10
      severity         = 2
    }
  }

}
