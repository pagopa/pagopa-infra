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

variable "cdn_location" {
  type = string
}

variable "instance" {
  type        = string
  description = "One of beta, prod01, prod02"
}


### FEATURE FLAGS

variable "is_feature_enabled" {
  type = object({
    cosmos                  = optional(bool, false),
    redis                   = optional(bool, false),
    storage                 = optional(bool, false),
    redis_hub_spoke_pe_dns  = optional(bool, false),
    cosmos_hub_spoke_pe_dns = optional(bool, false),
  })
  description = "Features enabled in this domain"
}

### External resources

variable "monitor_italy_resource_group_name" {
  type        = string
  description = "Monitor Italy resource group name"
}

variable "log_analytics_italy_workspace_name" {
  type        = string
  description = "Specifies the name of the Log Analytics Workspace Italy."
}

variable "log_analytics_italy_workspace_resource_group_name" {
  type        = string
  description = "The name of the resource group in which the Log Analytics workspace Italy is located in."
}

variable "ingress_load_balancer_ip" {
  type = string
}

# DNS

variable "dns_zone_prefix" {
  type        = string
  default     = null
  description = "The wallet dns subdomain."
}

variable "external_domain" {
  type        = string
  default     = null
  description = "Domain for delegation"
}

variable "dns_zone_platform" {
  type        = string
  default     = null
  description = "The platform dns subdomain."
}

variable "dns_zone_internal_prefix" {
  type        = string
  default     = null
  description = "The dns subdomain."
}

variable "dns_default_ttl_sec" {
  type        = number
  description = "The DNS default TTL in seconds"
  default     = 3600
}

### NETWORK
variable "cidr_subnet_cosmosdb_pay_wallet" {
  type        = list(string)
  description = "Cosmos DB address space for wallet."
}

variable "cidr_subnet_redis_pay_wallet" {
  type        = list(string)
  description = "Redis DB address space for wallet."
}

variable "cidr_subnet_storage_pay_wallet" {
  type        = list(string)
  description = "Azure storage DB address space for pagoPA wallet."
}

variable "cidr_subnet_pay_wallet_user_aks" {
  type        = list(string)
  description = "AKS user address space for pagoPA pay-wallet."
}

# CosmosDb

variable "cosmos_mongo_db_params" {
  type = object({
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
    ip_range_filter                              = list(string)
    enable_provisioned_throughput_exceeded_alert = bool
  })
}

variable "cosmos_mongo_db_pay_wallet_params" {
  type = object({
    enable_serverless  = bool
    enable_autoscaling = bool
    throughput         = number
    max_throughput     = number
  })
}

### Redis

variable "redis_pay_wallet_params" {
  type = object({
    capacity = number
    sku_name = string
    family   = string
    version  = string
    zones    = list(number)
  })
}

variable "redis_std_pay_wallet_params" {
  type = object({
    capacity = number
    sku_name = string
    family   = string
    version  = string
    zones    = list(number)
  })
}

variable "enable_iac_pipeline" {
  type        = bool
  description = "If true create the key vault policy to allow used by azure devops iac pipelines."
  default     = false
}

### Storage

variable "pay_wallet_storage_params" {
  type = object({
    kind                          = string,
    tier                          = string,
    account_replication_type      = string,
    advanced_threat_protection    = bool,
    retention_days                = number,
    public_network_access_enabled = bool,
  })
  description = "Azure storage DB params for pagoPA wallet resources."
}

variable "aks_user_node_pool" {
  type = object({
    enabled                    = optional(bool, true),
    name                       = string,
    vm_size                    = string,
    os_disk_type               = string,
    os_disk_size_gb            = string,
    node_count_min             = number,
    node_count_max             = number,
    node_labels                = map(any),
    node_taints                = list(string),
    node_tags                  = map(any),
    ultra_ssd_enabled          = optional(bool, false),
    enable_host_encryption     = optional(bool, true),
    max_pods                   = optional(number, 250),
    upgrade_settings_max_surge = optional(string, "30%"),
    zones                      = optional(list(any), [1, 2, 3]),
  })
  description = "AKS node pool user configuration"
}

variable "pay_wallet_jwt_issuer_api_key_use_primary" {
  type        = bool
  description = "If true the current active API key used for jwt issuer service will be the primary one."
  default     = true
}

variable "payment_wallet_service_api_key_use_primary" {
  type        = bool
  description = "If true the current active API key used for wallet service requests will be the primary one."
  default     = true
}
