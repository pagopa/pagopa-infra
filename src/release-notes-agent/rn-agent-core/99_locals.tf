
locals {
  product = "${var.prefix}-${var.env_short}"

  apim_snet        = "${local.product}-apim-snet"
  vnet_integration = "pagopa-${var.env_short}-vnet-integration"
  vnet_rg          = "pagopa-${var.env_short}-vnet-rg"

  # Monitoring
  monitor_resource_group_name  = "${local.product}-${var.location_short}-core-monitor-rg"
  application_insisght_name    = "${local.product}-${var.location_short}-core-appinsights"
  log_analytics_workspace_name = "${local.product}-${var.location_short}-core-law"

}
