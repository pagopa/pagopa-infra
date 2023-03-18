locals {
  project = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product = var.location_short != "neu" ? "${var.prefix}-${var.env_short}" : "${var.prefix}-${var.env_short}-${var.location_short}"
  product_noenv = "${var.prefix}-${var.env_short}"


  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "PagoPA"
}
