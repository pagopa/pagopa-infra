/**
 * Checkout resource group
 **/
resource "azurerm_resource_group" "checkout_fe_rg" {
  count    = var.checkout_enabled ? 1 : 0
  name     = format("%s-checkout-fe-rg", local.project)
  location = var.location

  tags = var.tags
}

/**
 * CDN endpoint
 */
module "checkout_cdn_endpoint" {
  source = "./modules/cdn_endpoint"

  count               = var.checkout_enabled ? 1 : 0
  product             = "checkout"
  project             = local.project
  resource_group_name = azurerm_resource_group.checkout_fe_rg[0].name
  location            = var.location

  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  account_replication_type      = "GRS"
  access_tier                   = "Hot"
  querystring_caching_behaviour = "BypassCaching"


  # allow HTTP, HSTS will make future connections over HTTPS
  is_http_allowed = true

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
        name   = "Content-Security-Policy"
        value  = "default-src 'self'; connect-src 'self' https://api.io.italia.it https://api-eu.mixpanel.com https://wisp2.pagopa.gov.it"
      },
      {
        action = "Append"
        name   = "Content-Security-Policy"
        value  = " https://acardste.vaservices.eu;"
      },
      {
        action = "Append"
        name   = "Content-Security-Policy"
        value  = "frame-ancestors 'none'; object-src 'none'; frame-src *;"
      },
      {
        action = "Append"
        name   = "Content-Security-Policy"
        value  = "img-src 'self' https://acardste.vaservices.eu https://wisp2.pagopa.gov.it data:;"
      },
      {
        action = "Append"
        name   = "Content-Security-Policy"
        value  = "script-src 'self'; style-src 'self'  'unsafe-inline'; worker-src 'none';"
      }
    ]
  }

  https_rewrite_enabled = true

  tags = var.tags

}