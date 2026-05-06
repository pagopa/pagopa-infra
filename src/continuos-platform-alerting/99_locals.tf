locals {
  prefix  = "pagopa"
  product = "${local.prefix}-${var.env_short}"
  domain  = "core"
  project = "${local.product}-${var.location_short}-${local.domain}"

  vnet_italy_name                = "${local.product}-itn-vnet"
  vnet_italy_resource_group_name = "${local.product}-itn-vnet-rg"
  vnet_core_resource_group_name  = "${local.product}-vnet-rg"
  vnet_core_name                 = "${local.product}-vnet"

  vnet_integration_resource_group_name = "${local.product}-vnet-rg"
  vnet_integration_name                = "${local.product}-vnet-integration"

  vnet_data_italy_name                = "${local.product}-itn-spoke-data-vnet"
  vnet_data_italy_resource_group_name = "${local.product}-itn-network-hub-spoke-rg"


  log_analytics_italy_workspace_name                = "${local.product}-itn-core-law"
  log_analytics_italy_workspace_resource_group_name = "${local.product}-itn-core-monitor-rg"

  log_analytics_weu_workspace_name                = "${local.product}-law"
  log_analytics_weu_workspace_resource_group_name = "${local.product}-monitor-rg"

  network_watcher_rg_name = "NetworkWatcherRG"

  alerting_domains = ["gps", "fdr", "nodo", "crusc8", "paywallet", "core"]

  azure_postgresql_resource_type = "Microsoft.DBforPostgreSQL/flexibleServers"
  azure_redis_resource_type = "Microsoft.Cache/Redis"

  monitor_resource_group_name = "${local.product}-monitor-rg"

  global_custom_action_group = [
    {
      key              = "default"
      action_groups    = [
        { action_group_name = "PagoPA", resource_group_name = local.monitor_resource_group_name },
        { action_group_name = "SlackPagoPA", resource_group_name = local.monitor_resource_group_name }
      ]
    },
    {
      key              = "${local.product}-redis-active_connections"
      action_groups    = [
        { action_group_name = "pagopa-d-cloudo-trigger", resource_group_name = "${local.product}-itn-cloudo-rg" },
        { action_group_name = "PagoPA", resource_group_name = local.monitor_resource_group_name }
      ]
    }
  ]
}

  