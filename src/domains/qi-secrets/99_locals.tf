locals {
  project           = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product           = "${var.prefix}-${var.env_short}"
  subscription_name = "${var.env}-${var.prefix}"

}
