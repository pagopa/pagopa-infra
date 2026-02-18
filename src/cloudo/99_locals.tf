
locals {
  product        = "${var.prefix}-${var.env_short}"
  product_region = "${var.prefix}-${var.env_short}-${var.location_short}"
  product_ita    = "${var.prefix}-${var.env_short}-${var.location_short_ita}"
}
