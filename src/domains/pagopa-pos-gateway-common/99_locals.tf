locals {
  domain        = "pagopa-pos-gateway"
  domain_short  = "ppg"
  prefix        = "pagopa"
  product       = "${local.prefix}-${var.env_short}"
  project_short = "${local.prefix}-${var.env_short}-${var.location_short}-${local.domain_short}"
  project       = "${local.prefix}-${var.env_short}-${var.location_short}-${local.domain}"


  hub_vnet_name = ""
  hub_vnet_resource_group_name = ""
  spoke_data_vnet_name = ""
  spoke_data_vnet_resource_group_name = ""
  spoke_security_vnet_name = ""
  spoke_security_vnet_resource_group_name = ""
  spoke_streaming_vnet_name = ""
  spoke_streaming_vnet_resource_group_name = ""
  spoke_compute_vnet_name = ""
  spoke_compute_vnet_resource_group_name = ""
  spoke_tools_vnet_name = ""
  spoke_tools_vnet_resource_group_name = ""

  log_analytics_workspace_name                = ""
  log_analytics_workspace_resource_group_name = ""

  monitor_resource_group_name = ""
  monitor_action_group_slack_name = ""
  monitor_action_group_email_name = ""
  monitor_action_group_opsgenie_name = ""
  private_dns_zone_rg_name           = ""

  internal_dns_zone_name                = "${var.dns_zone_internal_prefix}.${var.external_domain}"
  internal_dns_zone_resource_group_name = ""

  aks_name = ""
  aks_rg_name = ""
  ingress_hostname = "${var.location_short}.${local.domain}"

}