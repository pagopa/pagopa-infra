module "event_hub03" {
  source                   = "git::https://github.com/pagopa/terraform-azurerm-v3.git//eventhub?ref=v7.62.0"
  name                     = format("%s-evh-ns03", local.project)
  location                 = var.location
  resource_group_name      = "pagopa-u-msg-rg"
  auto_inflate_enabled     = var.ehns_auto_inflate_enabled
  sku                      = var.ehns_sku_name
  capacity                 = var.ehns_capacity
  maximum_throughput_units = var.ehns_maximum_throughput_units
  zone_redundant           = var.ehns_zone_redundant

  virtual_network_ids = [module.vnet_integration.id, module.vnet.id]
  subnet_id           = data.azurerm_subnet.eventhub_snet.subnet_id

  private_dns_zones              = module.event_hub01.private_dns_zone
  private_dns_zone_record_A_name = "event_hub02"

  eventhubs = var.eventhubs_03

  # action = [
  #   {
  #     action_group_id    = azurerm_monitor_action_group.slack.id
  #     webhook_properties = null
  #   },
  #   {
  #     action_group_id    = azurerm_monitor_action_group.email.id
  #     webhook_properties = null
  #   }
  # ]

  tags = var.tags
}
