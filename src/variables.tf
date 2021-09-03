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

variable "mock_ec_enabled" {
  type        = bool
  description = "Mock EC enabled"
  default     = true
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

variable "mockec_ssl_certificate_name" {
  type        = string
  description = "Certificate name on Key Vault"
  default     = "mock-ec-ssl-certificate-name"
}

variable "apim_publisher_name" {
  type = string
}

variable "apim_sku" {
  type = string
}

variable "lock_enable" {
  type        = bool
  default     = false
  description = "Apply locks to block accedentaly deletions."
}

# Network
variable "cidr_vnet" {
  type        = list(string)
  description = "Virtual network address space."
}


variable "cidr_vnet_app" {
  type        = list(string)
  description = "Virtual network address space."
}


variable "cidr_integration_vnet" {
  type        = list(string)
  description = "Virtual network to peer with sia subscription. It should host apim and event hub."
}

variable "cidr_subnet_apim" {
  type        = list(string)
  description = "Address prefixes subnet api management."
  default     = null
}

variable "cidr_subnet_appservice" {
  type        = list(string)
  description = "Address prefixes subnet app service."
  default     = null
}

variable "cidr_subnet_redis" {
  type        = list(string)
  description = "Redis network address space."
  default     = []
}

variable "apim_notification_sender_email" {
  type = string
}
## Redis cache
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

variable "address_prefixes" {
  type        = list(string)
  description = "The address prefixes to use for the subnet."
  default     = []
}