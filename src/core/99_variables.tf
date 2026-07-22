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
    vnet_ita = bool
  })
  default = {
    vnet_ita = false
  }
  description = "Features enabled in this domain"
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

variable "create_wisp_converter" {
  type        = bool
  default     = false
  description = "CREATE WISP dismantling system infra"
}
