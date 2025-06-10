resource "azurerm_resource_group" "grafana_rg" {
  name     = format("%s-rg", local.project)
  location = var.location

  tags = module.tag_config.tags
}


resource "azurerm_dashboard_grafana" "grafana_dashboard" {
  name                              = local.project
  resource_group_name               = azurerm_resource_group.grafana_rg.name
  location                          = var.location
  api_key_enabled                   = true
  deterministic_outbound_ip_enabled = true
  public_network_access_enabled     = true
  zone_redundancy_enabled           = true
  grafana_major_version             = "10"
  identity {
    type = "SystemAssigned"
  }
  lifecycle {
    ignore_changes = [
      azure_monitor_workspace_integrations,
      grafana_major_version,
    ]
  }
  tags = module.tag_config.tags
}

resource "azurerm_role_assignment" "grafana_dashboard_monitoring_reader" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Monitoring Reader"
  principal_id         = azurerm_dashboard_grafana.grafana_dashboard.identity[0].principal_id
}

resource "azurerm_role_assignment" "grafana_dashboard_monitoring_data_reader" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Monitoring Data Reader"
  principal_id         = azurerm_dashboard_grafana.grafana_dashboard.identity[0].principal_id
}

resource "azurerm_kusto_database_principal_assignment" "grafana_viewer" {
  name                = "GrafanaViewerAssignment"
  resource_group_name = data.azurerm_kusto_cluster.data_explorer.resource_group_name
  cluster_name        = data.azurerm_kusto_cluster.data_explorer.name
  database_name       = data.azurerm_kusto_database.data_explorer_re.name

  tenant_id      = data.azurerm_client_config.current.tenant_id
  principal_id   = azurerm_dashboard_grafana.grafana_dashboard.identity[0].principal_id
  principal_type = "App"
  role           = "Viewer"
}
