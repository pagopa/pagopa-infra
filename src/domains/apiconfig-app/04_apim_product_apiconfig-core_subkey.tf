module "apim_apiconfig_core_subkey_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.4.1"

  product_id   = "${local.apiconfig_core_locals.product_id}-subkey"
  display_name = "${local.apiconfig_core_locals.display_name} - Subkey"
  description  = local.apiconfig_core_locals.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = local.apiconfig_core_locals.subscription_required
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}


resource "azurerm_api_management_product_group" "access_control_developers" {
  product_id          = module.apim_apiconfig_core_subkey_product.product_id
  group_name          = data.azurerm_api_management_group.group_developers.name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

resource "azurerm_api_management_product_group" "access_control_guests" {
  product_id          = module.apim_apiconfig_core_subkey_product.product_id
  group_name          = data.azurerm_api_management_group.group_guests.name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}
