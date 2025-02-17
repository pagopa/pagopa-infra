### resource group definition
resource "azurerm_resource_group" "qi_evh_resource_group" {
  name     = "pagopa-${var.env_short}-itn-qi-evh-rg"
  location = "Italy North"
}

module "eventhub_namespace_qi" {
  source                   = "git::https://github.com/pagopa/terraform-azurerm-v3.git//eventhub?ref=v8.22.0"
  name                     = "${local.project_itn}-evh"
  location                 = var.location_itn
  resource_group_name      = azurerm_resource_group.qi_evh_resource_group.name
  auto_inflate_enabled     = var.ehns_auto_inflate_enabled
  sku                      = var.ehns_sku_name
  capacity                 = var.ehns_capacity
  maximum_throughput_units = var.ehns_maximum_throughput_units
  #zone_redundat is always true

  virtual_network_ids           = [data.azurerm_virtual_network.vnet_italy.id]
  private_endpoint_subnet_id    = azurerm_subnet.eventhub_qi_snet.id
  public_network_access_enabled = var.ehns_public_network_access
  private_endpoint_created      = var.ehns_private_endpoint_is_present

  private_endpoint_resource_group_name = azurerm_resource_group.qi_evh_resource_group.name

  private_dns_zones = {
    id                  = [data.azurerm_private_dns_zone.eventhub.id]
    name                = [data.azurerm_private_dns_zone.eventhub.name]
    resource_group_name = data.azurerm_resource_group.rg_event_private_dns_zone.name
  }

  private_dns_zone_record_A_name = "${var.domain}.${var.location_short_itn}"

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

  metric_alerts_create = var.ehns_alerts_enabled
  metric_alerts        = var.ehns_metric_alerts_qi

  tags = var.tags
}

module "eventhub_qi_configuration" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//eventhub_configuration?ref=v8.22.0"

  event_hub_namespace_name                = module.eventhub_namespace_qi.name
  event_hub_namespace_resource_group_name = azurerm_resource_group.qi_evh_resource_group.name

  eventhubs = var.eventhubs_bdi
}