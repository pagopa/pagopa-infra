data "azurerm_api_management" "apim" {
  name                = "${local.product}-apim"
  resource_group_name = "${local.product}-api-rg"
}

data "azurerm_resource_group" "identity_rg" {
  name = "${local.product}-identity-rg"
}

data "azurerm_app_service" "node_forwarder_ha" {
  count               = var.enabled_features.node_forwarder_ha ? 1 : 0
  name                = "${local.product}-${var.location_short}-core-app-node-forwarder-ha"
  resource_group_name = "${local.product}-node-forwarder-rg"
}

data "azurerm_app_service" "node_forwarder" {
  count               = var.enabled_features.node_forwarder_ha ? 0 : 1
  name                = "${local.product}-${var.location_short}-core-app-node-forwarder"
  resource_group_name = "${local.product}-node-forwarder-rg"
}

