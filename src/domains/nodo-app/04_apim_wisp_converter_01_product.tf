##############
## Products ##
##############
module "apim_wisp_converter_product" {
  source = "./.terraform/modules/__v3__/api_management_product"
  count  = var.create_wisp_converter ? 1 : 0

  product_id   = "pagopa-wisp-converter"
  display_name = "WISP Converter"
  description  = "API set for WISP dismantling"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = false # subscription_required must be set on API
  approval_required     = false
  subscriptions_limit   = 0

  policy_xml = file("./api_product/_base_policy.xml")
}

resource "azurerm_api_management_product_group" "access_control_developers_for_wisp_converter" {
  count               = var.create_wisp_converter ? 1 : 0
  product_id          = module.apim_wisp_converter_product[0].product_id
  group_name          = data.azurerm_api_management_group.group_developers.name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

