/**
 * Storage account
 **/
module "cdn_storage_account" {

  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v1.0.7"

  name            = replace(format("%s-%s-sa", var.project, var.product), "-", "")
  versioning_name = format("%s-%s-sa-versioning", var.project, var.product)

  account_kind             = var.account_kind
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  access_tier              = var.access_tier
  enable_versioning        = true
  resource_group_name      = var.resource_group_name
  location                 = var.location
  allow_blob_public_access = true

  lock_enabled = true
  lock_name    = format("%s-%s-sa-lock", var.project, var.product)
  lock_level   = "CanNotDelete"
  lock_notes   = null

  tags = var.tags
}

/**
 * cdn profile
 **/
resource "azurerm_cdn_profile" "this" {
  name                = format("%s-%s-cdn-p", var.project, var.product)
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard_Microsoft"

  tags = var.tags
}


resource "azurerm_cdn_endpoint" "this" {
  name                          = format("%s-%s-cdn-e", var.project, var.product)
  resource_group_name           = var.resource_group_name
  location                      = var.location
  profile_name                  = azurerm_cdn_profile.cdn_p.name
  is_https_allowed              = var.is_https_allowed
  is_http_allowed               = var.is_http_allowed
  querystring_caching_behaviour = var.querystring_caching_behaviour
  origin_host_header            = module.cdn_sa.primary_web_host

  origin {
    name      = "primary"
    host_name = module.cdn_sa.primary_web_host
  }

  dynamic "global_delivery_rule" {
    for_each = var.global_delivery_rule == null ? [] : [var.global_delivery_rule]
    iterator = gdr
    content {

      dynamic "cache_expiration_action" {
        for_each = gdr.value.cache_expiration_action
        iterator = cea
        content {
          behavior = cea.value.behavior
          duration = cea.value.duration
        }
      }

      dynamic "modify_request_header_action" {
        for_each = gdr.value.modify_request_header_action
        iterator = mrha
        content {
          action = mrha.value.action
          name   = mrha.value.name
          value  = mrha.value.value
        }
      }

      dynamic "modify_response_header_action" {
        for_each = gdr.value.modify_response_header_action
        iterator = mrha
        content {
          action = mrha.value.action
          name   = mrha.value.name
          value  = mrha.value.value
        }
      }
    }
  }


  dynamic "delivery_rule" {
    for_each = { for d in var.delivery_rule_url_path_condition_cache_expiration_action : d.order => d }
    content {
      order = delivery_rule.key
      name  = delivery_rule.value.name
      url_path_condition {
        operator     = delivery_rule.value.operator
        match_values = delivery_rule.value.match_values
      }
      cache_expiration_action {
        behavior = delivery_rule.value.behavior
        duration = delivery_rule.value.duration
      }
      modify_response_header_action {
        action = delivery_rule.value.response_action
        name   = delivery_rule.value.response_name
        value  = delivery_rule.value.response_value
      }
    }
  }

  dynamic "delivery_rule" {
    for_each = { for d in var.delivery_rule_request_scheme_condition : d.order => d }
    content {
      name  = delivery_rule.value.name
      order = delivery_rule.value.order

      request_scheme_condition {
        operator     = delivery_rule.value.operator
        match_values = delivery_rule.value.match_values
      }

      url_redirect_action {
        redirect_type = delivery_rule.value.url_redirect_action.redirect_type
        protocol      = delivery_rule.value.url_redirect_action.protocol
        hostname      = delivery_rule.value.url_redirect_action.hostname
        path          = delivery_rule.value.url_redirect_action.path
        fragment      = delivery_rule.value.url_redirect_action.fragment
        query_string  = delivery_rule.value.url_redirect_action.query_string
      }

    }
  }

  dynamic "delivery_rule" {
    for_each = { for d in var.delivery_rule_redirect : d.order => d }
    content {
      name  = delivery_rule.value.name
      order = delivery_rule.value.order

      request_uri_condition {
        operator     = delivery_rule.value.operator
        match_values = delivery_rule.value.match_values
      }

      url_redirect_action {
        redirect_type = delivery_rule.value.url_redirect_action.redirect_type
        protocol      = delivery_rule.value.url_redirect_action.protocol
        hostname      = delivery_rule.value.url_redirect_action.hostname
        path          = delivery_rule.value.url_redirect_action.path
        fragment      = delivery_rule.value.url_redirect_action.fragment
        query_string  = delivery_rule.value.url_redirect_action.query_string
      }

    }
  }

# rewrite HTTP to HTTPS
   dynamic "delivery_rule_request_scheme_condition"{
   count = var.https_rewrite_enabled ? 1 : 0
    content 
      {
    name         = "EnforceHTTPS"
    order        = 1
    operator     = "Equal"
    match_values = ["HTTP"]

    url_redirect_action = {
      redirect_type = "Found"
      protocol      = "Https"
      hostname      = null
      path          = null
      fragment      = null
      query_string  = null
    }

  }
   }
  tags = var.tags
}