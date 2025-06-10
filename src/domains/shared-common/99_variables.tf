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

variable "location_italy" {
  type        = string
  description = "italy north"
}

variable "location_short_italy" {
  type = string
  validation {
    condition = (
      length(var.location_short_italy) == 3
    )
    error_message = "Length must be 3 chars."
  }
  description = "italy itn"
}

variable "instance" {
  type        = string
  description = "One of beta, prod01, prod02"
}


### POC reporting enrollment variables

variable "poc_versioning" {
  type        = bool
  description = "Enable sa versioning"
  default     = false
}

variable "poc_advanced_threat_protection" {
  type        = bool
  description = "Enable contract threat advanced protection"
  default     = false
}

variable "poc_delete_retention_days" {
  type        = number
  description = "Number of days to retain deleted."
  default     = 30
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

variable "reporting_storage_public_access_enabled" {
  type        = bool
  description = "(Optional) Whether the public network access is enabled?"
  default     = true
}

variable "cosmos_iuvgenerator_db_params" {
  type = object({
    kind           = string
    capabilities   = list(string)
    offer_type     = string
    server_version = string
    consistency_policy = object({
      consistency_level       = string
      max_interval_in_seconds = number
      max_staleness_prefix    = number
    })
    main_geo_location_zone_redundant = bool
    enable_free_tier                 = bool
    additional_geo_locations = list(object({
      location          = string
      failover_priority = number
      zone_redundant    = bool
    }))
    private_endpoint_enabled          = bool
    public_network_access_enabled     = bool
    is_virtual_network_filter_enabled = bool
    backup_continuous_enabled         = bool
  })
}

variable "cidr_subnet_iuvgenerator_cosmosdb" {
  type        = list(string)
  description = "Cosmos DB address space"
  default     = null
}

### Aks

variable "k8s_kube_config_path_prefix" {
  type    = string
  default = "~/.kube"
}

variable "cidr_subnet_loadtest_agent" {
  type        = list(string)
  description = "LoadTest Agent Pool address space"
  default     = null
}

variable "cidr_subnet_authorizer_cosmosdb" {
  type        = list(string)
  description = "Cosmos DB address space"
  default     = null
}

variable "cosmos_authorizer_db_params" {
  type = object({
    kind           = string
    capabilities   = list(string)
    offer_type     = string
    server_version = string
    consistency_policy = object({
      consistency_level       = string
      max_interval_in_seconds = number
      max_staleness_prefix    = number
    })
    main_geo_location_zone_redundant = bool
    enable_free_tier                 = bool
    additional_geo_locations = list(object({
      location          = string
      failover_priority = number
      zone_redundant    = bool
    }))
    private_endpoint_enabled          = bool
    public_network_access_enabled     = bool
    is_virtual_network_filter_enabled = bool
    backup_continuous_enabled         = bool
  })
}


variable "github_runner" {
  type = object({
    subnet_address_prefixes = list(string)
  })
  description = "GitHub runner variables"
  default = {
    subnet_address_prefixes = ["10.1.164.0/23"]
  }
}

variable "github_runner_italy" {
  type = object({
    subnet_address_prefixes = list(string)
  })
  description = "GitHub runner variables"
  default = {
    subnet_address_prefixes = ["10.3.16.0/23"]
  }
}

variable "github_runner_ita_enabled" {
  type        = bool
  description = "Enable github runner ita"
  default     = false
}

variable "taxonomy_storage_account" {
  type = object({
    account_kind                  = string
    account_tier                  = string
    account_replication_type      = string
    advanced_threat_protection    = bool
    blob_versioning_enabled       = bool
    public_network_access_enabled = bool
    blob_delete_retention_days    = number
    enable_low_availability_alert = bool
    backup_enabled                = optional(bool, false)
    backup_retention              = optional(number, 0)
  })
}
variable "cidr_subnet_taxonomy_storage_account" {
  type        = list(string)
  description = "Storage account network address space."
}
variable "taxonomy_network_rules" {
  type = object({
    default_action             = string
    ip_rules                   = list(string)
    virtual_network_subnet_ids = list(string)
    bypass                     = set(string)
  })
  description = "Network configuration of Taxonomy storage account"
  default     = null
}

variable "test_data_storage_account" {
  type = object({
    account_kind                  = string
    account_tier                  = string
    account_replication_type      = string
    advanced_threat_protection    = bool
    blob_versioning_enabled       = bool
    public_network_access_enabled = bool
    blob_delete_retention_days    = number
    enable_low_availability_alert = bool
  })
  default = null
}

variable "cidr_subnet_test_data_storage_account" {
  type        = list(string)
  description = "Storage account network address space."
  default     = null
}

variable "redis_ha_enabled" {
  type        = bool
  description = "(Required) If true, enables the usage of HA redis instance"
}


variable "github_repository_environment" {
  type = object({
    protected_branches     = bool
    custom_branch_policies = bool
    reviewers_teams        = list(string)
  })
  description = "GitHub Continuous Integration roles"
  default = {
    protected_branches     = false
    custom_branch_policies = true
    reviewers_teams        = ["pagopa-team-core"]
  }
}
