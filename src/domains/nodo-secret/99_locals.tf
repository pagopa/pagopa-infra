locals {
  project = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product = "${var.prefix}-${var.env_short}"

  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "PagoPA"

  azdo_app_managed_identity_name    = "${var.env}-pagopa"
  azdo_app_managed_identity_rg_name = "pagopa-${var.env_short}-identity-rg"
}
