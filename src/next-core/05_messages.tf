resource "azurerm_resource_group" "msg_rg" {
  name     = format("%s-msg-rg", local.product)
  location = var.location

  tags = module.tag_config.tags
}

## Eventhub subnet
module "eventhub_snet" {
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v8.2.0"
  name                                      = format("%s-eventhub-snet", local.product)
  address_prefixes                          = var.cidr_subnet_eventhub
  resource_group_name                       = azurerm_resource_group.rg_vnet.name
  virtual_network_name                      = module.vnet_integration.name
  service_endpoints                         = ["Microsoft.EventHub"]
  private_endpoint_network_policies_enabled = false
}


resource "azurerm_private_dns_zone" "privatelink_servicebus_windows_net" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = azurerm_resource_group.msg_rg.name
  tags                = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_core_link_privatelink_servicebus_windows_net" {

  name                  = "${local.product}-evh-ns01-private-dns-zone-link-02"
  resource_group_name   = azurerm_resource_group.msg_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_servicebus_windows_net.name
  virtual_network_id    = module.vnet.id
  registration_enabled  = false

  tags = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_integration_link_privatelink_servicebus_windows_net" {

  name                  = "${local.product}-evh-ns01-private-dns-zone-link-01"
  resource_group_name   = azurerm_resource_group.msg_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_servicebus_windows_net.name
  virtual_network_id    = module.vnet_integration.id
  registration_enabled  = false

  tags = module.tag_config.tags
}


//replaces ns01
module "event_hub03" {
  source                   = "git::https://github.com/pagopa/terraform-azurerm-v3.git//eventhub?ref=v7.62.0"
  name                     = "${local.project}-evh-ns03"
  location                 = var.location
  resource_group_name      = azurerm_resource_group.msg_rg.name
  auto_inflate_enabled     = var.ehns_auto_inflate_enabled
  sku                      = var.ehns_sku_name
  capacity                 = var.ehns_capacity
  maximum_throughput_units = var.ehns_maximum_throughput_units
  zone_redundant           = var.ehns_zone_redundant

  virtual_network_ids = [module.vnet_integration.id, module.vnet.id]
  subnet_id           = module.eventhub_snet.id

  eventhubs = var.eventhubs_03

  public_network_access_enabled = var.ehns_public_network_access

  private_dns_zones = {
    id   = [azurerm_private_dns_zone.privatelink_servicebus_windows_net.id]
    name = [azurerm_private_dns_zone.privatelink_servicebus_windows_net.name]
  }
  private_dns_zone_record_A_name = "event_hub03"

  alerts_enabled = var.ehns03_alerts_enabled
  metric_alerts  = var.ehns03_metric_alerts

  # takes a list and replaces any elements that are lists with a
  # flattened sequence of the list contents.
  # In this case, we enable OpsGenie only on prod env
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

  tags = module.tag_config.tags
}

//replaces ns02
module "event_hub04" {
  source                   = "git::https://github.com/pagopa/terraform-azurerm-v3.git//eventhub?ref=v7.62.0"
  name                     = "${local.project}-evh-ns04"
  location                 = var.location
  resource_group_name      = azurerm_resource_group.msg_rg.name
  auto_inflate_enabled     = var.ehns_auto_inflate_enabled
  sku                      = var.ehns_sku_name
  capacity                 = var.ehns_capacity
  maximum_throughput_units = var.ehns_maximum_throughput_units
  zone_redundant           = var.ehns_zone_redundant

  virtual_network_ids           = [module.vnet_integration.id, module.vnet.id]
  subnet_id                     = module.eventhub_snet.id
  public_network_access_enabled = var.ehns_public_network_access
  private_dns_zones = {
    id   = [azurerm_private_dns_zone.privatelink_servicebus_windows_net.id]
    name = [azurerm_private_dns_zone.privatelink_servicebus_windows_net.name]
  }
  private_dns_zone_record_A_name = "event_hub04"

  alerts_enabled = var.ehns04_alerts_enabled
  metric_alerts  = var.ehns04_metric_alerts

  eventhubs = var.eventhubs_04

  # takes a list and replaces any elements that are lists with a
  # flattened sequence of the list contents.
  # In this case, we enable OpsGenie only on prod env
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

  tags = module.tag_config.tags
}

module "event_hubprf" {
  count                    = var.env_short == "u" ? 1 : 0
  source                   = "git::https://github.com/pagopa/terraform-azurerm-v3.git//eventhub?ref=v7.62.0"
  name                     = "${local.project}-evh-nsprf"
  location                 = var.location
  resource_group_name      = azurerm_resource_group.msg_rg.name
  auto_inflate_enabled     = var.ehns_auto_inflate_enabled
  sku                      = var.ehns_sku_name
  capacity                 = var.ehns_capacity
  maximum_throughput_units = var.ehns_maximum_throughput_units
  zone_redundant           = var.ehns_zone_redundant

  virtual_network_ids = [module.vnet_integration.id, module.vnet.id]
  subnet_id           = module.eventhub_snet.id

  eventhubs = var.eventhubs_prf

  public_network_access_enabled = var.ehns_public_network_access

  private_dns_zones = {
    id   = [azurerm_private_dns_zone.privatelink_servicebus_windows_net.id]
    name = [azurerm_private_dns_zone.privatelink_servicebus_windows_net.name]
  }
  private_dns_zone_record_A_name = "event_hubprf"

  alerts_enabled = false # var.ehns_alerts_enabled
  # metric_alerts  = var.ehns_metric_alerts

  # takes a list and replaces any elements that are lists with a
  # flattened sequence of the list contents.
  # In this case, we enable OpsGenie only on prod env
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

  tags = module.tag_config.tags
}
