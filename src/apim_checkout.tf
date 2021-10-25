##############
## Products ##
##############

module "apim_checkout_product" {
  count  = var.checkout_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.16"

  product_id   = "checkout"
  display_name = "checkout pagoPA"
  description  = "Product for checkout pagoPA"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/checkout/_base_policy.xml")
}

locals {
  apim_checkout_api = {
    # params for all api versions
    display_name          = "CHECKOUT BACKEND API"
    description           = "BACKEND API for checkout"
    path                  = "checkout/api"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "checkout_api" {
  count = var.checkout_enabled ? 1 : 0

  name                = format("%s-checkout-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_checkout_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_checkout_api_v1" {
  count = var.checkout_enabled ? 1 : 0

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-checkout-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_checkout_product[0].product_id]
  subscription_required = local.apim_checkout_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.checkout_api[0].id
  api_version           = "v1"
  service_url           = local.apim_checkout_api.service_url

  description  = local.apim_checkout_api.description
  display_name = local.apim_checkout_api.display_name
  path         = local.apim_checkout_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/checkout/v1/_swagger.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/checkout/v1/_base_policy.xml.tpl", {
    origin = format("https://%s.%s/", var.dns_zone_checkout, var.external_domain)
  })
}
