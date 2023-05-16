locals {
  project        = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  parent_project = "${var.prefix}-${var.env_short}"
  product        = "${var.prefix}-${var.env_short}"

  monitor_appinsights_name = "${local.product}-appinsights"
}
