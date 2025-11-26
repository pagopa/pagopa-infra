data "azurerm_resource_group" "rg_api" {
  name = format("%s-api-rg", local.product)
}

data "azurerm_api_management" "apim" {
  name                = "${local.product}-apim"
  resource_group_name = data.azurerm_resource_group.rg_api.name
}


data "azurerm_monitor_action_group" "opsgenie" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_opsgenie_name
}

data "azurerm_resource_group" "identity_rg" {
  name = "${local.product}-identity-rg"
}
