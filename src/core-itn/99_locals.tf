locals {
  product     = "${var.prefix}-${var.env_short}"
  product_ita = "${var.prefix}-${var.env_short}-${var.location_short_ita}"
  project     = "${var.prefix}-${var.env_short}-${var.location_short_ita}-${var.domain}"

  monitor_appinsights_name        = "${local.product}-appinsights"
  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "PagoPA"

  vnet_name                = "${var.prefix}-${var.env_short}-${var.location_short}-vnet"
  vnet_resource_group_name = "${var.prefix}-${var.env_short}-${var.location_short}-vnet-rg"

  # peerings
  vnet_core_name                = "${local.product}-vnet"
  vnet_core_resource_group_name = "${local.product}-vnet-rg"

  vnet_integration_name                = "${local.product}-vnet-integration"
  vnet_integration_resource_group_name = "${local.product}-vnet-rg"

  cstar_vnet_rg_name = "cstar-${var.env_short}-weu-${var.env}01-vnet-rg"
  cstar_vnet_name    = "cstar-${var.env_short}-weu-${var.env}01-vnet"

}
