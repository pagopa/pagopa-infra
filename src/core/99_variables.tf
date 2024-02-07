locals {
  managed_identity_rg_name = "pagopa-${var.env_short}-identity-rg"

  azdo_app_managed_identity_name    = "${var.env}-pagopa"
  azdo_app_managed_identity_rg_name = "pagopa-${var.env_short}-identity-rg"

  azdo_iac_plan_managed_identity_name   = "azdo-${var.env}-pagopa-iac-plan"
  azdo_iac_deploy_managed_identity_name = "azdo-${var.env}-pagopa-iac-deploy"
}


variable "location" {
  type        = string
  description = "One of westeurope, northeurope"
  default     = "westeurope"
}

variable "prefix" {
  type    = string
  default = "pagopa"
  validation {
    condition = (
      length(var.prefix) <= 6
    )
    error_message = "Max length is 6 chars."
  }
}

variable "env_short" {
  type = string
}

variable "env" {
  type        = string
  description = "Contains env description in extend format (dev,uat,prod)"
}

variable "lock_enable" {
  type        = bool
  default     = false
  description = "Apply locks to block accidentally deletions."
}

# Azure DevOps
variable "azdo_sp_tls_cert_enabled" {
  type        = string
  description = "Enable Azure DevOps connection for TLS cert management"
  default     = false
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
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

# Nodo dei Pagamenti

variable "nodo_pagamenti_enabled" {
  type        = bool
  description = "nodo pagamenti enabled"
  default     = false
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

variable "nodo_pagamenti_subkey_required" {
  type        = bool
  description = "Enabled subkeys for nodo dei pagamenti api"
  default     = false
}

variable "schema_ip_nexi" {
  type        = string
  description = "Nodo Pagamenti Nexi schema://ip"
}

variable "base_path_nodo_postgresql_nexi_onprem" {
  type        = string
  description = "base nodo postgresql Nexi on prem"
}


# 1. PPT LMI
# 2. SYNC
# 3. WFESP
# 4. Fatturazione
# 5. Web-BO
# 6. Web-BO History

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
variable "nodo_pagamenti_auth_password" {
  type        = string
  description = "Default password used for nodo-auth"
  default     = "PLACEHOLDER"
}
variable "nodo_pagamenti_x_forwarded_for" {
  type        = string
  description = "X-Forwarded-For IP address used for nodo-auth"
}


# nodo dei pagamenti - test
variable "nodo_pagamenti_test_enabled" {
  type        = bool
  description = "test del nodo dei pagamenti enabled"
  default     = false
}

# nodo dei pagamenti - auth (nuova connettività)
variable "nodo_auth_subscription_limit" {
  type        = number
  description = "subscriptions limit"
  default     = 1000
}

# Network
variable "ddos_protection_plan" {
  type = object({
    id     = string
    enable = bool
  })
  default = null
}

variable "cidr_vnet" {
  type        = list(string)
  description = "Virtual network address space."
}

variable "cidr_vnet_integration" {
  type        = list(string)
  description = "Virtual network to peer with sia subscription. It should host apim"
}

variable "cidr_subnet_apim" {
  type        = list(string)
  description = "Address prefixes subnet api management."
  default     = null
}

variable "cidr_subnet_appgateway" {
  type        = list(string)
  description = "Application gateway address space."
}

variable "cidr_subnet_loadtest_agent" {
  type        = list(string)
  description = "LoadTest Agent Pool address space"
  default     = null
}

# nat gateway
variable "nat_gateway_enabled" {
  type        = bool
  default     = false
  description = "Nat Gateway enabled"
}

variable "nat_gateway_public_ips" {
  type        = number
  default     = 1
  description = "Number of public outbound ips"
}

# DNS
variable "dns_default_ttl_sec" {
  type        = number
  description = "value"
  default     = 3600
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

variable "dns_zone_prefix_prf" {
  type        = string
  default     = "" # null
  description = "The dns subdomain."
}

variable "dns_zone_checkout" {
  type        = string
  default     = null
  description = "The checkout dns subdomain."
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

# vpn

variable "cidr_subnet_vpn" {
  type        = list(string)
  description = "VPN network address space."
}

variable "vpn_sku" {
  type        = string
  default     = "VpnGw1"
  description = "VPN Gateway SKU"
}

variable "vpn_pip_sku" {
  type        = string
  default     = "Basic"
  description = "VPN GW PIP SKU"
}

variable "cidr_subnet_dns_forwarder" {
  type        = list(string)
  description = "DNS Forwarder network address space."
}

variable "cidr_common_private_endpoint_snet" {
  type        = list(string)
  description = "Common Private Endpoint network address space."
}

# apim
variable "apim_publisher_name" {
  type = string
}

variable "apim_sku" {
  type = string
}

variable "apim_autoscale" {
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

variable "apim_alerts_enabled" {
  type        = bool
  description = "Enable alerts"
  default     = true
}

variable "apim_nodo_decoupler_enable" {
  type        = bool
  default     = false
  description = "Apply decoupler to nodo product apim policy"
}

variable "apim_nodo_auth_decoupler_enable" {
  type        = bool
  default     = false
  description = "Apply decoupler to nodo-auth product apim policy"
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
variable "default_node_id" {
  type        = string
  description = "Default NodeId according to default base url"
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

variable "redis_cache_enabled" {
  type        = bool
  description = "redis cache enabled"
  default     = false
}

variable "cidr_subnet_redis" {
  type        = list(string)
  description = "Redis network address space."
  default     = ["10.1.162.0/24"]
}

variable "redis_private_endpoint_enabled" {
  type        = bool
  description = "Enable private endpoints for redis instances?"
  default     = true
}

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
  default     = false
}

variable "app_gateway_prf_certificate_name" {
  type        = string
  description = "Application gateway api certificate name on Key Vault"
  default     = ""
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
}
variable "app_gateway_kibana_certificate_name" {
  type        = string
  description = "Application gateway api certificate name on Key Vault"
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
# Scaling

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

variable "app_gateway_kibana_deny_paths" {
  type        = list(string)
  description = "Deny paths on app gateway kibana"
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

# nodoInviaFlussoRendicontazione
# https://api.<ENV>.platform.pagopa.it/nodo-auth/node-for-psp/v1
# https://api.<ENV>.platform.pagopa.it/nodo-auth/nodo-per-psp/v1
# https://api.<ENV>.platform.pagopa.it/nodo/nodo-per-psp/v1

# nodoChiediFlussoRendicontazione && nodoChiediElencoFlussiRendicontazione
# https://api.<ENV>.platform.pagopa.it/fdr-legacy/nodo-per-pa/v1
# https://api.<ENV>.platform.pagopa.it/nodo/nodo-per-pa/v1
# https://api.<ENV>.platform.pagopa.it/nodo-auth/nodo-per-pa/v1
# https://api.<ENV>.platform.pagopa.it/nodo-auth/node-for-pa/v1

variable "app_gateway_allowed_paths_upload" {
  type        = list(string)
  description = "Allowed paths from pagopa for upload platform fqdn"
  default = [
    "/upload/gpd/.*",
    "/nodo-auth/node-for-psp/.*",
    "/nodo-auth/nodo-per-psp/.*",
    "/nodo/nodo-per-psp/.*",
    "/fdr-legacy/nodo-per-pa/.*",
    "/nodo/nodo-per-pa/.*",
    "/nodo-auth/nodo-per-pa/.*",
    "/nodo-auth/node-for-pa/.*",
  "/nodo/node-for-psp/.*"]
}

# Azure DevOps Agent
variable "enable_azdoa" {
  type        = bool
  description = "Enable Azure DevOps agent."
}

variable "cidr_subnet_azdoa" {
  type        = list(string)
  description = "Azure DevOps agent network address space."
}

variable "enable_iac_pipeline" {
  type        = bool
  description = "If true create the key vault policy to allow used by azure devops iac pipelines."
  default     = false
}

## Database server postgresl
variable "postgresql_sku_name" {
  type        = string
  description = "Specifies the SKU Name for this PostgreSQL Server."
}

variable "postgresql_geo_redundant_backup_enabled" {
  type        = bool
  default     = false
  description = "Turn Geo-redundant server backups on/off."
}

variable "postgresql_enable_replica" {
  type        = bool
  default     = false
  description = "Create a PostgreSQL Server Replica."
}

variable "postgresql_storage_mb" {
  type        = number
  description = "Max storage allowed for a server"
  default     = 5120
}

variable "postgresql_configuration" {
  type        = map(string)
  description = "PostgreSQL Server configuration"
  default     = {}
}

variable "postgresql_alerts_enabled" {
  type        = bool
  default     = false
  description = "Database alerts enabled?"
}

variable "cidr_subnet_postgresql" {
  type        = list(string)
  description = "Address prefixes subnet postgresql"
  default     = null
}

variable "postgresql_public_network_access_enabled" {
  type        = bool
  default     = false
  description = "database public"
}

variable "postgres_private_endpoint_enabled" {
  type        = bool
  default     = false
  description = "Private endpoint database enable?"
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
variable "postgresql_name" {
  type    = string
  default = null
}

variable "postgresql_connection_limit" {
  type    = number
  default = -1 //no limit
}

variable "prostgresql_db_mockpsp" {
  type    = string
  default = null
}

# eventhub
variable "eventhub_enabled" {
  type        = bool
  default     = false
  description = "eventhub enable?"
}

variable "cidr_subnet_eventhub" {
  type        = list(string)
  description = "Address prefixes subnet eventhub"
  default     = null
}

variable "ehns_sku_name" {
  type        = string
  description = "Defines which tier to use."
  default     = "Basic"
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
// checkout
variable "checkout_enabled" {
  type    = bool
  default = false
}

variable "allow_blob_public_access" {
  description = "Allow or disallow public access to all blobs or containers in the storage account."
  type        = bool
  default     = false
}

variable "azuread_service_principal_azure_cdn_frontdoor_id" {
  type        = string
  description = "Azure CDN Front Door Principal ID"
  # this is the deafult value for tenant pagopa.it
  default = "f3b3f72f-4770-47a5-8c1e-aa298003be12"
}

variable "cidr_subnet_checkout_be" {
  type        = list(string)
  description = "Address prefixes subnet checkout function"
  default     = null
}

variable "checkout_function_kind" {
  type        = string
  description = "App service plan kind"
  default     = null
}

variable "checkout_function_sku_tier" {
  type        = string
  description = "App service plan sku tier"
  default     = null
}

variable "checkout_function_sku_size" {
  type        = string
  description = "App service plan sku size"
  default     = null
}

variable "checkout_function_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "checkout_function_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 3
}

variable "checkout_function_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 1
}

variable "checkout_function_always_on" {
  type        = bool
  description = "Always on property"
  default     = false
}

variable "checkout_pagopaproxy_host" {
  type        = string
  description = "pagopaproxy host"
  default     = null
}

variable "ecommerce_ingress_hostname" {
  type        = string
  description = "ecommerce ingress hostname"
  default     = null
}

variable "ecommerce_xpay_psps_list" {
  type        = string
  description = "psps list using xpay as comma separated value"
  default     = ""
}

variable "ecommerce_vpos_psps_list" {
  type        = string
  description = "psps list using vpos as comma separated value"
  default     = ""
}

variable "ehns_auto_inflate_enabled" {
  type        = bool
  description = "Is Auto Inflate enabled for the EventHub Namespace?"
  default     = false
}

variable "ehns_zone_redundant" {
  type        = bool
  description = "Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones)."
  default     = false
}

variable "eventhubs" {
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

variable "eventhubs_02" {
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
  default     = true
  description = "Event hub alerts enabled?"
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

# acr

variable "acr_enabled" {
  type        = bool
  description = "Container registry enabled"
  default     = false
}


# DNS private
variable "dns_a_reconds_dbnodo_ips" {
  type        = list(string)
  description = "IPs address of DB Nodo"
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

variable "private_dns_zone_db_nodo_pagamenti" {
  type    = string
  default = "dev.db-nodo-pagamenti.com"
}

variable "cidr_subnet_buyerbanks" {
  type        = list(string)
  description = "Address prefixes subnet buyerbanks"
  default     = null
}
variable "buyerbanks_function_always_on" {
  type        = bool
  description = "Always on property"
  default     = false
}

variable "buyerbanks_function_kind" {
  type        = string
  description = "App service plan kind"
  default     = null
}

variable "buyerbanks_function_sku_tier" {
  type        = string
  description = "App service plan sku tier"
  default     = null
}

variable "buyerbanks_function_sku_size" {
  type        = string
  description = "App service plan sku size"
  default     = null
}

variable "buyerbanks_function_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "buyerbanks_function_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 3
}

variable "buyerbanks_function_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 1
}

variable "buyerbanks_enable_versioning" {
  type        = bool
  description = "Enable buyerbanks sa versioning"
  default     = false
}

variable "buyerbanks_advanced_threat_protection" {
  type        = bool
  description = "Enable contract threat advanced protection"
  default     = false
}

variable "buyerbanks_delete_retention_days" {
  type        = number
  description = "Number of days to retain deleted buyerbanks."
  default     = 30
}

variable "cidr_subnet_pagopa_proxy" {
  type        = list(string)
  description = "Address prefixes subnet proxy"
  default     = null
}

variable "cidr_subnet_pagopa_proxy_redis" {
  type        = list(string)
  description = "Address prefixes subnet redis for pagopa proxy"
  default     = null
}

variable "pagopa_proxy_redis_capacity" {
  type    = number
  default = 1
}

variable "pagopa_proxy_redis_sku_name" {
  type    = string
  default = null
}

variable "pagopa_proxy_redis_family" {
  type    = string
  default = "C"
}

variable "pagopa_proxy_tier" {
  type        = string
  description = "pagopa-proxy Plan tier"
  default     = null
}

variable "pagopa_proxy_size" {
  type        = string
  description = "pagopa-proxy Plan size"
  default     = null
}

variable "pagopa_proxy_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "pagopa_proxy_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 10
}

variable "pagopa_proxy_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 5
}

variable "nodo_ip_filter" {
  type        = string
  description = "IP Node"
  default     = ""
}

variable "io_bpd_hostname" {
  type        = string
  description = "IO BPD hostname"
  default     = ""
}

variable "xpay_hostname" {
  type        = string
  description = "Nexi xpay hostname"
  default     = ""
}

variable "paytipper_hostname" {
  type        = string
  description = "Paytipper hostname"
  default     = ""
}

variable "bpd_hostname" {
  type        = string
  description = "BPD hostname"
  default     = ""
}

variable "cobadge_hostname" {
  type        = string
  description = "Cobadge hostname"
  default     = ""
}

variable "satispay_hostname" {
  type        = string
  description = "Satispay hostname"
  default     = ""
}

variable "fesp_hostname" {
  type        = string
  description = "Fesp hostname"
  default     = ""
}

variable "cstar_outbound_ip_1" {
  type        = string
  description = "CSTAR ip 1"
}

variable "cstar_outbound_ip_2" {
  type        = string
  description = "CSTAR ip 2"
}

# fdr
variable "fdr_enable_versioning" {
  type        = bool
  description = "Enable sa versioning"
  default     = false
}

variable "fdr_advanced_threat_protection" {
  type        = bool
  description = "Enable contract threat advanced protection"
  default     = false
}

variable "fdr_delete_retention_days" {
  type        = number
  description = "Number of days to retain deleted."
  default     = 30
}

variable "reporting_fdr_function_kind" {
  type        = string
  description = "App service plan kind"
  default     = null
}

variable "reporting_fdr_function_sku_tier" {
  type        = string
  description = "App service plan sku tier"
  default     = null
}

variable "reporting_fdr_function_sku_size" {
  type        = string
  description = "App service plan sku size"
  default     = null
}

variable "cidr_subnet_reporting_fdr" {
  type        = list(string)
  description = "Address prefixes subnet reporting_fdr function"
  default     = null
}

variable "reporting_fdr_function_always_on" {
  type        = bool
  description = "Always on property"
  default     = false
}

variable "reporting_fdr_function_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "reporting_fdr_function_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 3
}

variable "reporting_fdr_function_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 1
}

variable "reporting_fdr_blobs_retention_days" {
  type        = number
  description = "The number of day for storage_management_policy"
  default     = 30
}

variable "reporting_fdr_storage_account_info" {
  type = object({
    account_tier                      = string
    account_replication_type          = string
    access_tier                       = string
    advanced_threat_protection_enable = bool
  })

  default = {
    account_tier                      = "Standard"
    account_replication_type          = "ZRS"
    access_tier                       = "Hot"
    advanced_threat_protection_enable = true
  }
}

#  gestione posizioni debitorie
variable "gpd_plan_kind" {
  type        = string
  description = "App service plan kind"
  default     = null
}

variable "gpd_plan_sku_tier" {
  type        = string
  description = "App service plan sku tier"
  default     = null
}

variable "gpd_plan_sku_size" {
  type        = string
  description = "App service plan sku size"
  default     = null
}

# variable "cidr_subnet_reporting_common" {
#   type        = list(string)
#   description = "Address prefixes subnet reporting_common function"
#   default     = null
# }


variable "gpd_always_on" {
  type        = bool
  description = "Always on property"
  default     = true
}

variable "cidr_subnet_gpd" {
  type        = list(string)
  description = "Address prefixes subnet gpd service"
  default     = null
}

variable "gpd_cron_job_enable" {
  type        = bool
  description = "GPD cron job enable"
  default     = false
}

variable "gpd_cron_schedule_valid_to" {
  type        = string
  description = "GPD cron scheduling (NCRON example '*/35 * * * * *')"
  default     = null
}

variable "gpd_cron_schedule_expired_to" {
  type        = string
  description = "GDP cron scheduling (NCRON example '*/55 * * * * *')"
  default     = null
}

variable "gpd_max_retry_queuing" {
  type        = number
  description = "Max retry queuing when the node calling fails."
  default     = 5
}

variable "gpd_queue_retention_sec" {
  type        = number
  description = "The maximum time to allow the message to be in the queue."
  default     = 86400
}

variable "gpd_queue_delay_sec" {
  type        = number
  description = "The length of time during which the message will be invisible, starting when it is added to the queue."
  default     = 3600
}

variable "gpd_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "gpd_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 3
}

variable "gpd_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 1
}

// GPD Payments

# variable "cidr_subnet_payments" {
#   type        = list(string)
#   description = "Address prefixes subnet payments service"
#   default     = null
# }

variable "payments_always_on" {
  type        = bool
  description = "Always on property"
  default     = true
}

variable "payments_logging_level" {
  type        = string
  description = "Log level of Payments"
  default     = "INFO"
}

variable "gpd_paa_id_intermediario" {
  type        = string
  description = "PagoPA Broker ID"
  default     = false
}

variable "gpd_paa_stazione_int" {
  type        = string
  description = "PagoPA Station ID"
  default     = false
}

variable "gpd_payments_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 3
}

variable "gpd_payments_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 10
}

variable "gpd_payments_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 5
}

variable "gpd_payments_advanced_threat_protection" {
  type        = bool
  description = "Enable contract threat advanced protection"
  default     = false
}

variable "gpd_payments_delete_retention_days" {
  type        = number
  description = "Number of days to retain deleted."
  default     = 30
}

variable "gpd_payments_versioning" {
  type        = bool
  description = "Enable sa versioning"
  default     = false
}

# canone unico
variable "canoneunico_plan_kind" {
  type        = string
  description = "App service plan kind"
  default     = "Linux"
}

variable "canoneunico_plan_sku_tier" {
  type        = string
  description = "App service plan sku tier"
  default     = null
}

variable "canoneunico_plan_sku_size" {
  type        = string
  description = "App service plan sku size"
  default     = null
}

variable "canoneunico_batch_size_debt_pos_queue" {
  type        = number
  description = "Batch size Debt Position queue"
  default     = 25
}

variable "canoneunico_batch_size_debt_pos_table" {
  type        = number
  description = "Batch size Debt Position table"
  default     = 25
}

variable "cidr_subnet_canoneunico_common" {
  type        = list(string)
  description = "Address prefixes subnet canoneunico_common function"
  default     = null
}
variable "canoneunico_function_always_on" {
  type        = bool
  description = "Always on property"
  default     = false
}

variable "canoneunico_enable_versioning" {
  type        = bool
  description = "Enable sa versioning"
  default     = false
}

variable "canoneunico_advanced_threat_protection" {
  type        = bool
  description = "Enable contract threat advanced protection"
  default     = false
}

variable "canoneunico_delete_retention_days" {
  type        = number
  description = "Number of days to retain deleted."
  default     = 30
}

variable "canoneunico_schedule_batch" {
  type        = string
  description = "Cron scheduling (NCRON) default : every hour"
  default     = "0 0 */1 * * *"
}

variable "canoneunico_function_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "canoneunico_function_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 3
}

variable "canoneunico_function_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 1
}

variable "canoneunico_queue_message_delay" {
  type        = number
  description = "Queue message delay"
  default     = 120 // in seconds = 2 minutes
}

// gpd Database

variable "gpd_db_name" {
  type        = string
  description = "Name of the DB to connect to"
  default     = "apd"
}

variable "gpd_schema_name" {
  type        = string
  description = "Name of the schema of the DB"
  default     = "apd"
}

variable "gpd_dbms_port" {
  type        = number
  description = "Port number of the DBMS"
  default     = 5432
}


variable "psql_username" {
  type    = string
  default = null
}

variable "psql_password" {
  type    = string
  default = null
}

variable "users" {
  description = "List of psql users with grants."
  type = list(object({
    name = string
    grants = list(object({
      object_type = string
      database    = string
      schema      = string
      privileges  = list(string)
    }))
  }))
  default = []
}

# Postgres Flexible
variable "pgres_flex_params" {
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
variable "cidr_subnet_pg_flex_dbms" {
  type        = list(string)
  description = "Postgres Flexible Server network address space."
}

# ####################
# CosmosDb
# ####################

# ####################
# Afm account ########
variable "advanced_fees_management_tier" {
  type        = string
  description = "advanced fees management plan tier"
  default     = "Standard"
}

variable "advanced_fees_management_size" {
  type        = string
  description = "advanced fees management plan size"
  default     = "S1"
}

variable "cidr_subnet_advanced_fees_management" {
  type        = list(string)
  description = "Cosmos DB address space."
}

variable "afm_marketplace_cname_record_name" {
  type        = string
  description = "DNS canonical name"
  default     = "marketplace"
}

# ####################
# Payments account ###
variable "cidr_subnet_cosmosdb_paymentsdb" {
  type        = list(string)
  description = "Cosmos DB address space."
}

variable "cosmos_document_db_params" {
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

# Logic App pagopa biz event

variable "logic_app_biz_evt_plan_kind" {
  type        = string
  description = "App service plan kind"
  default     = "Linux"
}

variable "logic_app_biz_evt_plan_sku_tier" {
  type        = string
  description = "App service plan sku tier"
  default     = "WorkflowStandard"
}

variable "logic_app_biz_evt_plan_sku_size" {
  type        = string
  description = "App service plan sku size"
  default     = "WS1"
}

variable "cidr_subnet_logicapp_biz_evt" {
  type        = list(string)
  description = "Address prefixes subnet logic app"
  default     = null
}

variable "storage_queue_private_endpoint_enabled" {
  type        = bool
  description = "Whether private endpoint for Azure Storage Queues is enabled"
  default     = false
}

variable "platform_private_dns_zone_records" {
  type        = list(string)
  default     = null
  description = "List of records to add into the platform.pagopa.it dns private"
}

# node forwarder

variable "cidr_subnet_node_forwarder" {
  type        = list(string)
  description = "Address prefixes subnet node forwarder"
  default     = null
}

variable "node_forwarder_tier" {
  type        = string
  description = "Node Forwarder plan tier"
  default     = "Basic"
}

variable "node_forwarder_size" {
  type        = string
  description = "Node Forwarder plan size"
  default     = "B1"
}

variable "node_forwarder_always_on" {
  type        = bool
  description = "Node Forwarder always on property"
  default     = true
}

variable "node_forwarder_logging_level" {
  type        = string
  description = "Logging level of Node Forwarder"
  default     = "INFO"
}

variable "ingress_elk_load_balancer_ip" {
  type    = string
  default = ""
}

variable "node_forwarder_autoscale_enabled" {
  type    = bool
  default = true

}

variable "github_runner" {
  type = object({
    subnet_address_prefixes = list(string)
  })
  description = "GitHub runner variables"
  default = {
    subnet_address_prefixes = ["10.1.200.0/23"]
  }
}

# node decoupler
variable "node_decoupler_primitives" {
  type        = string
  description = "Node decoupler primitives"
  default     = "nodoChiediNumeroAvviso,nodoChiediCatalogoServizi,nodoAttivaRPT,nodoVerificaRPT,nodoChiediInformativaPA,nodoChiediInformativaPSP,nodoChiediTemplateInformativaPSP,nodoPAChiediInformativaPA,nodoChiediSceltaWISP,demandPaymentNotice"
}

variable "apim_fdr_nodo_pagopa_enable" {
  type        = bool
  default     = false
  description = "Enable Fdr Service Nodo pagoPA side"
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


variable "logic_app_storage_account_replication_type" {
  type        = string
  default     = "LRS"
  description = "(Optional) Storage account replication type used for function apps"
}


variable "function_app_storage_account_info" {
  type = object({
    account_kind                      = optional(string, "StorageV2")
    account_tier                      = optional(string, "Standard")
    account_replication_type          = optional(string, "LRS")
    access_tier                       = optional(string, "Hot")
    advanced_threat_protection_enable = optional(bool, true)
  })

  default = {
    account_kind                      = "StorageV2"
    account_tier                      = "Standard"
    account_replication_type          = "LRS"
    access_tier                       = "Hot"
    advanced_threat_protection_enable = true
  }
}

variable "buyer_banks_storage_account_replication_type" {
  type        = string
  default     = "LRS"
  description = "(Optional) Buyer banks storage account replication type"
}

variable "cdn_storage_account_replication_type" {
  type        = string
  default     = "GRS"
  description = "(Optional) Cdn storage account replication type"
}

variable "backup_storage_replication_type" {
  type        = string
  default     = "GRS"
  description = "(Optional) Backup storage account replication type"
}

variable "fdr_flow_sa_replication_type" {
  type        = string
  default     = "LRS"
  description = "(Optional) Fdr flow storage account replication type"
}
