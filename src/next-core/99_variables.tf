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

#
# location
#
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
  type = string
  validation {
    condition = (
      length(var.location_short_ita) == 3
    )
    error_message = "Length must be 3 chars."
  }
  description = "Location short for italy: itn"
  default     = "itn"
}

variable "vnet_ita_ddos_protection_plan" {
  type = object({
    id     = string
    enable = bool
  })
  default = null
}

variable "instance" {
  type        = string
  description = "One of beta, prod01, prod02"
}

variable "lock_enable" {
  type        = bool
  default     = false
  description = "Apply locks to block accedentaly deletions."
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}
### Network

variable "cidr_vnet_italy" {
  type        = list(string)
  description = "Address prefixes for vnet in italy."
}

variable "cidr_subnet_dns_forwarder_backup" {
  type        = list(string)
  description = "Address prefixes subnet dns forwarder backup."
  default     = null
}

variable "cidr_subnet_tools_cae" {
  type        = list(string)
  description = "Tool container app env, network address space."
}

### VPN
variable "cidr_subnet_vpn" {
  type        = list(string)
  description = "VPN network address space."
  default     = [""]
}

variable "cidr_subnet_apim" {
  type        = list(string)
  description = "(Required) APIM v2 subnet cidr"
}

variable "cidr_subnet_appgateway_integration" {
  type        = list(string)
  description = "Address prefixes subnet integration appgateway."
  default     = null
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

# DNS
variable "external_domain" {
  type        = string
  default     = "pagopa.it"
  description = "Domain for delegation"
}

variable "dns_zone_internal_prefix" {
  type        = string
  default     = null
  description = "The dns subdomain."
}

#
# dns forwarder
#
variable "dns_forwarder_vm_image_name" {
  type        = string
  description = "Image name for dns forwarder"
  default     = null
}


#
# replica variables
#
variable "geo_replica_enabled" {
  type        = bool
  description = "(Optional) True if geo replica should be active for key data components i.e. PostgreSQL Flexible servers"
  default     = false
}

variable "geo_replica_location" {
  type        = string
  description = "(Optional) Location of the geo replica"
  default     = "northeurope"
}

variable "geo_replica_location_short" {
  type        = string
  description = "(Optional) Short Location of the geo replica"
  default     = "neu"
}

variable "geo_replica_cidr_vnet" {
  type        = list(string)
  description = "(Required) Cidr block for replica vnet address space"
  default     = null
}

variable "geo_replica_ddos_protection_plan" {
  type = object({
    id     = string
    enable = bool
  })
  default = null
}



variable "logos_donations_storage_account_replication_type" {
  type        = string
  default     = "LRS"
  description = "(Optional) Logos donations storage account replication type"
}

variable "enable_logos_backup" {
  type        = bool
  default     = true
  description = "(Optional) Enables nodo sftp storage account backup"
}

variable "logos_backup_retention" {
  type        = number
  default     = 7
  description = "(Optional) Blob backup retention"
}

variable "apim_v2_zones" {
  type        = list(string)
  description = "(Optional) Zones in which the apim will be deployed"
  default     = ["1"]
}

variable "apim_v2_subnet_nsg_security_rules" {
  type        = list(any)
  description = "Network security rules for APIM subnet"
}

variable "apim_v2_publisher_name" {
  type = string
}

variable "apim_v2_sku" {
  type = string
}

variable "redis_cache_enabled" {
  type        = bool
  description = "redis cache enabled"
  default     = false
}

variable "dns_zone_prefix" {
  type        = string
  default     = null
  description = "The dns subdomain."
}

variable "dns_zone_prefix_prf" {
  type        = string
  default     = "" # null
  description = "The dns subdomain."
}

variable "apim_v2_autoscale" {
  type = object(
    {
      enabled                       = bool
      default_instances             = number
      minimum_instances             = number
      maximum_instances             = number
      scale_out_capacity_percentage = number
      scale_out_time_window         = string
      scale_out_value               = string
      scale_out_cooldown            = string
      scale_in_capacity_percentage  = number
      scale_in_time_window          = string
      scale_in_value                = string
      scale_in_cooldown             = string
    }
  )
  default = {
    enabled                       = false
    default_instances             = 1
    minimum_instances             = 1
    maximum_instances             = 5
    scale_out_capacity_percentage = 60
    scale_out_time_window         = "PT10M"
    scale_out_value               = "2"
    scale_out_cooldown            = "PT45M"
    scale_in_capacity_percentage  = 30
    scale_in_time_window          = "PT30M"
    scale_in_value                = "1"
    scale_in_cooldown             = "PT30M"
  }
  description = "Configure Apim autoscale on capacity metric"
}

variable "apim_v2_alerts_enabled" {
  type        = bool
  description = "Enable alerts"
  default     = true
}


## Redis cache
variable "redis_cache_params" {
  type = object({
    public_access = bool
    capacity      = number
    sku_name      = string
    family        = string
  })
  default = {
    public_access = false
    capacity      = 1
    sku_name      = "Basic"
    family        = "C"
  }
}

variable "create_redis_multiaz" {
  type        = bool
  description = "(Optional) true if a multi az premium instance of redis is required"
  default     = false
}


variable "redis_zones" {
  type        = list(string)
  description = "(Optional) Zone list where redis will be deployed"
  default     = ["1"]
}

variable "redis_version" {
  type        = string
  description = "The version of Redis to use: 4 (deprecated) or 6"
  default     = "6"
}

## integration app gateway

variable "app_gateway_sku_name" {
  type        = string
  description = "The Name of the SKU to use for this Application Gateway. Possible values are Standard_Small, Standard_Medium, Standard_Large, Standard_v2, WAF_Medium, WAF_Large, and WAF_v2"
}

variable "app_gateway_sku_tier" {
  type        = string
  description = "The Tier of the SKU to use for this Application Gateway. Possible values are Standard, Standard_v2, WAF and WAF_v2"
}

variable "app_gateway_waf_enabled" {
  type        = bool
  description = "Enable waf"
  default     = false
}

variable "app_gateway_api_certificate_name" {
  type        = string
  description = "Application gateway api certificate name on Key Vault"
}

variable "app_gateway_min_capacity" {
  type    = number
  default = 0
}

variable "app_gateway_max_capacity" {
  type    = number
  default = 2
}

variable "app_gateway_alerts_enabled" {
  type        = bool
  description = "Enable alerts"
  default     = true
}

variable "app_gateway_portal_certificate_name" {
  type        = string
  description = "Application gateway developer portal certificate name on Key Vault"
}

variable "app_gateway_management_certificate_name" {
  type        = string
  description = "Application gateway api management certificate name on Key Vault"
}

variable "integration_appgateway_private_ip" {
  type        = string
  description = "Integration app gateway private ip"
}
variable "integration_appgateway_zones" {
  type        = list(number)
  description = "Integration app gateway private ip"
}

# apim named values
variable "checkout_enabled" {
  type    = bool
  default = true
}

variable "nodo_pagamenti_psp" {
  type        = string
  description = "PSP' white list nodo pagamenti (separate comma list) ."
  default     = ","
}

variable "nodo_pagamenti_ec" {
  type        = string
  description = "EC' black list nodo pagamenti (separate comma list)."
  default     = ","
}

variable "nodo_pagamenti_url" {
  type        = string
  description = "Nodo pagamenti url"
  default     = "https://"
}

variable "ip_nodo" { # TEMP used only for onPrem shall be replace with "lb_aks"
  type        = string
  description = "Nodo pagamenti ip"
}

variable "lb_aks" {
  type        = string
  description = "IP load balancer AKS Nexi/SIA"
  default     = "0.0.0.0"
}

variable "base_path_nodo_oncloud" {
  type        = string
  description = "base nodo on cloud"
}

variable "schema_ip_nexi" {
  type        = string
  description = "Nodo Pagamenti Nexi schema://ip"
}

variable "default_node_id" {
  type        = string
  description = "Default NodeId according to default base url"
}

variable "apim_enable_nm3_decoupler_switch" {
  type        = bool
  default     = false
  description = "Enable switch backend address in NM3 algorithm logic"
}

variable "apim_enable_routing_decoupler_switch" {
  type        = bool
  default     = false
  description = "Enable switch backend address in Routing algorithm logic"
}
variable "base_path_nodo_ppt_lmi" {
  type        = string
  description = "base nodo on cloud"
}
variable "base_path_nodo_ppt_lmi_dev" {
  type        = string
  description = "base nodo on cloud"
  default     = "/ppt-lmi-dev"
}

variable "base_path_nodo_sync" {
  type        = string
  description = "base nodo on cloud"
}

variable "base_path_nodo_sync_dev" {
  type        = string
  description = "base nodo on cloud"
  default     = "/sync-cron-dev/syncWisp"
}

variable "base_path_nodo_wfesp" {
  type        = string
  description = "base nodo on cloud"
}
variable "base_path_nodo_wfesp_dev" {
  type        = string
  description = "base nodo on cloud"
  default     = "/wfesp-dev"
}

variable "base_path_nodo_fatturazione" {
  type        = string
  description = "base nodo on cloud"
}
variable "base_path_nodo_fatturazione_dev" {
  type        = string
  description = "base nodo on cloud"
  default     = "/fatturazione-dev"
}

variable "base_path_nodo_web_bo" {
  type        = string
  description = "base nodo on cloud"
}
variable "base_path_nodo_web_bo_dev" {
  type        = string
  description = "base nodo on cloud"
  default     = "/web-bo-dev"
}

variable "base_path_nodo_web_bo_history" {
  type        = string
  description = "base nodo on cloud"
}
variable "base_path_nodo_web_bo_history_dev" {
  type        = string
  description = "base nodo on cloud"
  default     = "/web-bo-history-dev"
}

variable "dns_zone_wisp2" {
  type        = string
  default     = null
  description = "The wisp2 dns subdomain."
}

variable "app_gateway_prf_certificate_name" {
  type        = string
  description = "Application gateway api certificate name on Key Vault"
  default     = ""
}


#
# Event hub
#
variable "ehns_auto_inflate_enabled" {
  type        = bool
  description = "Is Auto Inflate enabled for the EventHub Namespace?"
  default     = false
}

variable "ehns_sku_name" {
  type        = string
  description = "Defines which tier to use."
  default     = "Standard"
}

variable "ehns_capacity" {
  type        = number
  description = "Specifies the Capacity / Throughput Units for a Standard SKU namespace."
  default     = null
}

variable "ehns_maximum_throughput_units" {
  type        = number
  description = "Specifies the maximum number of throughput units when Auto Inflate is Enabled"
  default     = null
}

variable "ehns_zone_redundant" {
  type        = bool
  description = "Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones)."
  default     = false
}

variable "eventhubs_03" {
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

variable "eventhubs_04" {
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

variable "ehns_alerts_enabled" {
  type        = bool
  default     = false
  description = "Event hub alerts enabled?"
}

variable "ehns_public_network_access" {
  type        = bool
  description = "(Required) enables public network access to the event hubs"
}

variable "ehns_metric_alerts" {
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

variable "is_feature_enabled" {
  type = object({
    vnet_ita                  = bool,
    container_app_tools_cae   = optional(bool, false),
    node_forwarder_ha_enabled = bool
    vpn                       = optional(bool, false)
    dns_forwarder_lb          = optional(bool, false)
    postgres_private_dns      = bool
    azdoa                     = optional(bool, true)
    apim_core_import          = optional(bool, false)
    azdoa_extension           = optional(bool, false)
  })
  description = "Features enabled in this domain"
}


variable "node_forwarder_always_on" {
  type        = bool
  description = "Node Forwarder always on property"
  default     = true
}

variable "node_forwarder_zone_balancing_enabled" {
  type        = bool
  description = "(Optional) enables the load balancing for node forwarder app service plan"
  default     = true
}

variable "node_forwarder_logging_level" {
  type        = string
  description = "Logging level of Node Forwarder"
  default     = "INFO"
}

variable "node_forwarder_autoscale_enabled" {
  type    = bool
  default = true
}

variable "node_forwarder_sku" {
  type        = string
  description = "(Required) The SKU for the plan. Possible values include B1, B2, B3, D1, F1, I1, I2, I3, I1v2, I2v2, I3v2, I4v2, I5v2, I6v2, P1v2, P2v2, P3v2, P0v3, P1v3, P2v3, P3v3, P1mv3, P2mv3, P3mv3, P4mv3, P5mv3, S1, S2, S3, SHARED, EP1, EP2, EP3, WS1, WS2, WS3, and Y1."
  default     = "P3v3"
}

variable "devops_agent_zones" {
  type        = list(number)
  default     = null
  description = "(Optional) List of zones in which the scale set for azdo agent will be deployed"
}

variable "devops_agent_balance_zones" {
  type        = bool
  default     = false
  description = "(Optional) True if the devops agent instances must be evenly balanced between the configured zones"
}

variable "cidr_subnet_azdoa" {
  type        = list(string)
  description = "Azure DevOps agent network address space."
}

variable "cidr_subnet_loadtest_agent" {
  type        = list(string)
  description = "LoadTest Agent Pool address space"
  default     = null
}

variable "azdo_agent_vm_image_name" {
  type        = string
  description = "(Required) Azure devops agent image name"
}

