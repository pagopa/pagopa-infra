resource "azurerm_resource_group" "monitor_rg" {
  name     = "${local.project}-monitor-rg"
  location = var.location

  tags = module.tag_config.tags
}

resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = "${local.project}-law"
  location            = azurerm_resource_group.monitor_rg.location
  resource_group_name = azurerm_resource_group.monitor_rg.name
  sku                 = var.law_sku
  retention_in_days   = var.law_retention_in_days
  daily_quota_gb      = var.law_daily_quota_gb

  internet_query_enabled = var.law_internet_query_enabled

  tags = module.tag_config.tags

  lifecycle {
    ignore_changes = [
      sku
    ]
  }
}

# Azure Monitor Workspace
resource "azurerm_monitor_workspace" "monitor_workspace" {
  name                          = "${var.prefix}-${var.env_short}-${var.location}-monitor-workspace"
  resource_group_name           = "${var.prefix}-${var.env_short}-monitor-rg"
  location                      = var.location
  public_network_access_enabled = false
  tags                          = module.tag_config.tags
}

# Create workspace private DNS zone
resource "azurerm_private_dns_zone" "prometheus_dns_zone" {
  name                = "privatelink.${var.location}.prometheus.monitor.azure.com"
  resource_group_name = module.vnet_italy.0.resource_group_name

  tags = module.tag_config.tags
}

# Create virtual network link for workspace private dns zone
resource "azurerm_private_dns_zone_virtual_network_link" "prometheus_dns_zone_vnet_link" {
  name                  = module.vnet_italy.0.name
  resource_group_name   = module.vnet_italy.0.resource_group_name
  virtual_network_id    = module.vnet_italy.0.id
  private_dns_zone_name = azurerm_private_dns_zone.prometheus_dns_zone.name

  tags = module.tag_config.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "prometheus_core_dns_zone_vnet_link" {
  name                  = data.azurerm_virtual_network.vnet_core.name
  resource_group_name   = module.vnet_italy.0.resource_group_name
  virtual_network_id    = data.azurerm_virtual_network.vnet_core.id
  private_dns_zone_name = azurerm_private_dns_zone.prometheus_dns_zone.name

  tags = module.tag_config.tags
}

resource "azurerm_private_endpoint" "monitor_workspace_private_endpoint" {
  name                = "${var.prefix}-${var.location}-monitor-workspace-pe"
  location            = azurerm_monitor_workspace.monitor_workspace.location
  resource_group_name = azurerm_monitor_workspace.monitor_workspace.resource_group_name
  subnet_id           = module.common_private_endpoint_snet.id

  private_service_connection {
    name                           = "monitorworkspaceconnection"
    private_connection_resource_id = azurerm_monitor_workspace.monitor_workspace.id
    is_manual_connection           = false
    subresource_names              = ["prometheusMetrics"]
  }

  private_dns_zone_group {
    name                 = "${var.prefix}-workspace-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.prometheus_dns_zone.id]
  }


  depends_on = [azurerm_monitor_workspace.monitor_workspace]

  tags = module.tag_config.tags
}


# Application insights
resource "azurerm_application_insights" "application_insights" {
  name                = "${local.project}-appinsights"
  location            = azurerm_resource_group.monitor_rg.location
  resource_group_name = azurerm_resource_group.monitor_rg.name
  application_type    = "other"

  internet_query_enabled = var.law_internet_query_enabled

  workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id

  tags = module.tag_config.tags
}

#
# Action Group
#
resource "azurerm_monitor_action_group" "email" {
  name                = "PagoPA"
  resource_group_name = azurerm_resource_group.monitor_rg.name
  short_name          = "PagoPA"

  email_receiver {
    name                    = "sendtooperations"
    email_address           = data.azurerm_key_vault_secret.monitor_notification_email.value
    use_common_alert_schema = true
  }

  tags = module.tag_config.tags
}

resource "azurerm_monitor_action_group" "slack" {
  name                = "SlackPagoPA"
  resource_group_name = azurerm_resource_group.monitor_rg.name
  short_name          = "SlackPagoPA"

  email_receiver {
    name                    = "sendtoslack"
    email_address           = data.azurerm_key_vault_secret.monitor_notification_slack_email.value
    use_common_alert_schema = true
  }

  tags = module.tag_config.tags
}
