module "eventhub_rtp_namespace" {
  source                   = "git::https://github.com/pagopa/terraform-azurerm-v3.git//eventhub?ref=v7.62.0"
  name                     = "${local.project}-evh-rtp"
  location                 = var.location_ita  # <-- italy north
  resource_group_name      = azurerm_resource_group.msg_rg.name
  auto_inflate_enabled     = var.ehns_auto_inflate_enabled
  sku                      = var.ehns_sku_name
  capacity                 = var.ehns_capacity
  maximum_throughput_units = var.ehns_maximum_throughput_units
  zone_redundant           = var.ehns_zone_redundant

  virtual_network_ids           = [module.vnet_integration.id, module.vnet.id]
  subnet_id                     = module.eventhub_snet.id
  eventhubs      = var.eventhubs_rtp
  public_network_access_enabled = var.ehns_public_network_access

  private_dns_zones = {
    id   = [azurerm_private_dns_zone.privatelink_servicebus_windows_net.id]
    name = [azurerm_private_dns_zone.privatelink_servicebus_windows_net.name]
  }
  private_dns_zone_record_A_name = "eventhub_rtp"

  alerts_enabled = false

  action = flatten([
    [
      {
        action_group_id    = azurerm_monitor_action_group.slack.id
        webhook_properties = null
      },
      {
        action_group_id    = azurerm_monitor_action_group.email.id
        webhook_properties = null
      }
    ],
    (var.env == "prod" ? [
      {
        action_group_id    = azurerm_monitor_action_group.infra_opsgenie.0.id
        webhook_properties = null
      }
    ] : [])
  ])

  tags = var.tags
}
