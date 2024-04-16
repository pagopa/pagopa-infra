locals {
  product        = "${var.prefix}-${var.env_short}"
  product_region = "${var.prefix}-${var.env_short}-${var.location_short}"
  product_ita    = "${var.prefix}-${var.env_short}-${var.location_short_ita}"
  project        = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  project_ita    = "${var.prefix}-${var.env_short}-${var.location_short_ita}-${var.domain}"

  monitor_appinsights_name        = "${local.product}-appinsights"
  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "PagoPA"

  ingress_hostname_prefix               = "${var.instance}.${var.domain}"
  internal_dns_zone_name                = "${var.dns_zone_internal_prefix}.${var.external_domain}"
  internal_dns_zone_resource_group_name = "${local.product}-vnet-rg"

  vnet_core_name                = "${local.product}-vnet"
  vnet_core_resource_group_name = "${local.product}-vnet-rg"

  data_resource_group_name = "${local.product}-data-rg"

  vnet_integration_name                = "${local.product}-vnet-integration"
  vnet_integration_resource_group_name = "${local.product}-vnet-rg"

  msg_resource_group_name = "${local.product}-msg-rg"

}
