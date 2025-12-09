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

variable "location_itn" {
  type        = string
  description = "Default italynorth"
}

variable "location_short_itn" {
  type = string
  # validation {
  #   condition = (
  #     length(var.location_short_itn) == 3
  #   )
  #   error_message = "Length must be 3 chars."
  # }
  description = "Default itn"
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

#
# EVH
#
variable "cidr_subnet_qi_evh" {
  type        = list(string)
  description = "Address prefixes evh"
}

variable "ehns_private_endpoint_is_present" {
  type        = bool
  description = "(Required) create private endpoint to the event hubs"
}

variable "ehns_public_network_access" {
  type        = bool
  description = "(Required) enables public network access to the event hubs"
}

variable "ehns_sku_name" {
  type        = string
  description = "Defines which tier to use."
}

variable "ehns_capacity" {
  type        = number
  description = "Specifies the Capacity / Throughput Units for a Standard SKU namespace."
}

variable "ehns_maximum_throughput_units" {
  type        = number
  description = "Specifies the maximum number of throughput units when Auto Inflate is Enabled"
}

variable "ehns_auto_inflate_enabled" {
  type        = bool
  description = "Is Auto Inflate enabled for the EventHub Namespace?"
}

variable "ehns_zone_redundant" {
  type        = bool
  description = "Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones)."
}

variable "ehns_alerts_enabled" {
  type        = bool
  description = "Event hub alerts enabled?"
}

variable "ehns_metric_alerts_qi" {
  default = {}

  description = <<EOD
Map of name = criteria objects
EOD

  type = map(object({
    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]
    aggregation = string
    metric_name = string
    description = string
    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]
    operator  = string
    threshold = number
    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H
    frequency = string
    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.
    window_size = string

    dimension = list(object(
      {
        name     = string
        operator = string
        values   = list(string)
      }
    ))
  }))
}

### list of evh to add to namespace for bdi
variable "eventhubs_bdi" {
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

# CosmosDb

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

variable "cosmos_mongo_db_accounting_reconciliation_params" {
  type = object({
    enable_serverless  = bool
    enable_autoscaling = bool
    throughput         = number
    max_throughput     = number
  })
}
