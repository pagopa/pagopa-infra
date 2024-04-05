resource "azurerm_resource_group" "msg_rg" {
  name     = format("%s-msg-rg", local.project)
  location = var.location

  tags = var.tags
}

## Eventhub subnet
module "eventhub_snet" {
  count                                          = var.eventhub_enabled && var.cidr_subnet_eventhub != null ? 1 : 0
  source                                         = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.76.0"
  name                                           = format("%s-eventhub-snet", local.project)
  address_prefixes                               = var.cidr_subnet_eventhub
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet_integration.name
  service_endpoints                              = ["Microsoft.EventHub"]
  enforce_private_link_endpoint_network_policies = true
}

module "event_hub01" {
  source                   = "git::https://github.com/pagopa/terraform-azurerm-v3.git//eventhub?ref=v7.76.0"
  name                     = format("%s-evh-ns01", local.project)
  location                 = var.location
  resource_group_name      = azurerm_resource_group.msg_rg.name
  auto_inflate_enabled     = var.ehns_auto_inflate_enabled
  sku                      = var.ehns_sku_name
  capacity                 = var.ehns_capacity
  maximum_throughput_units = var.ehns_maximum_throughput_units
  zone_redundant           = var.ehns_zone_redundant

  virtual_network_ids = [module.vnet_integration.id, module.vnet.id]
  subnet_id           = module.eventhub_snet[0].id

  eventhubs = var.eventhubs

  alerts_enabled = var.ehns_alerts_enabled
  metric_alerts  = var.ehns_metric_alerts
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

  tags = var.tags
}

module "event_hub02" {
  source                   = "git::https://github.com/pagopa/terraform-azurerm-v3.git//eventhub?ref=v7.76.0"
  name                     = format("%s-evh-ns02", local.project)
  location                 = var.location
  resource_group_name      = azurerm_resource_group.msg_rg.name
  auto_inflate_enabled     = var.ehns_auto_inflate_enabled
  sku                      = var.ehns_sku_name
  capacity                 = var.ehns_capacity
  maximum_throughput_units = var.ehns_maximum_throughput_units
  zone_redundant           = var.ehns_zone_redundant

  virtual_network_ids = [module.vnet_integration.id, module.vnet.id]
  subnet_id           = module.eventhub_snet[0].id

  private_dns_zones              = module.event_hub01.private_dns_zone
  private_dns_zone_record_A_name = "event_hub02"

  eventhubs = var.eventhubs_02

  //  alerts_enabled = var.ehns_alerts_enabled
  //  metric_alerts  = var.ehns_metric_alerts
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

  tags = var.tags
}

# #tfsec:ignore:AZU023
# resource "azurerm_key_vault_secret" "event_hub_keys" {
#   for_each = module.event_hub.key_ids

#   name         = format("evh-%s-%s", replace(each.key, ".", "-"), "key")
#   value        = module.event_hub.keys[each.key].primary_key
#   content_type = "text/plain"

#   key_vault_id = module.key_vault.id
# }
