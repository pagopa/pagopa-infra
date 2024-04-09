##############
## Products ##
##############
module "apim_wisp_converter_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v5.1.0"
  count  = var.enable_wisp_converter ? 1 : 0

  product_id   = "pagopa-wisp-converter"
  display_name = "WISP Converter"
  description  = "API set for WISP dismantling"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = false # subscription_required must be set on API
  approval_required     = false
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

resource "azurerm_api_management_product_group" "access_control_developers_for_wisp_converter" {
  count               = var.enable_wisp_converter ? 1 : 0
  product_id          = module.apim_wisp_converter_product[0].product_id
  group_name          = data.azurerm_api_management_group.group_developers.name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

#################
## Named Value ##
#################
resource "azurerm_api_management_named_value" "is_wisp_converter_enabled_named_value" {
  name                = "is-wisp-converter-enabled"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = replace("Enabler for WISP dismantling", " ", "_")
  #value               = var.enable_wisp_converter
  value = false
}

resource "azurerm_api_management_named_value" "wisp_brokerPSP_whitelist_named_value" {
  name                = "wisp-brokerPSP-whitelist"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = replace("List of brokerPSPs handled by WISP dismantling", " ", "_")
  value               = var.wisp_converter.brokerPSP_whitelist
}

resource "azurerm_api_management_named_value" "wisp_channel_whitelist_named_value" {
  name                = "wisp-channel-whitelist"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = replace("List of channels handled by WISP dismantling", " ", "_")
  value               = var.wisp_converter.channel_whitelist
}
