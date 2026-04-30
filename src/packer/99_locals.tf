locals {
  product                       = "${var.prefix}-${var.env_short}"
  vnet_core_name                = "${local.product}-vnet"
  vnet_core_resource_group_name = "${local.product}-vnet-rg"
}
