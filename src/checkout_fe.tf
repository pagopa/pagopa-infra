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
 * Checkout storage account
 **/
module "checkout_sa" {
  count = var.checkout_enabled ? 1 : 0

  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v1.0.7"

  name            = replace(format("%s-checkout-sa", local.project), "-", "")
  versioning_name = format("%s-checkout-sa-versioning", local.project)

  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  access_tier              = "Hot"
  enable_versioning        = true
  resource_group_name      = azurerm_resource_group.checkout_fe_rg[0].name
  location                 = var.location
  allow_blob_public_access = true

  lock_enabled = true
  lock_name    = format("%s-checkout-sa-lock", local.project)
  lock_level   = "CanNotDelete"
  lock_notes   = null

  tags = var.tags
}

/**
 * Checkout cdn profile
 **/
resource "azurerm_cdn_profile" "checkout_cdn_p" {
  count               = var.checkout_enabled ? 1 : 0
  name                = format("%s-checkout-cdn-p", local.project)
  resource_group_name = azurerm_resource_group.checkout_fe_rg[0].name
  location            = var.location
  sku                 = "Standard_Microsoft"

  tags = var.tags
}

/**
 * CDN endpoint
 */
module "checkout_cdn_e" {
  source = "./modules/cdn_endpoint"

  count                         = var.checkout_enabled ? 1 : 0
  name                          = format("%s-checkout-cdn-e", local.project)
  resource_group_name           = azurerm_resource_group.checkout_fe_rg[0].name
  location                      = var.location
  profile_name                  = azurerm_cdn_profile.checkout_cdn_p[0].name
  querystring_caching_behaviour = "BypassCaching"
  origin_host_name              = module.checkout_sa[0].primary_web_host


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

  # rewrite HTTP to HTTPS
  delivery_rule_request_scheme_condition = [{
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

  }]
  tags = var.tags

}