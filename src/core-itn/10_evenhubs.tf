resource "azurerm_resource_group" "eventhub_ita_rg" {
  name     = local.eventhub_resource_group_name
  location = var.location

  tags = var.tags
}


module "eventhub_meucci" {
  source                   = "git::https://github.com/pagopa/terraform-azurerm-v3.git//eventhub?ref=v8.13.0"
  name                     = "${local.project}-evh-meucci"
  location                 = var.location
  resource_group_name      = azurerm_resource_group.eventhub_ita_rg.name
  auto_inflate_enabled     = var.ehns_auto_inflate_enabled
  sku                      = var.ehns_sku_name
  capacity                 = var.ehns_capacity
  maximum_throughput_units = var.ehns_maximum_throughput_units
  #zone_redundat is always true

  virtual_network_ids           = [module.vnet_italy[0].id, data.azurerm_virtual_network.vnet_core.id]
  private_endpoint_subnet_id    = azurerm_subnet.eventhubs_italy.id
  public_network_access_enabled = var.ehns_public_network_access
  private_endpoint_created      = var.ehns_private_endpoint_is_present

  private_endpoint_resource_group_name = azurerm_resource_group.eventhub_ita_rg.name

  private_dns_zones = {
    id                  = [data.azurerm_private_dns_zone.eventhub.id]
    name                = [data.azurerm_private_dns_zone.eventhub.name]
    resource_group_name = data.azurerm_resource_group.rg_event_private_dns_zone.name
  }

  private_dns_zone_record_A_name = "eventhub-meucci"

  action = [
    {
      action_group_id    = azurerm_monitor_action_group.slack.id
      webhook_properties = null
    },
    {
      action_group_id    = azurerm_monitor_action_group.email.id
      webhook_properties = null
    }
  ]

  metric_alerts_create = var.ehns_metric_alerts_create
  metric_alerts        = var.ehns_metric_alerts

  tags = var.tags
}


