data "azurerm_private_dns_zone" "privatelink_blob_core_windows_net" {
  name = "privatelink.blob.core.windows.net"
}


data "azurerm_public_ip" "natgateway_public_ip" {
  count               = var.nat_gateway_public_ips
  name                = "${local.product}-natgw-pip-0${count.index + 1}"
  resource_group_name = azurerm_resource_group.rg_vnet.name
}
