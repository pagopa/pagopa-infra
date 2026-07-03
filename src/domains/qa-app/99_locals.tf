locals {
  domain        = "qa"
  domain_short  = "qa"
  prefix        = "pagopa"
  product       = "${local.prefix}-${var.env_short}"
  project_short = "${local.prefix}-${var.env_short}-${var.location_short}-${local.domain_short}"
  project       = "${local.prefix}-${var.env_short}-${var.location_short}-${local.domain}"

  hub_vnet_name                            = "${local.product}-${var.location_short}-hub-vnet"
  hub_vnet_resource_group_name             = "${local.product}-${var.location_short}-network-hub-spoke-rg"
  spoke_data_vnet_name                     = "${local.product}-${var.location_short}-spoke-data-vnet"
  spoke_data_vnet_resource_group_name      = "${local.product}-${var.location_short}-network-hub-spoke-rg"
  spoke_security_vnet_name                 = "${local.product}-${var.location_short}-spoke-security-vnet"
  spoke_security_vnet_resource_group_name  = "${local.product}-${var.location_short}-network-hub-spoke-rg"
  spoke_streaming_vnet_name                = "${local.product}-${var.location_short}-spoke-streaming-vnet"
  spoke_streaming_vnet_resource_group_name = "${local.product}-${var.location_short}-network-hub-spoke-rg"
  spoke_compute_vnet_name                  = "${local.product}-${var.location_short}-vnet"
  spoke_compute_vnet_resource_group_name   = "${local.product}-${var.location_short}-vnet-rg"
  spoke_tools_vnet_name                    = "${local.product}-${var.location_short}-spoke-tools-vnet"
  spoke_tools_vnet_resource_group_name     = "${local.product}-${var.location_short}-network-hub-spoke-rg"
  private_dns_zone_rg_name                 = "${local.product}-vnet-rg"

  monitor_rg_name = "${local.product}-${var.location_short}-core-monitor-rg"

  log_analytics_workspace_name                = "${local.product}-${var.location_short}-core-law"
  log_analytics_workspace_resource_group_name = "${local.product}-${var.location_short}-core-monitor-rg"
  application_insight_name                    = "${local.product}-${var.location_short}-core-appinsights"

  monitor_resource_group_name        = "${local.product}-${var.location_short}-core-monitor-rg"
  monitor_action_group_slack_name    = "SlackPagoPA"
  monitor_action_group_email_name    = "PagoPA"
  monitor_action_group_opsgenie_name = "Opsgenie"

  internal_dns_zone_name                = "${var.dns_zone_internal_prefix}.${var.external_domain}"
  internal_dns_zone_resource_group_name = "${local.product}-vnet-rg"

  gh_runner_cae_name    = "${local.product}-${var.location_short}-core-tools-cae"
  gh_runner_cae_rg      = "${local.product}-${var.location_short}-core-tools-rg"
  gh_runner_pat_key     = "pagopa-platform-domain-github-bot-cd-pat"
  gh_runner_pat_kv_name = "${local.project_short}-kv"
  gh_runner_pat_kv_rg   = "${local.project}-sec-rg"


  apim_name    = "${local.product}-apim"
  apim_rg_name = "${local.product}-api-rg"

  pagopa_apim_name = "${local.product}-apim"
  pagopa_apim_rg   = "${local.product}-api-rg"

  apim_hostname = "api.${var.apim_dns_zone_prefix}.${var.external_domain}"
  qa_hostname   = "qa-central-hub.${var.location_short}.${local.internal_dns_zone_name}"

  ingress_hostname = "qa-central-hub.${var.location_short}"

  aks_name        = "${local.product}-${var.location_short}-${var.env}-aks"
  aks_rg_name     = "${local.product}-${var.location_short}-${var.env}-aks-rg"
  domain_hostname = "${var.dns_zone_prefix}.${local.internal_dns_zone_name}"

  qa_hub_rg_name = "${local.project}-qa-hub-rg"


}
