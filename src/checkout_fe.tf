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

  name                     = replace(format("%s-checkout-sa", local.project), "-", "")
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
resource "azurerm_cdn_endpoint" "checkout_cdn_e" {
  count = var.checkout_enabled ? 1 : 0

  name                          = format("%s-checkout-cdn-e", local.project)
  resource_group_name           = azurerm_resource_group.checkout_fe_rg[0].name
  location                      = var.location
  profile_name                  = azurerm_cdn_profile.checkout_cdn_p[0].name
  querystring_caching_behaviour = "BypassCaching"
  origin_host_header            = module.checkout_sa[0].primary_web_host

  # allow HTTP, HSTS will make future connections over HTTPS
  is_http_allowed = true

  origin {
    name      = "primary"
    host_name = module.checkout_sa[0].primary_web_host
  }

  global_delivery_rule {

    modify_response_header_action {
      action = "Overwrite"
      name   = "Strict-Transport-Security"
      value  = "max-age=31536000"
    }

  }

}
