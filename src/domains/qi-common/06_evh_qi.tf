### resource group definition
resource "azurerm_resource_group" "qi_evh_resource_group" {
  name     = "pagopa-${var.env_short}-itn-qi-evh-rg"
  location = "Italy North"
}

module "eventhub_namespace_qi" {
  source                   = "./.terraform/modules/__v4__/eventhub"
  name                     = "${local.project_itn}-evh"
  location                 = var.location_itn
  resource_group_name      = azurerm_resource_group.qi_evh_resource_group.name
  auto_inflate_enabled     = var.ehns_auto_inflate_enabled
  sku                      = var.ehns_sku_name
  capacity                 = var.ehns_capacity
  maximum_throughput_units = var.ehns_maximum_throughput_units
  #zone_redundat is always true

  private_endpoint_subnet_id    = azurerm_subnet.eventhub_qi_snet.id
  public_network_access_enabled = var.ehns_public_network_access
  private_endpoint_created      = var.ehns_private_endpoint_is_present && !var.is_feature_enabled.evh_spoke_pe

  private_endpoint_resource_group_name = azurerm_resource_group.qi_evh_resource_group.name
  private_dns_zones_ids                = [data.azurerm_private_dns_zone.eventhub.id]


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

  tags = module.tag_config.tags
}

resource "azurerm_private_endpoint" "eventhub_spoke_pe" {
  count = var.ehns_private_endpoint_is_present && var.is_feature_enabled.evh_spoke_pe ? 1 : 0

  name                = "${local.project}-evh-spoke-pe"
  location            = var.location
  resource_group_name = azurerm_resource_group.qi_evh_resource_group.name
  subnet_id           = module.eventhub_spoke_pe_snet.subnet_id

  dynamic "private_dns_zone_group" {
    for_each = var.ehns_private_endpoint_is_present && var.is_feature_enabled.evh_spoke_pe_dns ? [1] : []
    content {
      name                 = "${local.project}-evh-spoke-private-dns-zone-group"
      private_dns_zone_ids = [data.azurerm_private_dns_zone.eventhub.id]
    }
  }

  private_service_connection {
    name                           = "${local.project}-evh-spoke-private-service-connection"
    private_connection_resource_id = module.eventhub_namespace_qi.namespace_id
    is_manual_connection           = false
    subresource_names              = ["namespace"]
  }

  tags = module.tag_config.tags
}

module "eventhub_qi_configuration" {
  source = "./.terraform/modules/__v4__/eventhub_configuration"

  event_hub_namespace_name                = module.eventhub_namespace_qi.name
  event_hub_namespace_resource_group_name = azurerm_resource_group.qi_evh_resource_group.name

  eventhubs = var.eventhubs_bdi
}
