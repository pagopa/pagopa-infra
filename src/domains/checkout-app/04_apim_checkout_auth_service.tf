locals {
  apim_checkout_auth_service = {
    display_name          = "Checkout pagoPA Auth Service"
    description           = "Authenticated API exposed to allow integration to EC or other clients with Checkout pagoPA Auth Service"
    path                  = "checkout/auth-service"
    subscription_required = true
    service_url           = "https://pagopa-checkout-auth-service"
  }
}

resource "azurerm_api_management_api_version_set" "checkout_auth_service_api_v1" {
  name                = "${local.parent_project}-auth-service-api"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim.name
  display_name        = local.apim_checkout_auth_service.display_name
  versioning_scheme   = "Segment"
}

module "apim_checkout_auth_service_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.parent_project}-auth-service-api"
  api_management_name   = data.azurerm_api_management.apim.name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_checkout_auth_service_v1.product_id]
  subscription_required = local.apim_checkout_auth_service.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.checkout_auth_service_api_v1.id
  api_version           = "v1"
  service_url           = local.apim_checkout_auth_service.service_url

  description  = local.apim_checkout_auth_service.description
  display_name = local.apim_checkout_auth_service.display_name
  path         = local.apim_checkout_auth_service.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/checkout/checkout_auth_service/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/checkout/checkout_auth_service/v1/_base_policy.xml.tpl", {
    ecommerce_ingress_hostname = var.ecommerce_ingress_hostname,
  })
}