
data "azurerm_key_vault" "key_vault" {
  name                = "${local.product}-kv"
  resource_group_name = "${local.product}-sec-rg"
}

data "azurerm_virtual_network" "network_tools_vnet" {
  name                = "${var.prefix}-${var.env_short}-${var.location_short}-spoke-tools-vnet"
  resource_group_name = "${var.prefix}-${var.env_short}-${var.location_short}-network-hub-spoke-rg"
}

data "azurerm_subnet" "apim_vnet" {
  name                 = local.apim_snet
  resource_group_name  = local.vnet_rg
  virtual_network_name = local.vnet_integration
}

data "azurerm_private_dns_zone" "blob_storage" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = local.vnet_rg
}