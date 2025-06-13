resource "azurerm_resource_group" "rtp_rg" {
  name     = local.rtp_resource_group_name
  location = var.location_ita

  tags = module.tag_config.tags
}


module "eventhub_rtp_namespace" {
  source                   = "./.terraform/modules/__v3__/eventhub"
  name                     = "${local.project_itn}-rtp-evh"
  location                 = var.location_ita # <-- italy north
  resource_group_name      = azurerm_resource_group.rtp_rg.name
  auto_inflate_enabled     = var.eventhub_namespace_rtp.auto_inflate_enabled
  sku                      = var.eventhub_namespace_rtp.sku_name
  capacity                 = var.eventhub_namespace_rtp.capacity
  maximum_throughput_units = var.eventhub_namespace_rtp.maximum_throughput_units
  #zone_redundat is always true

  virtual_network_ids           = [data.azurerm_virtual_network.vnet_italy.id]
  public_network_access_enabled = var.eventhub_namespace_rtp.public_network_access
  private_endpoint_subnet_id    = data.azurerm_subnet.common_itn_private_endpoint_subnet.id
  private_endpoint_created      = var.eventhub_namespace_rtp.private_endpoint_created

  private_endpoint_resource_group_name = azurerm_resource_group.rtp_rg.name

  private_dns_zones = {
    id                  = [data.azurerm_private_dns_zone.privatelink_servicebus_windows_net.id]
    name                = [data.azurerm_private_dns_zone.privatelink_servicebus_windows_net.name]
    resource_group_name = data.azurerm_resource_group.rg_event_private_dns_zone.name
  }

  private_dns_zone_record_A_name = "${var.domain}.${var.location_short_ita}.eventhub_rtp"

  eventhubs = var.eventhubs_rtp

  action = flatten([
    [
      {
        action_group_id    = data.azurerm_monitor_action_group.slack.id
        webhook_properties = null
      },
      {
        action_group_id    = data.azurerm_monitor_action_group.email.id
        webhook_properties = null
      }
    ],
    (var.env == "prod" ? [
      {
        action_group_id    = data.azurerm_monitor_action_group.opsgenie.0.id
        webhook_properties = null
      }
    ] : [])
  ])

  metric_alerts_create = var.eventhub_namespace_rtp.metric_alerts_create
  metric_alerts        = var.eventhub_namespace_rtp.metric_alerts

  tags = module.tag_config.tags
}


module "eventhub_rtp_namespace_integration" {
  source                   = "./.terraform/modules/__v3__/eventhub"
  name                     = "${local.project_itn}-rtp-integration-evh"
  location                 = var.location_ita # <-- italy north
  resource_group_name      = azurerm_resource_group.rtp_rg.name
  auto_inflate_enabled     = var.eventhub_namespace_rtp.auto_inflate_enabled
  sku                      = var.eventhub_namespace_rtp.sku_name
  capacity                 = var.eventhub_namespace_rtp.capacity
  maximum_throughput_units = var.eventhub_namespace_rtp.maximum_throughput_units
  #zone_redundat is always true

  virtual_network_ids           = [data.azurerm_virtual_network.vnet_italy_cstar_integration.id]
  public_network_access_enabled = false
  private_endpoint_subnet_id    = data.azurerm_subnet.common_itn_cstar_integration_private_endpoint_subnet.id
  private_endpoint_created      = var.eventhub_namespace_rtp.private_endpoint_created

  private_endpoint_resource_group_name = azurerm_resource_group.rtp_rg.name

  private_dns_zones = {
    id                  = [data.azurerm_private_dns_zone.privatelink_servicebus_windows_net.id]
    name                = [data.azurerm_private_dns_zone.privatelink_servicebus_windows_net.name]
    resource_group_name = data.azurerm_resource_group.rg_event_private_dns_zone.name
  }

  private_dns_zone_record_A_name = "${var.domain}.${var.location_short_ita}.integration.eventhub_rtp"

  eventhubs = var.eventhubs_rtp

  action = flatten([
    [
      {
        action_group_id    = data.azurerm_monitor_action_group.slack.id
        webhook_properties = null
      },
      {
        action_group_id    = data.azurerm_monitor_action_group.email.id
        webhook_properties = null
      }
    ],
    (var.env == "prod" ? [
      {
        action_group_id    = data.azurerm_monitor_action_group.opsgenie.0.id
        webhook_properties = null
      }
    ] : [])
  ])

  metric_alerts_create = var.eventhub_namespace_rtp.metric_alerts_create
  metric_alerts        = var.eventhub_namespace_rtp.metric_alerts

  tags = module.tag_config.tags
}
