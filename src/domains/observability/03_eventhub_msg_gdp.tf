
module "eventhub_namespace_observability_gpd" {
  source = "./.terraform/modules/__v4__/eventhub"

  name                     = "${local.project_itn}-gpd-evh"
  location                 = var.location_itn
  resource_group_name      = azurerm_resource_group.eventhub_observability_rg.name
  auto_inflate_enabled     = var.ehns_auto_inflate_enabled
  sku                      = var.ehns_sku_name
  capacity                 = var.ehns_capacity
  maximum_throughput_units = var.ehns_maximum_throughput_units
  #zone_redundat is always true

  public_network_access_enabled        = var.ehns_public_network_access
  private_endpoint_created             = false
  private_endpoint_resource_group_name = azurerm_resource_group.eventhub_observability_rg.name

  private_dns_zones_ids = [data.azurerm_private_dns_zone.eventhub.id]


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
  metric_alerts        = var.ehns_metric_alerts_gpd

  tags = module.tag_config.tags
}

#
# CONFIGURATION
#
module "eventhub_observability_gpd_configuration" {
  source = "./.terraform/modules/__v4__/eventhub_configuration"

  event_hub_namespace_name                = module.eventhub_namespace_observability_gpd.name
  event_hub_namespace_resource_group_name = azurerm_resource_group.eventhub_observability_rg.name

  eventhubs = var.eventhubs_gpd
}

# hub spoke private endpoint
resource "azurerm_private_endpoint" "eventhub_gpd_spoke_pe" {
  count = var.ehns_private_endpoint_is_present ? 1 : 0

  name                = "${local.project}-evh-gpd-spoke-pe"
  location            = var.location_itn
  resource_group_name = azurerm_resource_group.eventhub_observability_rg.name
  subnet_id           = module.eventhub_observability_gpd_spoke_pe_snet.subnet_id

  private_dns_zone_group {
    name                 = "${local.project}-evh-gpd-spoke-private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.eventhub.id]
  }


  private_service_connection {
    name                           = "${local.project}-evh-spoke-private-service-connection"
    private_connection_resource_id = module.eventhub_namespace_observability_gpd.namespace_id
    is_manual_connection           = false
    subresource_names              = ["namespace"]
  }

  tags = module.tag_config.tags
}

resource "azurerm_eventhub_namespace_authorization_rule" "cdc_connection_string" {
  name                = "cdc-gpd-connection-string"
  namespace_name      = module.eventhub_namespace_observability_gpd.name
  resource_group_name = azurerm_resource_group.eventhub_observability_rg.name
  listen              = true
  send                = true
  manage              = true
}

# MS doc configure-cleanup-policy  https://learn.microsoft.com/en-us/azure/event-hubs/configure-event-hub-properties#configure-cleanup-policy
# ISSUE                            https://github.com/hashicorp/terraform-provider-azurerm/issues/22155
# MS doc create evh via TF         https://learn.microsoft.com/en-us/azure/templates/microsoft.eventhub/namespaces/eventhubs?pivots=deployment-language-terraform

# Ex :
# az eventhubs eventhub create \
# -g pagopa-d-itn-observ-evh-rg \
# -n "prova" \
# --namespace-name pagopa-d-itn-observ-gpd-evh \
# --cleanup-policy "Compact" \
# --status "Active" \
# --partition-count 1 \
# --retention-time 24


resource "azurerm_eventhub_namespace_authorization_rule" "cdc_test_connection_string" {
  count = var.env != "p" ? 1 : 0

  name                = "cdc-gpd-test-connection-string"
  namespace_name      = module.eventhub_namespace_observability_gpd.name
  resource_group_name = azurerm_resource_group.eventhub_observability_rg.name
  listen              = true
  send                = true
  manage              = false
}

resource "azurerm_key_vault_secret" "azure_web_jobs_storage_kv" {
  count = var.env != "p" ? 1 : 0

  name         = "cdc-gpd-test-connection-string"
  value        = azurerm_eventhub_namespace_authorization_rule.cdc_test_connection_string[0].primary_connection_string
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.gps_kv.id
}

resource "azurerm_eventhub_consumer_group" "rtp_consumer_gpd" {
  name                = "rtp-consumer-group"
  namespace_name      = module.eventhub_namespace_observability_gpd.name
  eventhub_name       = "cdc-raw-auto.apd.payment_option"
  resource_group_name = azurerm_resource_group.eventhub_observability_rg.name
}
