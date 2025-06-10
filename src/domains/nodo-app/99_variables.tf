# general

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

variable "location_string" {
  type        = string
  description = "One of West Europe, North Europe"
}

variable "instance" {
  type        = string
  description = "One of beta, prod01, prod02"
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

### Aks

variable "k8s_kube_config_path_prefix" {
  type    = string
  default = "~/.kube"
}

variable "external_domain" {
  type        = string
  default     = null
  description = "Domain for delegation"
}

variable "dns_zone_internal_prefix" {
  type        = string
  default     = null
  description = "The dns subdomain."
}

variable "apim_dns_zone_prefix" {
  type        = string
  default     = null
  description = "The dns subdomain for apim."
}

variable "tls_cert_check_helm" {
  type = object({
    chart_version = string,
    image_name    = string,
    image_tag     = string
  })
  description = "tls cert helm chart configuration"
}
variable "nodo_user_node_pool" {
  type = object({
    enabled            = bool,
    name               = string,
    vm_size            = string,
    os_disk_type       = string,
    os_disk_size_gb    = string,
    node_count_min     = number,
    node_count_max     = number,
    node_labels        = map(any),
    node_taints        = list(string),
    node_tags          = map(any),
    nodo_pool_max_pods = number,
  })
  description = "AKS node pool user configuration"
}

variable "aks_cidr_subnet" {
  type        = list(string)
  description = "Aks network address space."
}

variable "cidr_subnet_vmss" {
  type        = list(string)
  description = "VMSS network address space."
}

variable "cname_record_name" {
  type    = string
  default = "config"
}

# nodo dei pagamenti - ndp
variable "nodo_ndp_subscription_limit" {
  type        = number
  description = "subscriptions limit"
  default     = 1000
}

variable "lb_frontend_private_ip_address" {
  type        = string
  description = "load balancer egress nodo private ip"
}

variable "route_aks" {
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = string
  }))
  description = "AKS routing table"
}

variable "vmss_zones" {
  type        = list(string)
  description = "availability zones for vmss "
}

variable "vmss_instance_number" {
  type        = number
  description = "availability zones for vmss "
}

variable "nodo_re_to_datastore_function" {
  type = object({
    always_on                    = bool
    kind                         = string
    sku_size                     = string
    sku_tier                     = string
    maximum_elastic_worker_count = number
  })
  description = "Nodo RE to datastore function"
  default = {
    always_on                    = true
    kind                         = "Linux"
    sku_size                     = "B1"
    sku_tier                     = "Basic"
    maximum_elastic_worker_count = 1
  }
}

variable "nodo_re_to_datastore_function_subnet" {
  type        = list(string)
  description = "Address prefixes subnet"
  default     = null
}

variable "nodo_re_to_datastore_network_policies_enabled" {
  type        = bool
  description = "Network policies enabled"
  default     = false
}

variable "nodo_re_to_datastore_function_app_image_tag" {
  type        = string
  default     = "latest"
  description = "Nodo RE to Datastore function app docker image tag. Defaults to 'latest'"
}

variable "nodo_re_to_datastore_function_autoscale" {
  type = object({
    default = number
    minimum = number
    maximum = number
  })
  description = "Nodo RE functions autoscaling parameters"
}

variable "nodo_re_to_tablestorage_function" {
  type = object({
    always_on                    = bool
    kind                         = string
    sku_size                     = string
    sku_tier                     = string
    maximum_elastic_worker_count = number
  })
  description = "Nodo RE to datastore function"
}

variable "nodo_re_to_tablestorage_function_subnet" {
  type        = list(string)
  description = "Address prefixes subnet"
  default     = null
}

variable "nodo_re_to_tablestorage_network_policies_enabled" {
  type        = bool
  description = "Network policies enabled"
  default     = false
}

variable "nodo_re_to_tablestorage_function_app_image_tag" {
  type        = string
  default     = "latest"
  description = "Nodo RE to Table Storage function app docker image tag. Defaults to 'latest'"
}

variable "nodo_re_to_tablestorage_function_autoscale" {
  type = object({
    default = number
    minimum = number
    maximum = number
  })
  description = "Nodo RE functions autoscaling parameters"
}


variable "function_app_storage_account_replication_type" {
  type        = string
  default     = "ZRS"
  description = "(Optional) Storage account replication type used for function apps"
}

variable "nodo_verifyko_to_datastore_function" {
  type = object({
    always_on                    = bool
    kind                         = string
    sku_size                     = string
    sku_tier                     = string
    maximum_elastic_worker_count = number
    zone_balancing_enabled       = bool
  })
  description = "Nodo Verify KO events to datastore function"
}

variable "nodo_verifyko_to_datastore_function_subnet" {
  type        = list(string)
  description = "Address prefixes subnet"
  default     = null
}

variable "nodo_verifyko_to_datastore_network_policies_enabled" {
  type        = bool
  description = "Network policies enabled"
  default     = false
}

variable "nodo_verifyko_to_datastore_function_app_image_tag" {
  type        = string
  default     = "latest"
  description = "Nodo Verify KO to Datastore function app docker image tag. Defaults to 'latest'"
}

variable "nodo_verifyko_to_datastore_function_autoscale" {
  type = object({
    default = number
    minimum = number
    maximum = number
  })
  description = "Nodo Verify KO event functions autoscaling parameters"
}
variable "nodo_verifyko_to_tablestorage_function" {
  type = object({
    always_on                    = bool
    kind                         = string
    sku_size                     = string
    sku_tier                     = string
    maximum_elastic_worker_count = number
    zone_balancing_enabled       = bool
  })
  description = "Nodo Verify KO events to table storage function"
}

variable "nodo_verifyko_to_tablestorage_function_subnet" {
  type        = list(string)
  description = "Address prefixes subnet"
  default     = null
}

variable "nodo_verifyko_to_tablestorage_network_policies_enabled" {
  type        = bool
  description = "Network policies enabled"
  default     = false
}

variable "nodo_verifyko_to_tablestorage_function_app_image_tag" {
  type        = string
  default     = "latest"
  description = "Nodo Verify KO events to Table Storage function app docker image tag. Defaults to 'latest'"
}

variable "nodo_verifyko_to_tablestorage_function_autoscale" {
  type = object({
    default = number
    minimum = number
    maximum = number
  })
  description = "Nodo Verify KO events to Table Storage functions autoscaling parameters"
}

variable "pod_disruption_budgets" {
  type = map(object({
    name         = optional(string, null)
    minAvailable = optional(number, null)
    matchLabels  = optional(map(any), {})
  }))
  description = "Pod disruption budget for domain namespace"
  default     = {}
}

variable "enable_nodo_re" {
  type        = bool
  default     = false
  description = "Enables dumping nodo re"
}

variable "app_gateway_allowed_paths_pagopa_onprem_only" {
  type = object({
    paths = list(string)
    ips   = list(string)
  })
  description = "Allowed paths from pagopa onprem only"
}


variable "apim_nodo_decoupler_enable" {
  type        = bool
  default     = true
  description = "Apply decoupler to nodo product apim policy"
}

variable "node_decoupler_primitives" {
  type        = string
  description = "Node decoupler primitives"
  default     = "nodoChiediNumeroAvviso,nodoChiediCatalogoServizi,nodoAttivaRPT,nodoVerificaRPT,nodoChiediInformativaPA,nodoChiediInformativaPSP,nodoChiediTemplateInformativaPSP,nodoPAChiediInformativaPA,nodoChiediSceltaWISP,demandPaymentNotice"
}


variable "nodo_pagamenti_subkey_required" {
  type        = bool
  description = "Enabled subkeys for nodo dei pagamenti api"
  default     = false
}

# nodo dei pagamenti - auth (nuova connettività)
variable "nodo_auth_subscription_limit" {
  type        = number
  description = "subscriptions limit"
  default     = 1000
}

variable "apim_nodo_auth_decoupler_enable" {
  type        = bool
  default     = true
  description = "Apply decoupler to nodo-auth product apim policy"
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

# Storage account
variable "storage_account_info" {
  type = object({
    account_kind                      = string
    account_tier                      = string
    account_replication_type          = string
    access_tier                       = string
    advanced_threat_protection_enable = bool
    use_legacy_defender_version       = bool
    public_network_access_enabled     = bool
  })

  default = {
    account_kind                      = "StorageV2"
    account_tier                      = "Standard"
    account_replication_type          = "LRS"
    access_tier                       = "Hot"
    advanced_threat_protection_enable = true
    use_legacy_defender_version       = true
    public_network_access_enabled     = false
  }
}


variable "create_wisp_converter" {
  type        = bool
  default     = false
  description = "CREATE WISP dismantling system infra"
}

variable "wisp_converter" {
  type = object({
    enable_apim_switch                  = bool # enable WISP dismantling
    brokerPSP_whitelist                 = string
    channel_whitelist                   = string
    nodoinviarpt_paymenttype_whitelist  = string
    dismantling_primitives              = string
    dismantling_rt_primitives           = string
    checkout_predefined_expiration_time = number
    wisp_ecommerce_channels             = string
  })
}

# https://pagopa.atlassian.net/wiki/spaces/IQCGJ/pages/654541075/RFC+Gestione+clientId+per+integrazione+Software+Client
variable "enable_sendPaymentResultV2_SWClient" {
  type        = bool
  default     = false
  description = "Gestione clientId per integrazione Software Client"
}

variable "wfesp_dismantling" {
  type = object({
    channel_list    = string
    wfesp_fixed_url = string
  })
}

variable "gh_runner_job_location" {
  type        = string
  description = "(Optional) The GH runner container app job location. Consistent with the container app environment location"
  default     = "westeurope"
}
