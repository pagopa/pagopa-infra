locals {
  apim_checkout_npg_sdk = {
    display_name          = "Checkout pagoPA NPG SDK resource apis"
    description           = "Api used to retrieve NPG sdk object and SRI informations"
    path                  = "checkout/npg/sdk"
    subscription_required = false
    service_url           = null
  }
}

module "apim_checkout_npg_sdk" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "checkout-npg-sdk"
  display_name = "Checkout NPG SDK wrapper api"
  description  = "Collection of APIs related to NPG sdk."

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = local.apim_checkout_npg_sdk.subscription_required
  approval_required     = false

  policy_xml = file("./api_product/checkout/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "checkout_npg_sdk_api_v1" {
  name                = "${local.project_short}-npg-sdk-resource-api"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim.name
  display_name        = local.apim_checkout_npg_sdk.display_name
  versioning_scheme   = "Segment"
}

module "apim_checkout_npg_sdk_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.project_short}-npg-sdk-resource-api"
  api_management_name   = data.azurerm_api_management.apim.name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_checkout_npg_sdk.product_id]
  subscription_required = local.apim_checkout_npg_sdk.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.checkout_npg_sdk_api_v1.id
  api_version           = "v1"
  service_url           = local.apim_checkout_npg_sdk.service_url

  description  = local.apim_checkout_npg_sdk.description
  display_name = local.apim_checkout_npg_sdk.display_name
  path         = local.apim_checkout_npg_sdk.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/checkout/checkout_npg_sdk/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/checkout/checkout_npg_sdk/v1/_base_policy.xml.tpl", {
    checkout_origin = "https://${var.dns_zone_checkout}.${var.external_domain}"
  })
}

resource "azurerm_api_management_api_operation_policy" "checkout_get_sdk_api_v1" {
  depends_on = [
    module.apim_checkout_npg_sdk_v1
  ]
  api_name            = "${local.project_short}-npg-sdk-resource-api-v1"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  operation_id        = "getSdk"

  xml_content = templatefile("./api/checkout/checkout_npg_sdk/v1/_get_sdk_from_npg.xml.tpl", {
    npg_hostname = local.npg_sdk_hostname
  })
}
resource "azurerm_api_management_api_operation_policy" "checkout_get_sdk_sri_info_api_v1" {
  depends_on = [
    module.apim_checkout_npg_sdk_v1
  ]
  api_name            = "${local.project_short}-npg-sdk-resource-api-v1"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  operation_id        = "getSdkSriInfo"

  xml_content = templatefile("./api/checkout/checkout_npg_sdk/v1/_get_sdk_sri.xml.tpl", {
    npg_hostname = local.npg_sdk_hostname
  })
}

#TODO aggiungere named value per api key NPG pagopa