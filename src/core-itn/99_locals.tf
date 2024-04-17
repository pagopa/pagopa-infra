locals {
  product        = "${var.prefix}-${var.env_short}"
  product_ita    = "${var.prefix}-${var.env_short}-${var.location_short_ita}"
  project        = "${var.prefix}-${var.env_short}-${var.location_short_ita}-${var.domain}"
#   project_ita    = "${var.prefix}-${var.env_short}-${var.location_short_ita}-${var.domain}"

#   monitor_appinsights_name        = "${local.product}-appinsights"
  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "PagoPA"

  vnet_core_name                = "${local.product}-vnet"
  vnet_core_resource_group_name = "${local.product}-vnet-rg"

  msg_resource_group_name = "${local.product}-msg-rg"
  eventhub_resource_group_name = "${local.product_ita}-evenhub-rg"

}
