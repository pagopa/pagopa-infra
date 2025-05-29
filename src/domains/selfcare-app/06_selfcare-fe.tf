/**
 * selfcare resource group
 **/
resource "azurerm_resource_group" "selfcare_fe_rg" {
  count    = var.selfcare_fe_enabled ? 1 : 0
  name     = "${local.product}-fe-rg" #-${var.domain}
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
      conditions = [
        {
          condition_type   = "url_path_condition"
          operator         = "BeginsWith"
          match_values     = ["/${spa}/"]
          negate_condition = false
          transforms       = null
        },
        {
          condition_type   = "url_file_extension_condition"
          operator         = "LessThanOrEqual"
          match_values     = ["0"]
          negate_condition = false
          transforms       = null
        },
      ]
      url_rewrite_action = {
        source_pattern          = "/${spa}/"
        destination             = "/${spa}/index.html"
        preserve_unmatched_path = false
      }
    }
  ]
  cors = {
    paths = ["/assets/"]
  }
}

/**
 * CDN
 */
// public storage used to serve FE
#tfsec:ignore:azure-storage-default-action-deny
module "selfcare_cdn" {
  source = "./.terraform/modules/__v3__/cdn"
  count  = var.selfcare_fe_enabled ? 1 : 0

  name                = "selfcare"
  prefix              = local.product
  resource_group_name = azurerm_resource_group.selfcare_fe_rg[0].name
  location            = var.location
  #                       selfcare.<ENV>.platform.pagopa.it
  hostname              = "${local.dns_zone_selfcare}.${local.dns_zone_platform}.${local.external_domain}"
  https_rewrite_enabled = true

  index_document     = "index.html"
  error_404_document = "error.html"

  #                             <ENV>.platform.pagopa.it
  dns_zone_name                = "${local.dns_zone_platform}.${local.external_domain}"
  dns_zone_resource_group_name = local.vnet_resource_group_name

  keyvault_resource_group_name = data.azurerm_key_vault.kv.resource_group_name
  keyvault_subscription_id     = data.azurerm_subscription.current.subscription_id
  keyvault_vault_name          = data.azurerm_key_vault.kv.name

  querystring_caching_behaviour = "BypassCaching"

  storage_account_replication_type = var.selfcare_storage_replication_type

  global_delivery_rule = {
    cache_expiration_action       = []
    cache_key_query_string_action = []
    modify_request_header_action  = []

    # HSTS
    modify_response_header_action = [
      {
        action = "Overwrite"
        name   = "Strict-Transport-Security"
        value  = "max-age=31536000"
      },
      # Content-Security-Policy (in Report mode)
      {
        action = "Overwrite"
        name   = "Content-Security-Policy-Report-Only"
        value  = "default-src 'self'; object-src 'none'; connect-src 'self' https://api.${local.dns_zone_selfcare}.${local.external_domain}/ https://${local.dns_zone_selfcare}.${local.dns_zone_platform}.${local.external_domain}/;"
        # https://api-eu.mixpanel.com https://wisp2.pagopa.gov.it
      },
      {
        action = "Append"
        name   = "Content-Security-Policy-Report-Only"
        value  = "script-src 'self'; style-src 'self' 'unsafe-inline' https://selfcare.pagopa.it/assets/font/selfhostedfonts.css; worker-src 'none'; font-src 'self' https://selfcare.pagopa.it/assets/font/; "
      },
      # {
      #   action = "Append"
      #   name   = "Content-Security-Policy-Report-Only"
      #   value  = format("img-src 'self' https://assets.cdn.io.italia.it https://%s data:; ", module.selfcare_cdn.storage_primary_web_host)
      # },
      {
        action = "Append"
        name   = "X-Content-Type-Options"
        value  = "nosniff"
      },
      # {
      #   action = "Append"
      #   name   = "Content-Security-Policy-Report-Only"
      #   value  = " https://acardste.vaservices.eu:* https://cdn.cookielaw.org https://privacyportal-de.onetrust.com https://geolocation.onetrust.com;"
      # },
      # {
      #   action = "Append"
      #   name   = "Content-Security-Policy-Report-Only"
      #   value  = "frame-ancestors 'none'; object-src 'none'; frame-src 'self' https://www.google.com *.platform.pagopa.it *.sia.eu *.nexigroup.com *.recaptcha.net recaptcha.net https://recaptcha.google.com;"
      # },
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

  delivery_rule_rewrite = concat([
    {
      name  = "RewriteRules"
      order = 2
      conditions = [
        {
          condition_type   = "url_path_condition"
          operator         = "Equal"
          match_values     = ["/"]
          negate_condition = false
          transforms       = null
        }
      ]
      url_rewrite_action = {
        source_pattern          = "/"
        destination             = "/ui/index.html"
        preserve_unmatched_path = false
      }
    }
    ],
    local.spa
  )

  delivery_rule = [
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
      cookies_conditions            = []
      device_conditions             = []
      http_version_conditions       = []
      post_arg_conditions           = []
      query_string_conditions       = []
      remote_address_conditions     = []
      request_body_conditions       = []
      request_header_conditions     = []
      request_method_conditions     = []
      request_scheme_conditions     = []
      request_uri_conditions        = []
      url_file_extension_conditions = []
      url_file_name_conditions      = []

      // actions
      modify_response_header_actions = [
        {
          action = "Overwrite"
          name   = "X-Robots-Tag"
          value  = "noindex, nofollow"
        }
      ]
      cache_expiration_actions       = []
      cache_key_query_string_actions = []
      modify_request_header_actions  = []
      url_redirect_actions           = []
      url_rewrite_actions            = []
    },
    {
      name  = "microcomponentsNoCache"
      order = 4 + length(local.spa)

      // conditions
      url_path_conditions           = []
      cookies_conditions            = []
      device_conditions             = []
      http_version_conditions       = []
      post_arg_conditions           = []
      query_string_conditions       = []
      remote_address_conditions     = []
      request_body_conditions       = []
      request_header_conditions     = []
      request_method_conditions     = []
      request_scheme_conditions     = []
      request_uri_conditions        = []
      url_file_extension_conditions = []

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
      cache_expiration_actions       = []
      cache_key_query_string_actions = []
      modify_request_header_actions  = []
      url_redirect_actions           = []
      url_rewrite_actions            = []
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
      request_header_conditions     = []
      cookies_conditions            = []
      device_conditions             = []
      http_version_conditions       = []
      post_arg_conditions           = []
      query_string_conditions       = []
      remote_address_conditions     = []
      request_body_conditions       = []
      request_method_conditions     = []
      request_scheme_conditions     = []
      request_uri_conditions        = []
      url_file_extension_conditions = []
      url_file_name_conditions      = []

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

  tags                       = module.tag_config.tags
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics.id
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry
resource "azurerm_key_vault_secret" "selfcare_web_storage_access_key" {
  name         = "web-storage-access-key"
  value        = module.selfcare_cdn[0].storage_primary_access_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry
resource "azurerm_key_vault_secret" "selfcare_web_storage_connection_string" {
  name         = "web-storage-connection-string"
  value        = module.selfcare_cdn[0].storage_primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry
resource "azurerm_key_vault_secret" "selfcare_web_storage_blob_connection_string" {
  name         = "web-storage-blob-connection-string"
  value        = module.selfcare_cdn[0].storage_primary_blob_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}


resource "azurerm_static_web_app" "selfcare_backoffice_static_web_app" {
  count = var.env_short == "d" ? 1 : 0

  name                = "${var.prefix}-${var.env_short}-${var.domain}-backoffice-fe"
  resource_group_name = azurerm_resource_group.selfcare_fe_rg[0].name
  location            = var.location

  sku_tier = "Standard"
  sku_size = "Standard"
}

resource "azurerm_key_vault_secret" "selfcare_backoffice_static_app_key" {
  count = var.env_short == "d" ? 1 : 0

  name         = "backoffice-static-app-key"
  value        = azurerm_static_web_app.selfcare_backoffice_static_web_app[0].api_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}
