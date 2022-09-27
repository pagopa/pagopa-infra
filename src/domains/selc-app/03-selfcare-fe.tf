/**
 * selc resource group
 **/
resource "azurerm_resource_group" "selc_fe_rg" {
  count    = var.selc_enabled ? 1 : 0
  name     = format("%s-selc-fe-rg", local.project)
  location = var.location

  tags = var.tags
}

/**
 * CDN
 */
// public storage used to serve FE
#tfsec:ignore:azure-storage-default-action-deny
module "selc_cdn" {
  source = "git::https://github.com/pagopa/azurerm.git//cdn?ref=v2.12.1"

  count                 = var.selc_enabled ? 1 : 0
  name                  = "selc"
  prefix                = local.project
  resource_group_name   = azurerm_resource_group.selc_fe_rg.name
  location              = var.location
  hostname              = format("%s.%s", var.dns_zone_selc, var.external_domain)
  https_rewrite_enabled = true
  lock_enabled          = var.lock_enable

  index_document     = "index.html"
  error_404_document = "error.html"

  dns_zone_name                = azurerm_dns_zone.selc_public[0].name
  dns_zone_resource_group_name = azurerm_dns_zone.selc_public[0].resource_group_name

  keyvault_resource_group_name = module.key_vault.resource_group_name
  keyvault_subscription_id     = data.azurerm_subscription.current.subscription_id
  keyvault_vault_name          = module.key_vault.name

  querystring_caching_behaviour = "BypassCaching"

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
        value  = format("default-src 'self'; connect-src 'self' https://api.%s.%s https://api-eu.mixpanel.com https://wisp2.pagopa.gov.it", var.dns_zone_prefix, var.external_domain)
      },
      {
        action = "Append"
        name   = "Content-Security-Policy-Report-Only"
        value  = "script-src 'self'; style-src 'self' 'unsafe-inline' https://selfcare.pagopa.it/assets/font/selfhostedfonts.css; worker-src 'none'; font-src 'self' https://selfcare.pagopa.it/assets/font/; "
      },
      {
        action = "Append"
        name   = "Content-Security-Policy-Report-Only"
        value  = format("img-src 'self' https://assets.cdn.io.italia.it https://%s data:; ", module.selc_cdn.storage_primary_web_host)
      },
      {
        action = "Append"
        name   = "X-Content-Type-Options"
        value  = "nosniff"
      },
      {
        action = "Append"
        name   = "Content-Security-Policy-Report-Only"
        value  = " https://acardste.vaservices.eu:* https://cdn.cookielaw.org https://privacyportal-de.onetrust.com https://geolocation.onetrust.com;"
      },
      {
        action = "Append"
        name   = "Content-Security-Policy-Report-Only"
        value  = "frame-ancestors 'none'; object-src 'none'; frame-src 'self' https://www.google.com *.platform.pagopa.it *.sia.eu *.nexigroup.com *.recaptcha.net recaptcha.net https://recaptcha.google.com;"
      },
      {
        action = "Append"
        name   = "Content-Security-Policy-Report-Only"
        value  = "img-src 'self' https://cdn.cookielaw.org https://acardste.vaservices.eu:* https://wisp2.pagopa.gov.it www.gstatic.com/recaptcha data:;"
      },
      {
        action = "Append"
        name   = "Content-Security-Policy-Report-Only"
        value  = "script-src 'self' 'unsafe-inline' https://www.google.com https://www.gstatic.com https://cdn.cookielaw.org https://geolocation.onetrust.com https://www.recaptcha.net https://recaptcha.net https://www.gstatic.com/recaptcha/ https://www.gstatic.cn/recaptcha/;"
      },
      {
        action = "Append"
        name   = "Content-Security-Policy-Report-Only"
        value  = "style-src 'self'  'unsafe-inline'; worker-src www.recaptcha.net blob:;"
      }
    ]
  }

  delivery_rule_rewrite = concat([{
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
      destination             = "/index.html"
      preserve_unmatched_path = false
    }
  }])

  tags = var.tags
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry
resource "azurerm_key_vault_secret" "selc_web_storage_access_key" {
  name         = "web-storage-access-key"
  value        = module.selc_cdn.storage_primary_access_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry
resource "azurerm_key_vault_secret" "selc_web_storage_connection_string" {
  name         = "web-storage-connection-string"
  value        = module.selc_cdn.storage_primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry
resource "azurerm_key_vault_secret" "selc_web_storage_blob_connection_string" {
  name         = "web-storage-blob-connection-string"
  value        = module.selc_cdn.storage_primary_blob_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}
