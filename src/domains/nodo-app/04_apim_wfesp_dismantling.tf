#################
## Named Value ##
#################
resource "azurerm_api_management_named_value" "wfesp_channel_list_named_value" {
  name                = "wfesp-channels"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "wfesp-channels"
  value               = var.wfesp_dismantling.channel_list
}

resource "azurerm_api_management_named_value" "wfesp_fixed_url_named_value" {
  name                = "wfesp-fixed-url"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "wfesp-fixed-url"
  value               = var.wfesp_dismantling.wfesp_fixed_url
}