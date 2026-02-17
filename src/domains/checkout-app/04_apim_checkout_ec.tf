##############
## Products ##
##############

module "apim_checkout_ec_product" {
  source = "./.terraform/modules/__v4__/api_management_product"

  product_id   = "checkout-ec"
  display_name = "checkout pagoPA for ECs"
  description  = "Product for checkout pagoPA for ECs"

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/checkout/_base_policy.xml")
}

locals {
  apim_checkout_ec_api = {
    # params for all api versions
    display_name          = "Checkout - EC API"
    description           = "Checkout API for EC"
    path                  = "checkout/ec"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "checkout_ec_api_v1" {
  name                = "${local.parent_project}-checkout-ec-api"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim.name
  display_name        = local.apim_checkout_ec_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_checkout_ec_api_v1" {
  source = "./.terraform/modules/__v4__/api_management_api"

  name                  = "${local.parent_project}-checkout-ec-api"
  api_management_name   = data.azurerm_api_management.apim.name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_checkout_ec_product.product_id]
  subscription_required = local.apim_checkout_ec_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.checkout_ec_api_v1.id
  api_version           = "v1"
  service_url           = local.apim_checkout_ec_api.service_url

  description  = local.apim_checkout_ec_api.description
  display_name = local.apim_checkout_ec_api.display_name
  path         = local.apim_checkout_ec_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/checkout/checkout_ec/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/checkout/checkout_ec/v1/_base_policy.xml.tpl", {
    ecommerce_ingress_hostname = var.ecommerce_ingress_hostname,
  })
}

module "apim_checkout_ec_api_v2" {
  source = "./.terraform/modules/__v4__/api_management_api"

  name                  = "${local.parent_project}-checkout-ec-api"
  api_management_name   = data.azurerm_api_management.apim.name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_checkout_ec_product.product_id]
  subscription_required = local.apim_checkout_ec_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.checkout_ec_api_v1.id # RIUSO VERSION SET
  api_version           = "v2"
  service_url           = local.apim_checkout_ec_api.service_url

  description  = "${local.apim_checkout_ec_api.description} - v2"
  display_name = "${local.apim_checkout_ec_api.display_name} - v2"
  path         = "${local.apim_checkout_ec_api.path}/v2"
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/checkout/checkout_ec/v2/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/checkout/checkout_ec/v2/_base_policy.xml.tpl", {
    ecommerce_ingress_hostname = var.ecommerce_ingress_hostname,
  })
}

