variable "location" {
  type    = string
  default = "westeurope"
}

variable "prefix" {
  type    = string
  default = "pagopa"
}

variable "env_short" {
  type = string
}

variable "lock_enable" {
  type        = bool
  default     = false
  description = "Apply locks to block accedentaly deletions."
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

variable "api_config_enabled" {
  type        = bool
  description = "Api Config enabled"
  default     = false
}

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

# apim
variable "apim_publisher_name" {
  type = string
}

variable "apim_sku" {
  type = string
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

# Scaling

variable "app_gateway_min_capacity" {
  type    = number
  default = 0
}

variable "app_gateway_max_capacity" {
  type    = number
  default = 2
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

variable "prostgresql_enabled" {
  type        = bool
  default     = false
  description = "Mock postegres database enable?"
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

variable "postgresql_schema" {
  type    = string
  default = null
}

variable "postgresql_db_mockpsp" {
  type    = string
  default = null
}
