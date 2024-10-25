resource "azurerm_resource_group" "eventhub_ita_rg" {
  name     = local.eventhub_resource_group_name
  location = var.location

  tags = var.tags
}

module "eventhub_namespace" {
  source = "./.terraform/modules/__v3__/eventhub_configuration"
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

  tags = var.tags
}


 CONFIGURATION

module "eventhub_gpdingestion_configuration" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//eventhub_configuration?ref=v8.22.0"
  count  = var.is_feature_enabled.eventhub ? 1 : 0

  event_hub_namespace_name                = module.eventhub_namespace.name
  event_hub_namespace_resource_group_name = azurerm_resource_group.eventhub_ita_rg.name

  eventhubs = [
    {
      name              = "connect-cluster-offsets"
      partitions        = 1
      message_retention = 1
      consumers = [
        "connect-cluster-offsets",
      ]
      keys = [
        {
          name   = "connect-cluster-offsets"
          listen = true
          send   = true
          manage = false
        }
      ]
    },
    {
      name              = "connect-cluster-status"
      partitions        = 1
      message_retention = 1
      consumers = [
        "connect-cluster-offsets",
      ]
      keys = [
        {
          name   = "connect-cluster-status"
          listen = true
          send   = true
          manage = false
        }
      ]
    },
    {
      name              = "connect-cluster-configs"
      partitions        = 1
      message_retention = 1
      consumers = [
        "connect-cluster-configs",
      ]
      keys = [
        {
          name   = "connect-cluster-configs"
          listen = true
          send   = true
          manage = false
        }
      ]
    },
    {
      name              = "${var.prefix}-${var.domain}.apd.payment_option"
      partitions        = 1
      message_retention = 1
      consumers = [
        "${var.prefix}-${var.domain}.apd.payment_option",
      ]
      keys = [
        {
          name   = "${var.prefix}-${var.domain}.apd.payment_option"
          listen = true
          send   = true
          manage = false
        }
      ]
    },
    {
      name              = "${var.prefix}-${var.domain}.apd.payment_option_metadata"
      partitions        = 1
      message_retention = 1
      consumers = [
        "${var.prefix}-${var.domain}.apd.payment_option_metadata",
      ]
      keys = [
        {
          name   = "${var.prefix}-${var.domain}.apd.payment_option_metadata"
          listen = true
          send   = true
          manage = false
        }
      ]
    },
    {
      name              = "${var.prefix}-${var.domain}.apd.payment_position"
      partitions        = 1
      message_retention = 1
      consumers = [
        "${var.prefix}-${var.domain}.apd.payment_position",
      ]
      keys = [
        {
          name   = "${var.prefix}-${var.domain}.apd.payment_position"
          listen = true
          send   = true
          manage = false
        }
      ]
    },
    {
      name              = "${var.prefix}-${var.domain}.apd.transfer"
      partitions        = 1
      message_retention = 1
      consumers = [
        "${var.prefix}-${var.domain}.apd.transfer",
      ]
      keys = [
        {
          name   = "${var.prefix}-${var.domain}.apd.transfer"
          listen = true
          send   = true
          manage = false
        }
      ]
    },
    {
      name              = "${var.prefix}-${var.domain}.apd.transfer_metadata"
      partitions        = 1
      message_retention = 1
      consumers = [
        "${var.prefix}-${var.domain}.apd.transfer_metadata",
      ]
      keys = [
        {
          name   = "${var.prefix}-${var.domain}.apd.transfer_metadata"
          listen = true
          send   = true
          manage = false
        }
      ]
    },
  ]
}

resource "azurerm_eventhub_namespace_authorization_rule" "cdc_connection_string" {
  name                = "cdc-connection-string"
  namespace_name      = "${local.project}-evh"
  resource_group_name = "${local.project}-evh-rg"
  listen              = true
  send                = true
  manage              = true
}
