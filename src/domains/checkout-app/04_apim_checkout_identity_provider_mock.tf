locals {
  apim_checkout_identity_provider_mock = {
    display_name          = "Checkout pagoPA identity provider mock"
    description           = "This APIM level API used to mock the identity provider in the testing environment."
    path                  = "checkout/identity-provider-mock"
    subscription_required = false
    service_url           = null
  }
}

module "apim_checkout_identity_provider_mock_product" {
  count  = var.env_short != "p" ? 1 : 0
  source = "./.terraform/modules/__v4__/api_management_product"

  product_id   = "checkout-identity-provider-mock"
  display_name = "Checkout identity provider mock"
  description  = "This API set contains APIM level APIs used to mock the identity provider in the testing environment."

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/checkout_identity_provider_mock/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "checkout_identity_provider_mock_version_set" {
  count = var.env_short != "p" ? 1 : 0

  name                = "${local.project_short}-identity-provider-mock-api"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim.name
  display_name        = local.apim_checkout_identity_provider_mock.display_name
  versioning_scheme   = "Segment"
}

module "apim_checkout_identity_provider_mock_v1" {
  count  = var.env_short != "p" ? 1 : 0
  source = "./.terraform/modules/__v4__/api_management_api"

  name                  = "${local.project_short}-identity-provider-mock-api"
  api_management_name   = data.azurerm_api_management.apim.name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_checkout_identity_provider_mock_product[0].product_id]
  subscription_required = local.apim_checkout_identity_provider_mock.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.checkout_identity_provider_mock_version_set[0].id
  api_version           = "v1"
  service_url           = local.apim_checkout_identity_provider_mock.service_url

  description  = local.apim_checkout_identity_provider_mock.description
  display_name = local.apim_checkout_identity_provider_mock.display_name
  path         = local.apim_checkout_identity_provider_mock.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/checkout/checkout_identity_provider_mock/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/checkout/checkout_identity_provider_mock/v1/_base_policy.xml.tpl", {
    checkout_ingress_hostname = var.checkout_ingress_hostname
  })
}