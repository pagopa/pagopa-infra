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

# CosmosDb
variable "cidr_subnet_cosmosdb_ecommerce" {
  type        = list(string)
  description = "Cosmos DB address space for ecommerce."
}

variable "cosmos_mongo_db_params" {
  type = object({
    enabled        = bool
    capabilities   = list(string)
    offer_type     = string
    server_version = string
    kind           = string
    consistency_policy = object({
      consistency_level       = string
      max_interval_in_seconds = number
      max_staleness_prefix    = number
    })
    enable_free_tier                 = bool
    main_geo_location_zone_redundant = bool
    additional_geo_locations = list(object({
      location          = string
      failover_priority = number
      zone_redundant    = bool
    }))
    private_endpoint_enabled                     = bool
    public_network_access_enabled                = bool
    is_virtual_network_filter_enabled            = bool
    backup_continuous_enabled                    = bool
    enable_provisioned_throughput_exceeded_alert = bool
  })
}

variable "cosmos_mongo_db_ecommerce_params" {
  type = object({
    enable_serverless  = bool
    enable_autoscaling = bool
    throughput         = number
    max_throughput     = number
  })
}

variable "cosmos_mongo_db_ecommerce_history_params" {
  type = object({
    enable_serverless  = bool
    enable_autoscaling = bool
    throughput         = number
    max_throughput     = number
  })
}

variable "cosmos_mongo_db_ecommerce_watchdog_params" {
  type = object({
    enable_serverless  = bool
    enable_autoscaling = bool
    throughput         = number
    max_throughput     = number
  })
}

# Redis
variable "cidr_subnet_redis_ecommerce" {
  type        = list(string)
  description = "Redis DB address space for ecommerce."
}

variable "redis_ecommerce_params" {
  type = object({
    capacity   = number
    sku_name   = string
    family     = string
    version    = string
    ha_enabled = bool
    zones      = list(number)
  })
}

variable "cidr_subnet_storage_ecommerce" {
  type        = list(string)
  description = "Azure storage DB address space for ecommerce."
}

variable "ecommerce_storage_deadletter_params" {
  type = object({
    enabled                       = bool,
    kind                          = string,
    tier                          = string,
    account_replication_type      = string,
    advanced_threat_protection    = bool,
    retention_days                = number,
    public_network_access_enabled = bool,
  })

  default = {
    enabled                       = false,
    kind                          = "StorageV2"
    tier                          = "Standard",
    account_replication_type      = "LRS",
    advanced_threat_protection    = true,
    retention_days                = 7,
    public_network_access_enabled = false,
  }
  description = "Azure storage DB params for ecommerce deadletter resources."
}

variable "ecommerce_storage_transient_params" {
  type = object({
    enabled                       = bool,
    kind                          = string,
    tier                          = string,
    account_replication_type      = string,
    advanced_threat_protection    = bool,
    retention_days                = number,
    public_network_access_enabled = bool,
  })
  default = {
    enabled                       = false,
    kind                          = "StorageV2"
    tier                          = "Standard",
    account_replication_type      = "LRS",
    advanced_threat_protection    = true,
    retention_days                = 7,
    public_network_access_enabled = false,
  }
  description = "Azure storage DB params for ecommerce transient resources."
}

variable "enable_iac_pipeline" {
  type        = bool
  description = "If true create the key vault policy to allow used by azure devops iac pipelines."
  default     = false
}

variable "ecommerce_jwt_issuer_api_key_use_primary" {
  type        = bool
  description = "If true the current active API key used for jwt issuer service will be the primary one."
  default     = true
}
