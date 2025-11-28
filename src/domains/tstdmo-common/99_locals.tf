locals {
  domain        = "tstdmo"
  prefix        = "pagopa"
  product       = "${local.prefix}-${var.env_short}"
  project_short = "${local.prefix}-${var.env_short}-${local.domain}"
  project       = "${local.prefix}-${var.env_short}-${var.location_short}-${local.domain}"
  vnet_name = "${local.product}-${var.location_short}-vnet"
  vnet_resource_group_name = "${local.product}-${var.location_short}-vnet-rg"

  log_analytics_workspace_name                = "${local.product}-${var.location_short}-core-law"
  log_analytics_workspace_resource_group_name = "${local.product}-${var.location_short}-core-monitor-rg"

  monitor_resource_group_name = "${local.product}-${var.location_short}-core-monitor-rg"
  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "PagoPA"
  monitor_action_group_opsgenie_name = "Opsgenie"


  internal_dns_zone_name                = "${var.dns_zone_internal_prefix}.${var.external_domain}"
  internal_dns_zone_resource_group_name = "${local.product}-vnet-rg"

  aks_name = "${local.product}-${var.location_short}-${var.env}-aks"
  aks_rg_name = "${local.product}-${var.location_short}-${var.env}-aks-rg"
  ingress_hostname = "${var.location_short}.${local.domain}"

}