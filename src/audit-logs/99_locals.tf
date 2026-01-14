locals {
  prefix            = "pagopa"
  product           = "${local.prefix}-${var.env_short}"
  domain            = "audit"
  project           = "${local.product}-${var.location_short}-${local.domain}"

  vnet_italy_name                = "${local.product}-itn-vnet"
  vnet_italy_resource_group_name = "${local.product}-itn-vnet-rg"
  vnet_core_resource_group_name  = "${local.product}-vnet-rg"
  vnet_core_name                 = "${local.product}-vnet"

  vnet_integration_resource_group_name = "${local.product}-vnet-rg"
  vnet_integration_name                = "${local.product}-vnet-integration"

  vnet_data_italy_name                = "${local.product}-itn-network-data-vnet"
  vnet_data_italy_resource_group_name = "${local.product}-itn-network-hub-spoke-rg"


  log_analytics_italy_workspace_name                = "${local.product}-itn-core-law"
  log_analytics_italy_workspace_resource_group_name = "${local.product}-itn-core-monitor-rg"

  log_analytics_weu_workspace_name                = "${local.product}-law"
  log_analytics_weu_workspace_resource_group_name = "${local.product}-monitor-rg"

  network_watcher_rg_name = "NetworkWatcherRG"

}

  