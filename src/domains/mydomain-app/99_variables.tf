# general


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


variable "location" {
  type        = string
  description = "One of .."
}

variable "location_short" {
  type = string
  validation {
    condition = (
      length(var.location_short) == 3
    )
    error_message = "Length must be 3 chars."
  }
  description = "One of ..."
}

variable "location_string" {
  type        = string
  description = "One of ..."
}


variable "dns_zone_internal_prefix" {
  type        = string
  default     = null
  description = "The dns subdomain."
}

variable "external_domain" {
  type        = string
  default     = null
  description = "Domain for delegation"
}

### PDB
variable "pod_disruption_budgets" {
  type = map(object({
    name         = optional(string, null)
    minAvailable = optional(number, null)
    matchLabels  = optional(map(any), {})
  }))
  description = "Pod disruption budget for domain namespace"
  default     = {}
}

variable "dns_zone_prefix" {
  type        = string
  default     = null
  description = "The wallet dns subdomain."
}


variable "k8s_kube_config_path_prefix" {
  type    = string
  default = "~/.kube"
}
