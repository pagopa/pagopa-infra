##############
## Products ##
##############

module "apim_checkout_carts_auth" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "checkout-carts"
  display_name = "Checkout pagoPA carts"
  description  = "Product to allow integration to EC or other clients with Checkout pagoPA carts"

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/checkout/_base_policy.xml")
}

locals {
  apim_checkout_carts_auth = {
    # params for all api versions
    display_name          = "Checkout pagoPA carts - auth API"
    description           = "Authenticated API exposed to allow integration to EC or other clients with Checkout pagoPA carts"
    path                  = "checkout/carts-auth"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "checkout_carts_auth_api_v1" {
  name                = "${local.parent_project}-carts-auth-api"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim.name
  display_name        = local.apim_checkout_carts_auth.display_name
  versioning_scheme   = "Segment"
}

module "apim_checkout_carts_auth_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.parent_project}-carts-auth-api"
  api_management_name   = data.azurerm_api_management.apim.name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_checkout_carts_auth.product_id]
  subscription_required = local.apim_checkout_carts_auth.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.checkout_carts_auth_api_v1.id
  api_version           = "v1"
  service_url           = local.apim_checkout_carts_auth.service_url

  description  = local.apim_checkout_carts_auth.description
  display_name = local.apim_checkout_carts_auth.display_name
  path         = local.apim_checkout_carts_auth.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/checkout/checkout_carts_auth/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/checkout/checkout_carts_auth/v1/_base_policy.xml.tpl", {
    ecommerce_ingress_hostname = var.ecommerce_ingress_hostname,
  })
}
