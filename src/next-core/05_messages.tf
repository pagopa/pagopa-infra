resource "azurerm_private_dns_zone" "privatelink_servicebus_windows_net" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = local.msg_resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_core_link_privatelink_servicebus_windows_net" {

  name                  = "${local.product}-evh-ns01-private-dns-zone-link-02"
  resource_group_name   = local.msg_resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_servicebus_windows_net.name
  virtual_network_id    = data.azurerm_virtual_network.vnet_core.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_integration_link_privatelink_servicebus_windows_net" {

  name                  = "${local.product}-evh-ns01-private-dns-zone-link-01"
  resource_group_name   = local.msg_resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_servicebus_windows_net.name
  virtual_network_id    = data.azurerm_virtual_network.vnet_integration.id
  registration_enabled  = false

  tags = var.tags
}


//replaces ns01
module "event_hub03" {
  source                   = "git::https://github.com/pagopa/terraform-azurerm-v3.git//eventhub?ref=v7.62.0"
  name                     = "${local.project}-evh-ns03"
  location                 = var.location
  resource_group_name      = local.msg_resource_group_name
  auto_inflate_enabled     = var.ehns_auto_inflate_enabled
  sku                      = var.ehns_sku_name
  capacity                 = var.ehns_capacity
  maximum_throughput_units = var.ehns_maximum_throughput_units
  zone_redundant           = var.ehns_zone_redundant

  virtual_network_ids = [data.azurerm_virtual_network.vnet_integration.id, data.azurerm_virtual_network.vnet_core.id]
  subnet_id           = data.azurerm_subnet.eventhub_snet.id

  eventhubs = var.eventhubs_03

  public_network_access_enabled = var.ehns_public_network_access

  private_dns_zones = {
    id   = [azurerm_private_dns_zone.privatelink_servicebus_windows_net.id]
    name = [azurerm_private_dns_zone.privatelink_servicebus_windows_net.name]
  }
  private_dns_zone_record_A_name = "event_hub03"

  alerts_enabled = var.ehns_alerts_enabled
  metric_alerts  = var.ehns_metric_alerts
  action = [
    {
      action_group_id    = data.azurerm_monitor_action_group.slack.id
      webhook_properties = null
    },
    {
      action_group_id    = data.azurerm_monitor_action_group.email.id
      webhook_properties = null
    }
  ]

  tags = var.tags
}

//replaces ns02
module "event_hub04" {
  source                   = "git::https://github.com/pagopa/terraform-azurerm-v3.git//eventhub?ref=v7.62.0"
  name                     = "${local.project}-evh-ns04"
  location                 = var.location
  resource_group_name      = local.msg_resource_group_name
  auto_inflate_enabled     = var.ehns_auto_inflate_enabled
  sku                      = var.ehns_sku_name
  capacity                 = var.ehns_capacity
  maximum_throughput_units = var.ehns_maximum_throughput_units
  zone_redundant           = var.ehns_zone_redundant

  virtual_network_ids           = [data.azurerm_virtual_network.vnet_integration.id, data.azurerm_virtual_network.vnet_core.id]
  subnet_id                     = data.azurerm_subnet.eventhub_snet.id
  public_network_access_enabled = var.ehns_public_network_access
  private_dns_zones = {
    id   = [azurerm_private_dns_zone.privatelink_servicebus_windows_net.id]
    name = [azurerm_private_dns_zone.privatelink_servicebus_windows_net.name]
  }
  private_dns_zone_record_A_name = "event_hub04"

  eventhubs = var.eventhubs_04

  action = [
    {
      action_group_id    = data.azurerm_monitor_action_group.slack.id
      webhook_properties = null
    },
    {
      action_group_id    = data.azurerm_monitor_action_group.email.id
      webhook_properties = null
    }
  ]

  tags = var.tags
}


