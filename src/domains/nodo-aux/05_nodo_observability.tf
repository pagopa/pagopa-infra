resource "azurerm_resource_group" "nodo_observability_rg" {
  count    = var.nodo_observability_enabled ? 1 : 0
  name     = format("%s-nodo-observability-rg", local.product)
  location = var.location

  tags = module.tag_config.tags
}


locals {
  spa = [
    for i, spa in var.spa :
    {
      name  = replace("SPA-${spa}", "-", "")
      order = i + 3
      // +3 required because the order start from 1: 1 is reserved for default application redirect; 2 is reserved for the https rewrite;
      url_path_conditions = [{
        operator         = "BeginsWith"
        match_values     = ["/${spa}/"]
        negate_condition = false
        transforms       = null
      }]
      url_file_extension_conditions = [{
        operator         = "LessThanOrEqual"
        match_values     = ["0"]
        negate_condition = false
        transforms       = null
      }]

      url_rewrite_actions = [{
        source_pattern          = "/${spa}/"
        destination             = "/${spa}/index.html"
        preserve_unmatched_path = false
      }]
    }
  ]
  cors = {
    paths = ["/assets/"]
  }
}

/**
 * CDN
 */
module "nodo_observability_cdn" {
  count  = var.nodo_observability_enabled ? 1 : 0
  source = "../nodo-app/.terraform/modules/__v4__/cdn_frontdoor"


  cdn_prefix_name     = "${local.product}-observability"
  resource_group_name = azurerm_resource_group.nodo_observability_rg[0].name
  location            = var.location

  custom_domains = [
    {
      #                       observability.<ENV>.platform.pagopa.it
      domain_name             = "${local.dns_zone_nodo_observability}.${local.dns_zone_platform}.${local.external_domain}"
      hostname                = local.dns_zone_nodo_observability
      dns_name                = "${local.dns_zone_platform}.${local.external_domain}"
      dns_resource_group_name = local.vnet_resource_group_name
      ttl                     = var.env != "p" ? 300 : 3600
    }
  ]
  storage_account_index_document     = "index.html"
  storage_account_error_404_document = "index.html"
  querystring_caching_behaviour      = "UseQueryString"

  storage_account_replication_type = var.nodo_observability_storage_replication_type

  delivery_rule_url_path_condition_cache_expiration_action = [
    {
      name  = "BypassCacheOnQueryString"
      order = 0

      query_string_conditions = [{
        operator         = "GreaterThan"
        match_values     = ["0"]
        negate_condition = false
        transforms       = []
      }]

      route_configuration_override = {
        cache_behavior = "DisableCache"
      }
    }
  ]

  global_delivery_rules = [
    {
      order = 1
      # HSTS
      modify_response_header_actions = [
        {
          action = "Overwrite"
          name   = "Strict-Transport-Security"
          value  = "max-age=31536000"
        },
        # Content-Security-Policy (in Report mode)
        {
          action = "Overwrite"
          name   = "Content-Security-Policy-Report-Only"
          value  = "default-src 'self'; object-src 'none'; connect-src 'self' https://api.${local.dns_zone_nodo_observability}.${local.external_domain}/ https://${local.dns_zone_nodo_observability}.${local.dns_zone_platform}.${local.external_domain}/;"
          # https://api-eu.mixpanel.com https://wisp2.pagopa.gov.it
        },
        {
          action = "Append"
          name   = "Content-Security-Policy-Report-Only"
          value  = "script-src 'self'; style-src 'self' 'unsafe-inline' https://observability.pagopa.it/assets/font/selfhostedfonts.css; worker-src 'none'; font-src 'self' https://observability.pagopa.it/assets/font/; "
        },
        {
          action = "Append"
          name   = "X-Content-Type-Options"
          value  = "nosniff"
        },
        {
          action = "Append"
          name   = "Content-Security-Policy-Report-Only"
          value  = "img-src 'self' https://assets.cdn.io.italia.it https://selcdcheckoutsa.z6.web.core.windows.net data:;"
        },
        # {
        #   action = "Append"
        #   name   = "Content-Security-Policy-Report-Only"
        #   value  = "script-src 'self' 'unsafe-inline' https://www.google.com https://www.gstatic.com https://cdn.cookielaw.org https://geolocation.onetrust.com https://www.recaptcha.net https://recaptcha.net https://www.gstatic.com/recaptcha/ https://www.gstatic.cn/recaptcha/;"
        # },
        # {
        #   action = "Append"
        #   name   = "Content-Security-Policy-Report-Only"
        #   value  = "style-src 'self'  'unsafe-inline'; worker-src www.recaptcha.net blob:;"
        # }
      ]
    }
  ]
  delivery_rule_rewrites = concat([
    {
      name  = "RewriteRules"
      order = 2
      url_path_conditions = [
        {
          operator         = "Equal"
          match_values     = ["/"]
          negate_condition = false
          transforms       = null
        }
      ]
      url_rewrite_actions = [
        {
          source_pattern          = "/"
          destination             = "/ui/index.html"
          preserve_unmatched_path = false
        }
      ]
    }
  ],
    local.spa
  )
  delivery_custom_rules = [
    {
      name  = "robotsNoIndex"
      order = 3 + length(local.spa)

      // conditions
      url_path_conditions = [
        {
          operator         = "Equal"
          match_values     = length(var.robots_indexed_paths) > 0 ? var.robots_indexed_paths : ["dummy"]
          negate_condition = true
          transforms       = null
        }
      ]

      // actions
      modify_response_header_actions = [
        {
          action = "Overwrite"
          name   = "X-Robots-Tag"
          value  = "noindex, nofollow"
        }
      ]
    },
    {
      name  = "microcomponentsNoCache"
      order = 4 + length(local.spa)

      url_file_name_conditions = [
        {
          operator         = "Equal"
          match_values     = ["remoteEntry.js"]
          negate_condition = false
          transforms       = null
        }
      ]

      // actions
      modify_response_header_actions = [
        {
          action = "Overwrite"
          name   = "Cache-Control"
          value  = "no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0"
        }
      ]
    },
    {
      name  = "cors"
      order = 5 + length(local.spa)

      // conditions
      url_path_conditions = [
        {
          operator         = "BeginsWith"
          match_values     = local.cors.paths
          negate_condition = false
          transforms       = null
        }
      ]

      // actions
      modify_response_header_actions = [
        {
          action = "Overwrite"
          name   = "Access-Control-Allow-Origin"
          value  = "*"
        }
      ]
      cache_expiration_actions       = []
      cache_key_query_string_actions = []
      modify_request_header_actions  = []
      url_redirect_actions           = []
      url_rewrite_actions            = []
    }
  ]
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics.id

  tags = module.tag_config.tags
}


resource "azurerm_key_vault_secret" "nodo_observability_web_storage_account_key" {
  count        = var.nodo_observability_enabled ? 1 : 0
  name         = "web-storage-account-key"
  value        = module.nodo_observability_cdn[0].storage_primary_access_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry
resource "azurerm_key_vault_secret" "nodo_observability_web_storage_blob_connection_string" {
  count        = var.nodo_observability_enabled ? 1 : 0
  name         = "web-storage-blob-connection-string"
  value        = module.nodo_observability_cdn[0].storage_primary_blob_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}
