locals {
  apim_checkout_auth_service = {
    display_name          = "Checkout pagoPA Auth Service"
    description           = "This microservice that expose authService services to allow authenticaded flow."
    path                  = "checkout/auth-service"
    subscription_required = false
    service_url           = null
  }
}

module "apim_checkout_authentication" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "checkout-authentication"
  display_name = "Checkout Authentication"
  description  = "Collection of APIs related to the authenticaded flow."

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/checkout-authentication/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "checkout_auth_service_api_v1" {
  name                = "${local.project_short}-auth-service-api"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim.name
  display_name        = local.apim_checkout_auth_service.display_name
  versioning_scheme   = "Segment"
}

module "apim_checkout_auth_service_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.project_short}-auth-service-api"
  api_management_name   = data.azurerm_api_management.apim.name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_checkout_authentication.product_id]
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
    checkout_ingress_hostname = var.checkout_ingress_hostname,
    checkout_origin           = "https://${var.dns_zone_checkout}.${var.external_domain}"
  })
}

resource "azurerm_api_management_api_operation_policy" "checkout_auth_login_api" {
  api_name            = "${local.project_short}-auth-service-api-v1"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  operation_id        = "authLogin"

  xml_content = file("./api/checkout/checkout_auth_service/v1/_recaptcha_check.xml.tpl")
}

resource "azurerm_api_management_api_operation_policy" "checkout_auth_get_users_api" {
  api_name            = "${local.project_short}-auth-service-api-v1"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  operation_id        = "authUsers"

  xml_content = file("./api/checkout/checkout_auth_service/v1/_get_user_filter.xml.tpl")
}
