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

  monitor_action_group_slack_name    = "SlackPagoPA"
  monitor_action_group_email_name    = "PagoPA"
  monitor_action_group_opsgenie_name = "InfraOpsgenie"
  monitor_appinsights_name           = "${local.product}-appinsights"

  vnet_name                = "${local.product}-vnet"
  vnet_resource_group_name = "${local.product}-vnet-rg"

  acr_name                = replace(format("%s-common-acr", local.product), "-", "")
  acr_resource_group_name = "${local.product}-container-registry-rg"

  aks_name = "${local.project}-aks"

  vnet_integration_resource_group_name = "${local.product}-vnet-rg"
  vnet_integration_name                = "${local.product}-vnet-integration"

  # VNET
  vnet_core_resource_group_name = "${local.product}-vnet-rg"
  vnet_core_name                = "${local.product}-vnet"

  aks_logs_alerts = {}
}
