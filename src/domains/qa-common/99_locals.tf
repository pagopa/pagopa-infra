locals {
  domain        = "qa"
  domain_short  = "qa"
  prefix        = "pagopa"
  product       = "${local.prefix}-${var.env_short}"
  project_short = "${local.prefix}-${var.env_short}-${var.location_short}-${local.domain_short}"
  project       = "${local.prefix}-${var.env_short}-${var.location_short}-${local.domain}"


  hub_vnet_name = "${local.product}-${var.location_short}-hub-vnet"
  hub_vnet_resource_group_name = "${local.product}-${var.location_short}-network-hub-spoke-rg"
  spoke_data_vnet_name = "${local.product}-${var.location_short}-spoke-data-vnet"
  spoke_data_vnet_resource_group_name = "${local.product}-${var.location_short}-network-hub-spoke-rg"
  spoke_security_vnet_name = "${local.product}-${var.location_short}-spoke-security-vnet"
  spoke_security_vnet_resource_group_name = "${local.product}-${var.location_short}-network-hub-spoke-rg"
  spoke_streaming_vnet_name = "${local.product}-${var.location_short}-spoke-streaming-vnet"
  spoke_streaming_vnet_resource_group_name = "${local.product}-${var.location_short}-network-hub-spoke-rg"
  spoke_compute_vnet_name = "${local.product}-${var.location_short}-vnet"
  spoke_compute_vnet_resource_group_name = "${local.product}-${var.location_short}-vnet-rg"
  spoke_tools_vnet_name = "${local.product}-${var.location_short}-spoke-tools-vnet"
  spoke_tools_vnet_resource_group_name = "${local.product}-${var.location_short}-network-hub-spoke-rg"

  log_analytics_workspace_name                = "${local.product}-${var.location_short}-core-law"
  log_analytics_workspace_resource_group_name = "${local.product}-${var.location_short}-core-monitor-rg"

  monitor_resource_group_name = "${local.product}-${var.location_short}-core-monitor-rg"
  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "PagoPA"
  monitor_action_group_opsgenie_name = "Opsgenie"
  private_dns_zone_rg_name           = "${local.product}-vnet-rg"

  internal_dns_zone_name                = "${var.dns_zone_internal_prefix}.${var.external_domain}"
  internal_dns_zone_resource_group_name = "${local.product}-vnet-rg"

  aks_name = "${local.product}-${var.location_short}-${var.env}-aks"
  aks_rg_name = "${local.product}-${var.location_short}-${var.env}-aks-rg"
  ingress_hostname = "${var.location_short}.${local.domain}"

}