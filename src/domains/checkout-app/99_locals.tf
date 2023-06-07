locals {
  project        = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product        = "${var.prefix}-${var.env_short}"
  parent_project = "${var.prefix}-${var.env_short}"

  monitor_appinsights_name        = "${local.product}-appinsights"
  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "PagoPA"

  apim_hostname = "api.${var.apim_dns_zone_prefix}.${var.external_domain}"
}