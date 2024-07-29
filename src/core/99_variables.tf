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


variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
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


variable "lb_aks" {
  type        = string
  description = "IP load balancer AKS Nexi/SIA"
  default     = "0.0.0.0"
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
# https://api.<ENV>.platform.pagopa.it/fdr-legacy/nodo-per-pa/v1
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


variable "cidr_subnet_buyerbanks" {
  type        = list(string)
  description = "Address prefixes subnet buyerbanks"
  default     = null
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

variable "buyer_banks_storage_account_replication_type" {
  type        = string
  default     = "LRS"
  description = "(Optional) Buyer banks storage account replication type"
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
