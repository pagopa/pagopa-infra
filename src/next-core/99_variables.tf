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

variable "dns_default_ttl_sec" {
  type        = number
  description = "value"
  default     = 3600
}

variable "private_dns_zone_db_nodo_pagamenti" {
  type    = string
  default = "dev.db-nodo-pagamenti.com"
}


# DNS private
variable "dns_a_reconds_dbnodo_ips" {
  type        = list(string)
  description = "IPs address of DB Nodo"
  default     = []
}

variable "dns_a_reconds_dbnodo_ips_dr" {
  type        = list(string)
  description = "IPs address of DB Nodo DR"
  default     = []
}

variable "dns_a_reconds_dbnodonexipostgres_ips" {
  type        = list(string)
  description = "IPs address of DB Nodo PostgreSQL Nexi"
  default     = []
}

variable "dns_a_reconds_dbnodo_prf_ips" {
  type        = list(string)
  description = "IPs address of DB Nodo"
  default     = []
}

variable "dns_a_reconds_dbnodonexipostgres_prf_ips" {
  type        = list(string)
  description = "IPs address of DB Nodo PostgreSQL Nexi"
  default     = []
}

#
# dns forwarder
#
variable "dns_forwarder_vm_image_name" {
  type        = string
  description = "Image name for dns forwarder"
  default     = null
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

variable "redis_private_endpoint_enabled" {
  type        = bool
  description = "Enable private endpoints for redis instances?"
  default     = true
}


variable "storage_queue_private_endpoint_enabled" {
  type        = bool
  description = "Whether private endpoint for Azure Storage Queues is enabled"
  default     = true
}

variable "platform_private_dns_zone_records" {
  type        = list(string)
  default     = ["api", "portal", "management"]
  description = "List of records to add into the platform.pagopa.it dns private"
}

## integration app gateway

variable "integration_app_gateway_sku_name" {
  type        = string
  description = "The Name of the SKU to use for this Application Gateway. Possible values are Standard_Small, Standard_Medium, Standard_Large, Standard_v2, WAF_Medium, WAF_Large, and WAF_v2"
}

variable "integration_app_gateway_sku_tier" {
  type        = string
  description = "The Tier of the SKU to use for this Application Gateway. Possible values are Standard, Standard_v2, WAF and WAF_v2"
}

variable "integration_app_gateway_waf_enabled" {
  type        = bool
  description = "Enable waf"
  default     = false
}

variable "integration_app_gateway_api_certificate_name" {
  type        = string
  description = "Application gateway api certificate name on Key Vault"
}

variable "integration_app_gateway_min_capacity" {
  type    = number
  default = 0
}

variable "integration_app_gateway_max_capacity" {
  type    = number
  default = 2
}

variable "integration_app_gateway_alerts_enabled" {
  type        = bool
  description = "Enable alerts"
  default     = true
}

variable "integration_app_gateway_portal_certificate_name" {
  type        = string
  description = "Application gateway developer portal certificate name on Key Vault"
}

variable "integration_app_gateway_management_certificate_name" {
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

variable "integration_app_gateway_prf_certificate_name" {
  type        = string
  description = "Application gateway api certificate name on Key Vault"
  default     = ""
}

# public app gateway

variable "app_gateway_api_certificate_name" {
  type        = string
  description = "Application gateway api certificate name on Key Vault"
}
variable "app_gateway_upload_certificate_name" {
  type        = string
  description = "Application gateway api certificate name on Key Vault ( 'upload' is used for heavy payload size)"
}

variable "upload_endpoint_enabled" {
  type        = bool
  description = "Enable upload for heavy payload size on appgw"
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

variable "app_gateway_wisp2_certificate_name" {
  type        = string
  description = "Application gateway wisp2 certificate name on Key Vault"
}

variable "app_gateway_wisp2govit_certificate_name" {
  type        = string
  description = "Application gateway wisp2govit certificate name on Key Vault"
}

variable "app_gateway_wfespgovit_certificate_name" {
  type        = string
  description = "Application gateway wfespgovit certificate name on Key Vault"
  default     = ""
}

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
  default     = true
}

variable "app_gateway_alerts_enabled" {
  type        = bool
  description = "Enable alerts"
  default     = true
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

variable "dns_zone_wfesp" {
  type        = string
  default     = null
  description = "The wfesp dns subdomain."
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

variable "eventhubs_prf" {
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

variable "ehns03_alerts_enabled" {
  type        = bool
  default     = false
  description = "Event hub 03 alerts enabled?"
}

variable "ehns04_alerts_enabled" {
  type        = bool
  default     = false
  description = "Event hub 04 alerts enabled?"
}


variable "ehns_public_network_access" {
  type        = bool
  description = "(Required) enables public network access to the event hubs"
}

variable "ehns03_metric_alerts" {
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

variable "ehns04_metric_alerts" {
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
    azdoa                     = optional(bool, true)
    apim_core_import          = optional(bool, false)
    use_new_apim              = optional(bool, false)
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

variable "node_fw_ha_snet_cidr" {
  type        = list(string)
  default     = null
  description = "(Required) node forwarder ha subnet cidr block"
}

variable "node_fw_dbg_snet_cidr" {
  type        = list(string)
  default     = null
  description = "(Required) node forwarder debug ha subnet cidr block"
}

# nat gateway
variable "nat_gateway_enabled" {
  type        = bool
  default     = true
  description = "Nat Gateway enabled"
}

variable "nat_gateway_public_ips" {
  type        = number
  default     = 1
  description = "Number of public outbound ips"
}

variable "ingress_elk_load_balancer_ip" {
  type    = string
  default = "10.1.100.251"
}

variable "cidr_subnet_appgateway" {
  type        = list(string)
  description = "Application gateway address space."
}

variable "app_gateway_min_capacity" {
  type    = number
  default = 0
}

variable "app_gateway_max_capacity" {
  type    = number
  default = 2
}

variable "app_gateway_deny_paths" {
  type        = list(string)
  description = "Deny paths on app gateway"
  default     = []
}

# needs to be less than 512 characters. For more details refer to the documentation here: https://aka.ms/appgwheadercrud."
variable "app_gateway_deny_paths_2" {
  type        = list(string)
  description = "Deny paths on app gateway"
  default     = []
}

variable "app_gateway_allowed_paths_pagopa_onprem_only" {
  type = object({
    paths = list(string)
    ips   = list(string)
  })
  description = "Allowed paths from pagopa onprem only"
}

variable "app_gateway_allowed_fdr_soap_action" {
  type        = list(string)
  description = "Allowed SOAPAction header for upload platform fqdn"
  default     = ["nodoInviaFlussoRendicontazione", "nodoChiediFlussoRendicontazione", "nodoChiediElencoFlussiRendicontazione"]
}

variable "app_gateway_allowed_paths_upload" {
  type        = list(string)
  description = "Allowed paths from pagopa for upload platform fqdn"
  default = [
    "/upload/gpd/.*",
    "/nodo-auth/node-for-psp/.*",
    "/nodo-auth/nodo-per-psp/.*",
    "/nodo/nodo-per-psp/.*",
    "/nodo/nodo-per-pa/.*",
    "/nodo-auth/nodo-per-pa/.*",
    "/nodo-auth/node-for-pa/.*",
    "/nodo/node-for-psp/.*",
  ]
}


variable "cidr_subnet_redis" {
  type        = list(string)
  description = "Redis network address space."
  default     = ["10.1.163.0/24"]
}


variable "cdn_storage_account_replication_type" {
  type        = string
  default     = "GRS"
  description = "(Optional) Cdn storage account replication type"
}


variable "backup_storage_replication_type" {
  type        = string
  default     = "GZRS"
  description = "(Optional) Backup storage account replication type"
}

variable "azuread_service_principal_azure_cdn_frontdoor_id" {
  type        = string
  description = "Azure CDN Front Door Principal ID"
  # this is the deafult value for tenant pagopa.it
  default = "f3b3f72f-4770-47a5-8c1e-aa298003be12"
}


variable "apicfg_core_service_path_value" {
  type        = string
  description = "apicfg core cache path"
  # default     = "pagopa-api-config-core-service/o"
}

variable "apicfg_selfcare_integ_service_path_value" {
  type        = string
  description = "apicfg selfcare integ cache path"
  # default     = "pagopa-api-config-selfcare-integration/o" // at moment blocked to ORA 👀 https://github.com/pagopa/pagopa-api-config-selfcare-integration/pull/36
}


variable "cidr_subnet_eventhub" {
  type        = list(string)
  description = "Address prefixes subnet eventhub"
  default     = null
}


## Monitor
variable "law_sku" {
  type        = string
  description = "Sku of the Log Analytics Workspace"
  default     = "PerGB2018"
}

variable "law_retention_in_days" {
  type        = number
  description = "The workspace data retention in days"
  default     = 30
}

variable "law_daily_quota_gb" {
  type        = number
  description = "The workspace daily quota for ingestion in GB."
  default     = -1
}

variable "cidr_subnet_node_forwarder" {
  type        = list(string)
  description = "Address prefixes subnet node forwarder"
  default     = null
}


variable "monitor_env_test_urls" {
  type = list(object({
    host          = string
    path          = string
    alert_enabled = optional(bool, true)
  }))
  description = "(Optional) Environment specific standard web tests urls to be created in addition to locals.test_urls"
  default     = []
}


variable "cidr_vnet" {
  type        = list(string)
  description = "Virtual network address space."
}

variable "cidr_vnet_integration" {
  type        = list(string)
  description = "Virtual network to peer with sia subscription. It should host apim"
}

# Network
variable "ddos_protection_plan" {
  type = object({
    id     = string
    enable = bool
  })
  default = null
}

variable "cidr_common_private_endpoint_snet" {
  type        = list(string)
  description = "Common Private Endpoint network address space."
}

variable "route_table_peering_sia_additional_routes" {
  type = list(object({
    address_prefix         = string
    name                   = string
    next_hop_in_ip_address = string
    next_hop_type          = string
    }
  ))
  description = "(Optional) additional routes for route table peering sia"
  default     = []
}


variable "cidr_subnet_dns_forwarder" {
  type        = list(string)
  description = "DNS Forwarder network address space."
}

variable "vpn_gw_pip_sku" {
  type        = string
  default     = "Basic"
  description = "VPN GW PIP SKU"
}

variable "vpn_gw_pip_allocation_method" {
  type        = string
  default     = "Dynamic"
  description = "VPN GW PIP ALLOCATION METHOD"
}

variable "vpn_random_specials_char" {
  type        = bool
  default     = true
  description = "Enable random special characters in VPN gateway's pip name"
}


variable "enable_node_forwarder_debug_instance" {
  type        = bool
  default     = false
  description = "Enable the creation of a separate 'debug' instance of node forwarder"
}

variable "route_tools" {
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = string
  }))
  description = "AKS routing table"
}

