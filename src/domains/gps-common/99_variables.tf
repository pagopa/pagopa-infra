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

### Italy location
variable "location_ita" {
  type        = string
  description = "Main location"
  default     = "italynorth"
}

variable "location_short_ita" {
  type        = string
  description = "Main location"
  default     = "itn"
}

variable "instance" {
  type        = string
  description = "One of beta, prod01, prod02"
}


variable "gpd_archive_advanced_threat_protection" {
  type        = bool
  description = "Enable contract threat advanced protection"
  default     = false
}

variable "gpd_archive_replication_type" {
  type        = string
  description = "Archive storage account replication type"
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

variable "cidr_subnet_pg_flex_dbms" {
  type        = list(string)
  description = "Postgres Flexible Server network address space."
}
variable "cidr_subnet_pg_singleser" {
  type        = list(string)
  description = "Postgres Single Server network address space."
  default     = []
}

# Postgres Flexible
variable "pgres_flex_params" {
  type = object({
    private_endpoint_enabled                         = bool
    sku_name                                         = string
    db_version                                       = string
    storage_mb                                       = string
    zone                                             = number
    backup_retention_days                            = number
    geo_redundant_backup_enabled                     = bool
    high_availability_enabled                        = bool
    standby_availability_zone                        = number
    pgbouncer_enabled                                = bool
    alerts_enabled                                   = bool
    max_connections                                  = number
    enable_private_dns_registration                  = optional(bool, false)
    enable_private_dns_registration_virtual_endpoint = optional(bool, false)
    max_worker_process                               = number
    wal_level                                        = string
    shared_preoload_libraries                        = string
    public_network_access_enabled                    = bool
  })

  default = null
}

variable "pgflex_public_metric_alerts" {
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

// gpd Database
variable "gpd_db_name" {
  type        = string
  description = "Name of the DB to connect to"
  default     = "apd"
}

variable "gpd_upload_status_ttl" {
  type        = number
  description = "The default time in seconds to live of SQL container. If present and the value is set to -1, it is equal to infinity, and items don’t expire by default. "
  default     = -1
}

variable "cosmos_gps_db_params" {
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

// gpd-upload-status container (gpd database)
variable "gpd_upload_status_throughput" {
  type        = number
  description = "Max container throughput (Cosmos-RU)"
  default     = 1000
}

variable "cidr_subnet_gps_cosmosdb" {
  type        = list(string)
  description = "Cosmos DB address space"
  default     = null
}

variable "cosmos_gpd_payments_db_params" {
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
    payments_receipts_table = object({
      autoscale  = bool
      throughput = number
    })
    payments_pp_table = object({
      autoscale  = bool
      throughput = number
    })
  })
}

variable "cidr_subnet_gpd_payments_cosmosdb" {
  type        = list(string)
  description = "Cosmos DB gpd payments address space"
  default     = null
}

variable "enable_iac_pipeline" {
  type        = bool
  description = "If true create the key vault policy to allow used by azure devops iac pipelines."
  default     = false
}

variable "storage_account_replication_type" {
  type        = string
  default     = "LRS"
  description = "(Optional) Fn app storage acocunt replication type"
}

variable "flow_storage_account_replication_type" {
  type        = string
  default     = "LRS"
  description = "(Optional) Reporting storage acocunt replication type"
}

variable "enable_gpd_archive_backup" {
  type        = bool
  default     = false
  description = "(Optional) Enables nodo sftp storage account backup"
}

variable "reporting_storage_account" {
  type = object({
    advanced_threat_protection = bool
    blob_delete_retention_days = number
    blob_versioning_enabled    = bool
    backup_enabled             = bool
    backup_retention           = optional(number, 0)
  })
  default = {
    blob_versioning_enabled    = false
    advanced_threat_protection = false
    blob_delete_retention_days = 30
    backup_enabled             = false
    backup_retention           = 0
  }
}

################
#GPD-SFTP-START#
################

variable "gpd_sftp_sa_replication_type" {
  type        = string
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa"
}

variable "gpd_sftp_sa_access_tier" {
  type        = string
  default     = "Hot"
  description = "(Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot"
}

variable "gpd_sftp_disable_network_rules" {
  type        = bool
  description = "If false, allow any connection from outside the vnet"
  default     = false
}

variable "gpd_sftp_ip_rules" {
  type        = list(string)
  description = "List of public IP or IP ranges in CIDR Format allowed to access the storage account. Only IPV4 addresses are allowed"
  default     = []
}

variable "gpd_sftp_enable_private_endpoint" {
  type        = bool
  description = "If true, create a private endpoint for the GPD storage account"
  default     = false
}

variable "gpd_sftp_sa_snet_private_link_service_network_policies_enabled" {
  type        = bool
  description = "If true, create a private link service"
  default     = true
}

variable "gpd_sftp_cidr_subnet_gpd_storage_account" {
  type        = list(string)
  description = "Storage account network address space."
}

variable "gpd_sftp_sa_public_network_access_enabled" {
  type        = bool
  description = "True if public network access is enabled. It should always set to false unless there are special needs"
  default     = false
}

variable "gpd_sftp_sa_tier_to_cool" {
  type        = number
  description = "Number of days after which the blob is moved to cool"
}

variable "gpd_sftp_sa_tier_to_archive" {
  type        = number
  description = "Number of days after which the blob is moved to archive"
  default     = -1
}

variable "gpd_sftp_sa_delete" {
  type        = number
  description = "Number of days after which the blob is deleted"
}

##############
#GPD-SFTP-END#
##############

variable "geo_replica_enabled" {
  type        = bool
  description = "(Optional) True if geo replica should be active for key data components i.e. PostgreSQL Flexible servers"
  default     = false
}

variable "geo_replica_cidr_subnet_postgresql" {
  type        = list(string)
  description = "Address prefixes replica subnet postgresql"
  default     = null
}

variable "location_replica" {
  type        = string
  description = "One of westeurope, italynorth"
  default     = "italynorth"
}

variable "location_replica_short" {
  type = string
  validation {
    condition = (
      length(var.location_replica_short) == 3
    )
    error_message = "Length must be 3 chars."
  }
  description = "One of wue, itn"
  default     = "itn"
}


variable "gpd_cdc_enabled" {
  type        = bool
  description = "Enable CDC for GDP"
  default     = false
}

variable "eventhub_namespace_rtp" {
  description = "Namespace configuration"
  type = object({
    auto_inflate_enabled     = bool
    sku_name                 = string
    capacity                 = string
    maximum_throughput_units = number
    public_network_access    = bool
    private_endpoint_created = bool
    metric_alerts_create     = bool
    metric_alerts            = object({})
  })
}

variable "eventhubs_rtp" {
  description = "A list of event hubs to add to namespace."
  type = list(object({
    name              = string
    partitions        = number
    message_retention = number
    consumers         = list(string)
    keys = list(object({
      name   = string
      listen = bool
      send   = bool
      manage = bool
    }))
  }))
  default = []
}

variable "redis_ha_enabled" {
  type        = bool
  description = "(Required) If true, enables the usage of HA redis instance"
}

variable "rtp_storage_account" {
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

  default = {
    account_kind                  = "StorageV2"
    account_tier                  = "Standard"
    account_replication_type      = "LRS"
    blob_versioning_enabled       = false
    advanced_threat_protection    = true
    public_network_access_enabled = false
    blob_delete_retention_days    = 30
    enable_low_availability_alert = false
    backup_enabled                = false
    backup_retention              = 0
  }
}

######################
#GPD-PG-STORICO-START#
######################
variable "pgflex_storico_params" {
  type = object({
    pgres_flex_pgbouncer_enabled           = bool
    alerts_enabled                         = bool
    pgres_flex_diagnostic_settings_enabled = bool
    max_connections                        = number
    enable_private_dns_registration        = optional(bool, false)
    max_worker_processes                   = number
  })
}

variable "pgflex_storico_public_metric_alerts" {

  description = <<EOD
  Map of name = criteria objects
  EOD

  type = map(object({
    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]
    aggregation = string
    metric_name = string
    # "Insights.Container/pods" "Insights.Container/nodes"
    metric_namespace = string
    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]
    operator  = string
    threshold = number
    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H
    frequency = string
    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.
    window_size = string
    # severity: The severity of this Metric Alert. Possible values are 0, 1, 2, 3 and 4. Defaults to 3.
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
      threshold        = 80
      severity         = 2
    },
    connections_failed = {
      frequency        = "PT5M"
      window_size      = "PT30M"
      metric_namespace = "Microsoft.DBforPostgreSQL/flexibleServers"
      aggregation      = "Total"
      metric_name      = "connections_failed"
      operator         = "GreaterThan"
      threshold        = 80
      severity         = 2
    }
  }
}

variable "gpd_db_storico_name" {
  type        = string
  description = "GPD Storico DB name"
  default     = "apd"
}

variable "pgflex_storico_geo_replication" {
  type = object({
    enabled                     = bool
    name                        = string
    location                    = string
    private_dns_registration_ve = bool
  })
}

####################
#GPD-PG-STORICO-END#
####################
