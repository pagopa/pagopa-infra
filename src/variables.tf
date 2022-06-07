variable "location" {
  type    = string
  default = "westeurope"
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

# mock_ec

variable "mock_ec_enabled" {
  type        = bool
  description = "Mock EC enabled"
  default     = false
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

variable "cidr_subnet_mock_ec" {
  type        = list(string)
  description = "Address prefixes subnet mock ec"
  default     = null
}

# mock_ec

variable "mock_psp_enabled" {
  type        = bool
  description = "Mock PSP enabled"
  default     = false
}

variable "mock_psp_always_on" {
  type        = bool
  description = "Mock PSP always on property"
  default     = false
}

variable "mock_psp_tier" {
  type        = string
  description = "Mock PSP Plan tier"
  default     = "Standard"
}

variable "mock_psp_size" {
  type        = string
  description = "Mock PSP Plan size"
  default     = "S1"
}

variable "cidr_subnet_mock_psp" {
  type        = list(string)
  description = "Address prefixes subnet mock psp"
  default     = null
}

# api_config

variable "cidr_subnet_api_config" {
  type        = list(string)
  description = "Address prefixes subnet api config"
  default     = null
}

variable "api_config_tier" {
  type        = string
  description = "Api config Plan tier"
  default     = "Standard"
}

variable "api_config_size" {
  type        = string
  description = "Api Config Plan size"
  default     = "S1"
}

variable "api_config_always_on" {
  type        = bool
  description = "Api Config always on property"
  default     = true
}

variable "db_port" {
  type        = number
  description = "Port number of the DB"
  default     = 1521
}

variable "db_service_name" {
  type        = string
  description = "Service Name of DB"
  default     = null
}

variable "apiconfig_logging_level" {
  type        = string
  description = "Logging level of Api Config"
  default     = "INFO"
}

variable "xsd_ica" {
  type        = string
  description = "XML Schema of Informatica Conto Accredito"
}

variable "xsd_counterpart" {
  type        = string
  description = "XML Schema of Tabelle delle Controparti"
  default     = "https://raw.githubusercontent.com/pagopa/pagopa-api/master/general/TabellaDelleControparti_1_0_8.xsd"
}

variable "xsd_cdi" {
  type        = string
  description = "XML Schema of Catalogo Dati Informativi"
  default     = "https://raw.githubusercontent.com/pagopa/pagopa-api/master/general/CatalogoDatiInformativiPSP.xsd"
}


# api_config_fe
variable "api_config_fe_enabled" {
  type        = bool
  description = "Api Config FE enabled"
  default     = false
}

variable "cname_record_name" {
  type = string
}

# nodo dei pagamenti

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

variable "ip_nodo" {
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
  default     = "/nodo-sit"
}

variable "base_path_nodo_ppt_lmi" {
  type        = string
  description = "base nodo on cloud"
  default     = "/ppt-lmi-sit/"
}

variable "base_path_nodo_sync" {
  type        = string
  description = "base nodo on cloud"
  default     = "/sync-cron-sit/syncWisp"
}

variable "base_path_nodo_wfesp" {
  type        = string
  description = "base nodo on cloud"
  default     = "/wfesp-sit"
}

variable "base_path_nodo_fatturazione" {
  type        = string
  description = "base nodo on cloud"
  default     = "/fatturazione-sit"
}

variable "base_path_nodo_web_bo" {
  type        = string
  description = "base nodo on cloud"
  default     = "/web-bo-sit"
}


# nodo dei pagamenti - test
variable "nodo_pagamenti_test_enabled" {
  type        = bool
  description = "test del nodo dei pagamenti enabled"
  default     = false
}

# Network
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

variable "dns_zone_checkout" {
  type        = string
  default     = null
  description = "The checkout dns subdomain."
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

## Redis cache

variable "redis_cache_enabled" {
  type        = bool
  description = "redis cache enabled"
  default     = false
}

variable "redis_capacity" {
  type    = number
  default = 1
}

variable "redis_sku_name" {
  type    = string
  default = "Standard"
}

variable "redis_family" {
  type    = string
  default = "C"
}
variable "cidr_subnet_redis" {
  type        = list(string)
  description = "Redis network address space."
  default     = []
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

variable "app_gateway_portal_certificate_name" {
  type        = string
  description = "Application gateway developer portal certificate name on Key Vault"
}

variable "app_gateway_management_certificate_name" {
  type        = string
  description = "Application gateway api management certificate name on Key Vault"
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

variable "cidr_subnet_reporting_common" {
  type        = list(string)
  description = "Address prefixes subnet reporting_common function"
  default     = null
}

variable "reporting_function_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "reporting_function_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 10
}

variable "reporting_function_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 5
}

variable "reporting_batch_function_always_on" {
  type        = bool
  description = "Always on property"
  default     = false
}

variable "reporting_service_function_always_on" {
  type        = bool
  description = "Always on property"
  default     = false
}

variable "reporting_analysis_function_always_on" {
  type        = bool
  description = "Always on property"
  default     = false
}

variable "gpd_reporting_advanced_threat_protection" {
  type        = bool
  description = "Enable contract threat advanced protection"
  default     = false
}

variable "gpd_reporting_delete_retention_days" {
  type        = number
  description = "Number of days to retain deleted."
  default     = 30
}

variable "gpd_enable_versioning" {
  type        = bool
  description = "Enable sa versioning"
  default     = false
}

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

variable "gpd_reporting_schedule_batch" {
  type        = string
  description = "Cron scheduling (NCRON example '*/45 * * * * *')"
  default     = "0 0 1 * * *"
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
  default     = 3
}

variable "gpd_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 10
}

variable "gpd_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 3
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

# advanced fees management
variable "cidr_subnet_advanced_fees_management" {
  type        = list(string)
  description = "Address prefixes subnet for advanced fees management"
  default     = null
}

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

variable "advanced_fees_management_cosmosdb_extra_capabilities" {
  type        = list(string)
  default     = []
  description = "Enable cosmosdb extra capabilities"
}

variable "advanced_fees_management_cosmosdb_public_network_access_enabled" {
  type        = bool
  default     = false
  description = "Enable public access for afm-cosmosdb"
}


# CosmosDb 
variable "cidr_subnet_cosmosdb_paymentsdb" {
  type        = list(string)
  description = "Cosmos DB address space."
}

variable "cosmosdb_paymentsdb_offer_type" {
  type        = string
  description = "Specifies the Offer Type to use for this CosmosDB Account - currently this can only be set to Standard"
  default     = "Standard"
}

variable "cosmosdb_paymentsdb_enable_free_tier" {
  type        = bool
  description = "Enable Free Tier pricing option for this Cosmos DB account"
  default     = true
}

variable "cosmosdb_paymentsdb_public_network_access_enabled" {
  type        = bool
  description = "Whether or not public network access is allowed for this CosmosDB account"
  default     = false
}

variable "cosmosdb_paymentsdb_consistency_policy" {
  type = object({
    consistency_level       = string
    max_interval_in_seconds = number
    max_staleness_prefix    = number
  })

  default = {
    consistency_level       = "Session"
    max_interval_in_seconds = null
    max_staleness_prefix    = null
  }
}

variable "cosmosdb_paymentsdb_main_geo_location_zone_redundant" {
  type        = bool
  description = "Enable zone redundant Comsmos DB"
}

variable "cosmosdb_paymentsdb_additional_geo_locations" {
  type = list(object({
    location          = string
    failover_priority = number
    zone_redundant    = bool
  }))
  description = "The name of the Azure region to host replicated data and the priority to apply starting from 1. Not used when cosmosdb_paymentsdb_enable_serverless"
  default     = []
}

variable "cosmosdb_paymentsdb_throughput" {
  type        = number
  description = "The throughput of the DocumentDB database (RU/s). Must be set in increments of 100. The minimum value is 400. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply."
  default     = 400
}

variable "cosmosdb_paymentsdb_enable_autoscaling" {
  type        = bool
  description = "It will enable autoscaling mode. If true, cosmosdb_paymentsdb_throughput must be unset"
  default     = false
}

variable "cosmosdb_paymentsdb_max_throughput" {
  type        = number
  description = "The maximum throughput of the DocumentDB database (RU/s). Must be between 4,000 and 1,000,000. Must be set in increments of 1,000. Conflicts with throughput"
  default     = 4000
}

variable "cosmosdb_paymentsdb_extra_capabilities" {
  type        = list(string)
  default     = []
  description = "Enable cosmosdb extra capabilities"
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