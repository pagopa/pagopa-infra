locals {
  prefix  = "pagopa"
  product = "${local.prefix}-${var.env_short}"
  domain  = "network"
  project = "${local.product}-${var.location_short}-${local.domain}"

  vnet_italy_name                = "${local.product}-itn-vnet"
  vnet_italy_resource_group_name = "${local.product}-itn-vnet-rg"
  vnet_core_resource_group_name  = "${local.product}-vnet-rg"
  vnet_core_name                 = "${local.product}-vnet"



  log_analytics_italy_workspace_name                = "${local.product}-itn-core-law"
  log_analytics_italy_workspace_resource_group_name = "${local.product}-itn-core-monitor-rg"

  log_analytics_weu_workspace_name                = "${local.product}-law"
  log_analytics_weu_workspace_resource_group_name = "${local.product}-monitor-rg"

  network_watcher_rg_name = "NetworkWatcherRG"

  flow_log_retention_days = 20


  nsg_network_regions = {
    westeurope = {
      short_name = "weu"
      vnets = [
        {
          name    = local.vnet_core_name
          rg_name = local.vnet_core_resource_group_name
        },
        {
          name    = local.vnet_italy_name
          rg_name = local.vnet_italy_resource_group_name
        }
      ]
      log_analytics_workspace_name = local.log_analytics_weu_workspace_name
      log_analytics_workspace_rg   = local.log_analytics_weu_workspace_resource_group_name
      nsg                          = local.westeurope_nsg
    }
    italynorth = {
      short_name = "itn"
      vnets = [
        {
          name    = local.vnet_italy_name
          rg_name = local.vnet_italy_resource_group_name
        },
        {
          name    = local.vnet_core_name
          rg_name = local.vnet_core_resource_group_name
        }
      ]
      log_analytics_workspace_name = local.log_analytics_italy_workspace_name
      log_analytics_workspace_rg   = local.log_analytics_italy_workspace_resource_group_name
      nsg                          = local.italynorth_nsg
    }
  }


}
