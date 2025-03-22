locals {
  project = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product = "${var.prefix}-${var.env_short}"

  app_insights_ips_west_europe = [
    "51.144.56.96/28",
    "51.144.56.112/28",
    "51.144.56.128/28",
    "51.144.56.144/28",
    "51.144.56.160/28",
    "51.144.56.176/28",
  ]

  monitor_appinsights_name        = "${local.product}-appinsights"
  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "PagoPA"

  vnet_name                = "${local.product}-vnet"
  vnet_resource_group_name = "${local.product}-vnet-rg"

  key_vault_name    = "pagopa-${var.env_short}-kv"
  key_vault_rg_name = "pagopa-${var.env_short}-sec-rg"

}
