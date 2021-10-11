variable "product" {
  type = string
}
variable "project" {
  type = string
}

variable "account_kind" {
  type = string
}

variable "account_tier" {
  type = string
}

variable "account_replication_type" {
  type = string
}

variable "access_tier" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "resource_group_name" {
  type = string
}

variable "is_https_allowed" {
  type    = bool
  default = true
}

variable "is_http_allowed" {
  type    = bool
  default = false
}

variable "querystring_caching_behaviour" {
  type    = string
  default = "IgnoreQueryString"
}

variable "global_delivery_rule" {
  type = object({
    cache_expiration_action = list(object({
      behavior = string
      duration = string
    }))
    cache_key_query_string_action = list(object({
      behavior   = string
      parameters = string
    }))
    modify_request_header_action = list(object({
      action = string
      name   = string
      value  = string
    }))
    modify_response_header_action = list(object({
      action = string
      name   = string
      value  = string
    }))
  })
  default = null
}


variable "delivery_rule_url_path_condition_cache_expiration_action" {
  type = list(object({
    name            = string
    order           = number
    operator        = string
    match_values    = list(string)
    behavior        = string
    duration        = string
    response_action = string
    response_name   = string
    response_value  = string
  }))
  default = []
}

variable "delivery_rule_request_scheme_condition" {
  type = list(object({
    name         = string
    order        = number
    operator     = string
    match_values = list(string)
    url_redirect_action = object({
      redirect_type = string
      protocol      = string
      hostname      = string
      path          = string
      fragment      = string
      query_string  = string
    })
  }))
  default = []
}

variable "delivery_rule_redirect" {
  type = list(object({
    name         = string
    order        = number
    operator     = string
    match_values = list(string)
    url_redirect_action = object({
      redirect_type = string
      protocol      = string
      hostname      = string
      path          = string
      fragment      = string
      query_string  = string
    })
  }))
  default = []
}
variable "https_rewrite_enabled" {
  type    = bool
  default = true
}