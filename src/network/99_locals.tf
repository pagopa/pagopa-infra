locals {
  prefix                     = "pagopa"
  product                    = "${local.prefix}-${var.env_short}"
  domain                     = "network"
  project                    = "${local.product}-${var.location_short}-${local.domain}"
  project_hub_spoke          = "${local.product}-${var.location_short_hub_spoke}-${local.domain}"
  product_location_hub_spoke = "${local.product}-${var.location_short_hub_spoke}"

  vnet_italy_name                = "${local.product}-itn-vnet"
  vnet_italy_resource_group_name = "${local.product}-itn-vnet-rg"
  vnet_core_resource_group_name  = "${local.product}-vnet-rg"
  vnet_core_name                 = "${local.product}-vnet"

  vnet_integration_resource_group_name = "${local.product}-vnet-rg"
  vnet_integration_name                = "${local.product}-vnet-integration"

  log_analytics_italy_workspace_name                = "${local.product}-itn-core-law"
  log_analytics_italy_workspace_resource_group_name = "${local.product}-itn-core-monitor-rg"

  log_analytics_weu_workspace_name                = "${local.product}-law"
  log_analytics_weu_workspace_resource_group_name = "${local.product}-monitor-rg"

  network_watcher_rg_name = "NetworkWatcherRG"

  flow_log_retention_days = 20
  external_domain         = "pagopa.it"

  nsg_network_regions = {
    westeurope = {
      short_name = "weu"
      vnets = {
        "${local.vnet_core_name}"  = local.vnet_core_resource_group_name
        "${local.vnet_italy_name}" = local.vnet_italy_resource_group_name
      }
      log_analytics_workspace_name = local.log_analytics_weu_workspace_name
      log_analytics_workspace_rg   = local.log_analytics_weu_workspace_resource_group_name
      nsg                          = local.westeurope_nsg
    }
    italynorth = {
      short_name = "itn"
      vnets = {
        "${local.vnet_core_name}"  = local.vnet_core_resource_group_name
        "${local.vnet_italy_name}" = local.vnet_italy_resource_group_name
      }
      log_analytics_workspace_name = local.log_analytics_italy_workspace_name
      log_analytics_workspace_rg   = local.log_analytics_italy_workspace_resource_group_name
      nsg                          = local.italynorth_nsg
    }
  }


  hub_spoke_vnet = {
    hub = {
      address_space_secret_key = "address-space-vnet-hub"
      peer_with                = []
    }
    spoke-data = {
      address_space_secret_key = "address-space-spoke-data"
      peer_with                = ["hub"]
    }
    spoke-security = {
      address_space_secret_key = "address-space-spoke-security"
      peer_with                = ["hub"]
    }
    spoke-tools = {
      address_space_secret_key = "address-space-spoke-tools"
      peer_with                = ["hub", "spoke-data", "spoke-security", "spoke-streaming"]
    }
    spoke-streaming = {
      address_space_secret_key = "address-space-spoke-streaming"
      peer_with                = ["hub"]
    }
    # compute vnet is inherited from core itn vnet
    # fe vnet in westeurope, not movable (apim + appgw)
  }


}
