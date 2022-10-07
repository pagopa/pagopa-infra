locals {
  project                  = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product                  = "${var.prefix}-${var.env_short}"
  vnet_resource_group_name = "${local.product}-vnet-rg"
}
