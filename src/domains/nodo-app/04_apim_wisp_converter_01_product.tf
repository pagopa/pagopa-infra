##############
## Products ##
##############
module "apim_wisp_converter_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v5.1.0"
  count  = var.create_wisp_converter ? 1 : 0

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
  count               = var.create_wisp_converter ? 1 : 0
  product_id          = module.apim_wisp_converter_product[0].product_id
  group_name          = data.azurerm_api_management_group.group_developers.name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

#################
## Named Value ##
#################
resource "azurerm_api_management_named_value" "enable_wisp_dismantling_switch_named_value" {
  name                = "enable-wisp-dismantling-switch"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "enable-wisp-dismantling-switch"
  value               = var.create_wisp_converter && var.wisp_converter.enable_apim_switch
}

resource "azurerm_api_management_named_value" "wisp_brokerPSP_whitelist_named_value" {
  name                = "wisp-brokerPSP-whitelist"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "wisp-brokerPSP-whitelist"
  value               = var.wisp_converter.brokerPSP_whitelist
}

resource "azurerm_api_management_named_value" "wisp_channel_whitelist_named_value" {
  name                = "wisp-channel-whitelist"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "wisp-channel-whitelist"
  value               = var.wisp_converter.channel_whitelist
}

resource "azurerm_api_management_named_value" "wisp_station_whitelist_named_value" {
  name                = "wisp-station-whitelist"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "wisp-station-whitelist"
  value               = var.wisp_converter.station_whitelist
}

resource "azurerm_api_management_named_value" "wisp_dismantling_primitives" {
  name                = "wisp-dismantling-primitives"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "wisp-dismantling-primitives"
  value               = var.wisp_converter.dismantling_primitives
}

resource "azurerm_api_management_named_value" "wisp_dismantling_backend_url" {
  name                = "wisp-dismantling-backend-url"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "wisp-dismantling-backend-url"
  value               = "https://${local.nodo_hostname}/wisp-soap-converter"
}

resource "azurerm_api_management_named_value" "wisp_dismantling_converter_base_url" {
  name                = "wisp-dismantling-converter-base-url"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "wisp-dismantling-converter-base-url"
  value               = "https://${local.nodo_hostname}/pagopa-wisp-converter"
}
