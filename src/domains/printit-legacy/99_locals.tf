locals {
  project       = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  project_short = "${var.prefix}-${var.env_short}-${var.domain}"
  product       = "${var.prefix}-${var.env_short}"
}
