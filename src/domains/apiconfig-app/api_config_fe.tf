/**
 * Checkout resource group
 **/
resource "azurerm_resource_group" "api_config_fe_rg" {
  count    = var.api_config_fe_enabled ? 1 : 0
  name     = format("%s-api-config-fe-rg", local.product)
  location = var.location

  tags = module.tag_config.tags
}

/**
 * CDN
 */
module "api_config_fe_cdn" {
  source = "./.terraform/modules/__v3__/cdn"

  count               = var.api_config_fe_enabled ? 1 : 0
  name                = "api-config-fe"
  prefix              = local.product
  resource_group_name = azurerm_resource_group.api_config_fe_rg[0].name
  location            = var.location

  # should be something like that            config              <dev|uat>.platform   .pagapa.it
  hostname              = format("%s.%s.%s", var.cname_record_name, var.apim_dns_zone_prefix, var.external_domain)
  https_rewrite_enabled = true

  storage_account_replication_type = var.cdn_storage_account_replication_type

  index_document     = "index.html"
  error_404_document = "not_found.html"

  dns_zone_name                = data.azurerm_dns_zone.public.name
  dns_zone_resource_group_name = data.azurerm_dns_zone.public.resource_group_name

  keyvault_resource_group_name = data.azurerm_key_vault.kv.resource_group_name
  keyvault_subscription_id     = data.azurerm_subscription.current.subscription_id
  keyvault_vault_name          = data.azurerm_key_vault.kv.name

  querystring_caching_behaviour = "BypassCaching"

  // https://antbutcher.medium.com/hosting-a-react-js-app-on-azure-blob-storage-azure-cdn-for-ssl-and-routing-8fdf4a48feeb
  // it is important to add base tag in index.html too (i.e. <base href="/">)
  delivery_rule_rewrite = [{
    name  = "RewriteRules"
    order = 2

    conditions = [{
      condition_type   = "url_file_extension_condition"
      operator         = "LessThan"
      match_values     = ["1"]
      transforms       = []
      negate_condition = false
    }]

    url_rewrite_action = {
      source_pattern          = "/"
      destination             = "/index.html"
      preserve_unmatched_path = false
    }
  }]

  global_delivery_rule = {
    cache_expiration_action       = []
    cache_key_query_string_action = []
    modify_request_header_action  = []

    # HSTS
    modify_response_header_action = [{
      action = "Overwrite"
      name   = "Strict-Transport-Security"
      value  = "max-age=31536000"
      },
      # Content-Security-Policy (in Report mode)
      {
        action = "Overwrite"
        name   = "Content-Security-Policy-Report-Only"
        value = format("object-src 'none'; connect-src 'self' https://api.%s.%s/; script-src https://api.%s.%s/"
        , var.apim_dns_zone_prefix, var.external_domain, var.apim_dns_zone_prefix, var.external_domain)
      }
    ]
  }

  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics.id

  tags = module.tag_config.tags
}

resource "azurerm_key_vault_secret" "storage_account_key" {
  name         = "api-config-fe-storage-account-key"
  value        = module.api_config_fe_cdn[0].storage_primary_access_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}
