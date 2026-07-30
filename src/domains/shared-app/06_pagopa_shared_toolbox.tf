resource "azurerm_resource_group" "pagopa_shared_toolbox_rg" {
  count    = var.pagopa_shared_toolbox_enabled ? 1 : 0
  name     = format("%s-pagopa-shared-toolbox-rg", local.product)
  location = var.location

  tags = module.tag_config.tags
}


locals {
  single_page_applications = [
    for i, spa in var.pagopa_shared_toolbox_singlepageapp :
    {
      name  = replace("SPA-${spa}", "-", "")
      order = i + 3 // +3 required because the order start from 1: 1 is reserved for default application redirect; 2 is reserved for the https rewrite;
      url_path_conditions = [
        {
          operator         = "BeginsWith"
          match_values     = ["/${spa}/"]
          negate_condition = false
          transforms       = []
        }
      ]
      url_file_extension_conditions = [
        {
          operator         = "LessThanOrEqual"
          match_values     = ["0"]
          negate_condition = false
          transforms       = []
        }
      ]
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
module "pagopa_shared_toolbox_cdn" {
  count  = var.pagopa_shared_toolbox_enabled ? 1 : 0
  source = "./.terraform/modules/__v4__/cdn_frontdoor"

  resource_group_name   = azurerm_resource_group.pagopa_shared_toolbox_rg[0].name
  location              = var.location
  cdn_prefix_name       = "${local.product}-shared-toolbox"
  https_rewrite_enabled = true

  storage_account_replication_type = var.cdn_storage_account_replication_type

  storage_account_index_document     = "index.html"
  storage_account_error_404_document = "not_found.html"
  storage_account_name               = "${local.product}sharedtoolboxsa"

  keyvault_id = data.azurerm_key_vault.kv.id
  tenant_id   = data.azurerm_client_config.current.tenant_id

  querystring_caching_behaviour = "IgnoreQueryString"

  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics.id

  global_delivery_rules = [
    {
      order                          = 1
      cache_expiration_actions       = []
      cache_key_query_string_actions = []
      modify_request_header_actions  = []

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
          value  = "default-src 'self'; object-src 'none'; connect-src 'self' https://api.${var.cname_record_name}.${var.external_domain}/ https://${var.cname_record_name}.${var.apim_dns_zone_prefix}.${var.external_domain}/;"
        },
        {
          action = "Append"
          name   = "Content-Security-Policy-Report-Only"
          value  = "script-src 'self' https://${var.cname_record_name}.${var.apim_dns_zone_prefix}.${var.external_domain}; style-src 'self' 'unsafe-inline' https://api.${var.cname_record_name}.${var.external_domain}/; worker-src 'none'; font-src 'self' https://api.${var.cname_record_name}.${var.external_domain}/; "
        },
        {
          action = "Append"
          name   = "X-Content-Type-Options"
          value  = "nosniff"
        },
        {
          action = "Append"
          name   = "Content-Security-Policy-Report-Only"
          value  = "img-src 'self' https://assets.cdn.io.italia.it https://pagopa${var.env_short}insightsfesa.z6.web.core.windows.net data:;"
        },
      ]
  }]

  // https://antbutcher.medium.com/hosting-a-react-js-app-on-azure-blob-storage-azure-cdn-for-ssl-and-routing-8fdf4a48feeb
  // it is important to add base tag in index.html too (i.e. <base href="/">)
  delivery_rule_rewrites = concat([{
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
    url_rewrite_actions = [{
      source_pattern          = "/"
      destination             = "/ui/index.html"
      preserve_unmatched_path = false
    }]
  }], local.single_page_applications)

  delivery_custom_rules = [
    {
      name  = "robotsNoIndex"
      order = 3 + length(local.single_page_applications)

      // conditions
      url_path_conditions = [{
        operator         = "Equal"
        match_values     = length(var.robots_indexed_paths) > 0 ? var.robots_indexed_paths : ["dummy"]
        negate_condition = true
        transforms       = null
      }]
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
      modify_response_header_actions = [{
        action = "Overwrite"
        name   = "X-Robots-Tag"
        value  = "noindex, nofollow"
      }]
      cache_expiration_actions       = []
      cache_key_query_string_actions = []
      modify_request_header_actions  = []
      url_redirect_actions           = []
      url_rewrite_actions            = []
    },
    {
      name  = "microcomponentsNoCache"
      order = 4 + length(local.single_page_applications)

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

      url_file_name_conditions = [{
        operator         = "Equal"
        match_values     = ["remoteEntry.js"]
        negate_condition = false
        transforms       = null
      }]

      // actions
      modify_response_header_actions = [{
        action = "Overwrite"
        name   = "Cache-Control"
        value  = "no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0"
      }]
      cache_expiration_actions       = []
      cache_key_query_string_actions = []
      modify_request_header_actions  = []
      url_redirect_actions           = []
      url_rewrite_actions            = []
    },
    {
      name  = "cors"
      order = 5 + length(local.single_page_applications)

      // conditions
      url_path_conditions = [{
        operator         = "BeginsWith"
        match_values     = local.cors.paths
        negate_condition = false
        transforms       = null
      }]
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
      modify_response_header_actions = [{
        action = "Overwrite"
        name   = "Access-Control-Allow-Origin"
        value  = "*"
      }]
      cache_expiration_actions       = []
      cache_key_query_string_actions = []
      modify_request_header_actions  = []
      url_redirect_actions           = []
      url_rewrite_actions            = []
  }]

  custom_domains = [
    {
      domain_name             = "${var.cname_record_name}.${var.apim_dns_zone_prefix}.${var.external_domain}"
      dns_name                = data.azurerm_dns_zone.public.name
      dns_resource_group_name = data.azurerm_dns_zone.public.resource_group_name
      ttl                     = 3600
    }
  ]

  tags = module.tag_config.tags
}

resource "azurerm_key_vault_secret" "pagopa_shared_toolbox_storage_account_key" {

  name         = "pagopa-shared-toolbox-storage-account-key"
  value        = module.pagopa_shared_toolbox_cdn[0].storage_primary_access_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry
resource "azurerm_key_vault_secret" "pagopa_shared_toolbox_web_storage_blob_connection_string" {

  name         = "web-storage-blob-connection-string"
  value        = module.pagopa_shared_toolbox_cdn[0].storage_primary_blob_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}
