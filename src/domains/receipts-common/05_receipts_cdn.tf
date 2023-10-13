/**
 * CDN
 */
module "receipts_assets_cdn" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cdn?ref=v6.15.2"

  name                  = "assets"
  prefix                = local.project
  resource_group_name   = azurerm_resource_group.receipts_rg.name
  location              = var.location
  hostname              = "${var.dns_zone_prefix}.${var.external_domain}"
  https_rewrite_enabled = true

  index_document     = "index.html"
  error_404_document = "index.html"

  dns_zone_name                = azurerm_dns_zone.receipts_public.name
  dns_zone_resource_group_name = azurerm_dns_zone.receipts_public.resource_group_name

  keyvault_resource_group_name = "${local.product}-${var.domain}-sec-rg"
  keyvault_subscription_id     = data.azurerm_subscription.current.subscription_id
  keyvault_vault_name          =  "${local.product}-${var.domain}-kv"

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
      # Content-Security-Policy
      {
        action = "Overwrite"
        name   = var.env_short == "p" ? "Content-Security-Policy-Report-Only" : "Content-Security-Policy"
        value  = format("default-src 'self'; connect-src 'self' https://api.${var.dns_zone_platform}.${var.external_domain} https://api-eu.mixpanel.com")
      },
      {
        action = "Append"
        name   = var.env_short == "p" ? "Content-Security-Policy-Report-Only" : "Content-Security-Policy"
        value  = "https://cdn.cookielaw.org https://privacyportal-de.onetrust.com https://geolocation.onetrust.com;"
      },
      {
        action = "Append"
        name   = var.env_short == "p" ? "Content-Security-Policy-Report-Only" : "Content-Security-Policy"
        value  = "frame-ancestors 'none'; object-src 'none'; frame-src 'self' https://www.google.com *.platform.pagopa.it *.sia.eu *.nexigroup.com *.recaptcha.net recaptcha.net https://recaptcha.google.com;"
      },
      {
        action = "Append"
        name   = var.env_short == "p" ? "Content-Security-Policy-Report-Only" : "Content-Security-Policy"
        value  = "img-src 'self' https://cdn.cookielaw.org www.gstatic.com/recaptcha data:;"
      },
      {
        action = "Append"
        name   = var.env_short == "p" ? "Content-Security-Policy-Report-Only" : "Content-Security-Policy"
        value  = "script-src 'self' 'unsafe-inline' https://www.google.com https://www.gstatic.com https://cdn.cookielaw.org https://geolocation.onetrust.com https://www.recaptcha.net https://recaptcha.net https://www.gstatic.com/recaptcha/ https://www.gstatic.cn/recaptcha/;"
      },
      {
        action = "Append"
        name   = var.env_short == "p" ? "Content-Security-Policy-Report-Only" : "Content-Security-Policy"
        value  = "style-src 'self'  'unsafe-inline'; worker-src www.recaptcha.net blob:;"
      }
    ]
  }

  tags = var.tags
}
