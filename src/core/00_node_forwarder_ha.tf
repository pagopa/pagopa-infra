data "azurerm_app_service" "node_forwarder_ha" {
  count               = var.enabled_features.node_forwarder_ha ? 1 : 0
  name                = "${local.project}-${var.location_short}-core-app-node-forwarder-ha"
  resource_group_name = "${local.project}-node-forwarder-rg"
}

data "azurerm_app_service" "node_forwarder" {
  count               = var.enabled_features.node_forwarder_ha ? 0 : 1
  name                = "${local.project}-${var.location_short}-core-app-node-forwarder"
  resource_group_name = "${local.project}-node-forwarder-rg"
}


