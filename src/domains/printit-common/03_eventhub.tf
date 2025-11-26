resource "azurerm_resource_group" "eventhub_ita_rg" {
  name     = local.eventhub_resource_group_name
  location = var.location

  tags = module.tag_config.tags
}

module "eventhub_namespace" {
  source                   = "git::https://github.com/pagopa/terraform-azurerm-v3.git//eventhub?ref=v8.22.0"
  name                     = "${local.project}-evh"
  location                 = var.location
  resource_group_name      = azurerm_resource_group.eventhub_ita_rg.name
  auto_inflate_enabled     = var.ehns_auto_inflate_enabled
  sku                      = var.ehns_sku_name
  capacity                 = var.ehns_capacity
  maximum_throughput_units = var.ehns_maximum_throughput_units
  #zone_redundat is always true

  virtual_network_ids           = [data.azurerm_virtual_network.vnet_italy.id]
  private_endpoint_subnet_id    = azurerm_subnet.eventhub_italy.id
  public_network_access_enabled = var.ehns_public_network_access
  private_endpoint_created      = var.ehns_private_endpoint_is_present

  private_endpoint_resource_group_name = azurerm_resource_group.eventhub_ita_rg.name

  private_dns_zones = {
    id                  = [data.azurerm_private_dns_zone.eventhub.id]
    name                = [data.azurerm_private_dns_zone.eventhub.name]
    resource_group_name = data.azurerm_resource_group.rg_event_private_dns_zone.name
  }

  private_dns_zone_record_A_name = "${var.domain}.${var.location_short}"

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
  metric_alerts        = var.ehns_metric_alerts

  tags = module.tag_config.tags
}

#
# CONFIGURATION
#
module "eventhub_printit_configuration" {
  source = "./.terraform/modules/__v3__//eventhub_configuration"
  count  = var.is_feature_enabled.eventhub ? 1 : 0

  event_hub_namespace_name                = module.eventhub_namespace.name
  event_hub_namespace_resource_group_name = azurerm_resource_group.eventhub_ita_rg.name

  eventhubs = [
    {
      name              = "${var.prefix}-${var.domain}-evh"
      partitions        = 1
      message_retention = 1
      consumers = [
        "${local.project}-notice-evt-rx",
      ]
      keys = [
        {
          name   = "${local.project}-notice-evt-rx"
          listen = true
          send   = true
          manage = false
        }
      ]
    },
    {
      name              = "${var.prefix}-${var.domain}-complete-evh"
      partitions        = 1
      message_retention = 1
      consumers = [
        "${local.project}-notice-evt-complete-rx",
      ]
      keys = [
        {
          name   = "${local.project}-notice-evt-complete-rx"
          listen = true
          send   = true
          manage = false
        }
      ]
    },
    {
      name              = "${var.prefix}-${var.domain}-errors-evh"
      partitions        = 1
      message_retention = 1
      consumers = [
        "${local.project}-notice-evt-errors-rx",
      ]
      keys = [
        {
          name   = "${local.project}-notice-evt-errors-rx"
          listen = true
          send   = true
          manage = false
        }
      ]
    },
  ]
}

