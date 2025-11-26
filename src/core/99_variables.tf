### Main location
variable "location" {
  type        = string
  description = "Main location"
  default     = "westeurope"
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
  default     = "weu"
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
  description = "Environment shot version"
  validation {
    condition = (
      length(var.env_short) == 1
    )
    error_message = "Max length is 1 chars."
  }
  type = string
}

variable "env" {
  type        = string
  description = "Contains env description in extend format (dev,uat,prod)"
}


#
# Feature Flag
#
variable "enabled_features" {
  type = object({
    vnet_ita          = bool
    node_forwarder_ha = optional(bool, false)
  })
  default = {
    vnet_ita = false
  }
  description = "Features enabled in this domain"
}

variable "nodo_pagamenti_subkey_required" {
  type        = bool
  description = "Enabled subkeys for nodo dei pagamenti api"
  default     = false
}


variable "nodo_pagamenti_auth_password" {
  type        = string
  description = "Default password used for nodo-auth"
  default     = "PLACEHOLDER"
}



# nodo dei pagamenti - auth (nuova connettività)
variable "nodo_auth_subscription_limit" {
  type        = number
  description = "subscriptions limit"
  default     = 1000
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



# apim

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


# Scaling





variable "app_gateway_allowed_paths_pagopa_onprem_only" {
  type = object({
    paths = list(string)
    ips   = list(string)
  })
  description = "Allowed paths from pagopa onprem only"
}


# nodoInviaFlussoRendicontazione
# https://api.<ENV>.platform.pagopa.it/nodo-auth/node-for-psp/v1
# https://api.<ENV>.platform.pagopa.it/nodo-auth/nodo-per-psp/v1
# https://api.<ENV>.platform.pagopa.it/nodo/nodo-per-psp/v1

# nodoChiediFlussoRendicontazione && nodoChiediElencoFlussiRendicontazione
# https://api.<ENV>.platform.pagopa.it/fdr-legacy/v1
# https://api.<ENV>.platform.pagopa.it/nodo/nodo-per-pa/v1
# https://api.<ENV>.platform.pagopa.it/nodo-auth/nodo-per-pa/v1
# https://api.<ENV>.platform.pagopa.it/nodo-auth/node-for-pa/v1


## Database server postgresl


variable "cidr_subnet_postgresql" {
  type        = list(string)
  description = "Address prefixes subnet postgresql"
  default     = null
}


variable "postgres_private_endpoint_enabled" {
  type        = bool
  default     = false
  description = "Private endpoint database enable?"
}

variable "ecommerce_ingress_hostname" {
  type        = string
  description = "ecommerce ingress hostname"
  default     = null
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



# node decoupler
variable "node_decoupler_primitives" {
  type        = string
  description = "Node decoupler primitives"
  default     = "nodoChiediNumeroAvviso,nodoChiediCatalogoServizi,nodoChiediInformativaPA,nodoChiediInformativaPSP,nodoChiediTemplateInformativaPSP,nodoPAChiediInformativaPA,nodoChiediSceltaWISP,demandPaymentNotice"
}

variable "apim_fdr_nodo_pagopa_enable" {
  type        = bool
  default     = false
  description = "Enable Fdr Service Nodo pagoPA side"
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

variable "apim_logger_resource_id" {
  type        = string
  description = "Resource id for the APIM logger"
  default     = null
}

variable "create_wisp_converter" {
  type        = bool
  default     = false
  description = "CREATE WISP dismantling system infra"
}
