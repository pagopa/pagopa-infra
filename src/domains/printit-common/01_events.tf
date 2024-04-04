resource "azurerm_resource_group" "msg_rg" {
  name     = format("%s-msg-rg", local.project)
  location = var.location

  tags = var.tags
}

## Eventhub subnet
module "printit_eventhub_snet" {
  count                                          = var.eventhub_enabled && var.cidr_subnet_eventhub != null ? 1 : 0
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.90"
  name                                           = format("%s-eventhub-snet", local.project)
  address_prefixes                               = var.cidr_subnet_eventhub
  resource_group_name                            = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = data.azurerm_virtual_network.vnet.name
  service_endpoints                              = ["Microsoft.EventHub"]
  enforce_private_link_endpoint_network_policies = true
}

module "printit_event_hub" {
  source                   = "git::https://github.com/pagopa/azurerm.git//eventhub?ref=v1.0.90"
  name                     = format("%s-printit-evh-ns01", local.project)
  location                 = var.location
  resource_group_name      = azurerm_resource_group.msg_rg.name
  auto_inflate_enabled     = var.ehns_auto_inflate_enabled
  sku                      = var.ehns_sku_name
  capacity                 = var.ehns_capacity
  maximum_throughput_units = var.ehns_maximum_throughput_units
  zone_redundant           = var.ehns_zone_redundant

  virtual_network_ids = [data.azurerm_virtual_network.vnet.id]
  subnet_id           = module.printit_eventhub_snet[0].id

  eventhubs = var.eventhubs

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

data "azurerm_eventhub_namespace" "printit_event_hub_namespace" {
  name                = "${var.prefix}-${var.env_short}-itn-printit-evh-ns01"
  resource_group_name = azurerm_resource_group.msg_rg.name
}

data "azurerm_eventhub_authorization_rule" "pagopa_evh_printit-evt_notice-evt-rx" {
  name                = "${var.prefix}-notice-evt-rx"
  namespace_name      = data.azurerm_eventhub_namespace.printit_event_hub_namespace
  eventhub_name       = module.printit_event_hub.name
  resource_group_name = azurerm_resource_group.msg_rg
}

data "azurerm_eventhub_authorization_rule" "pagopa_evh_printit-evt_notice-complete-evt-rx" {
  name                = "${var.prefix}-notice-complete-evt-tx"
  namespace_name      = data.azurerm_eventhub_namespace.printit_event_hub_namespace
  eventhub_name       = module.printit_event_hub.name
  resource_group_name = azurerm_resource_group.msg_rg
}

data "azurerm_eventhub_authorization_rule" "pagopa_evh_printit-evt_notice-error-evt-rx" {
  name                = "${var.prefix}-notice-error-evt-tx"
  namespace_name      = data.azurerm_eventhub_namespace.printit_event_hub_namespace
  eventhub_name       = module.printit_event_hub.name
  resource_group_name = azurerm_resource_group.msg_rg
}
