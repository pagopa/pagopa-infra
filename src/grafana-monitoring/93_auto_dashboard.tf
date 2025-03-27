data "azurerm_log_analytics_workspace" "log_analytics" {
  name                = var.log_analytics_workspace_name
  resource_group_name = var.log_analytics_workspace_resource_group_name
}


module "auto_dashboard" {

  source = "git::https://github.com/pagopa/terraform-azurerm-v4.git//grafana_dashboard?ref=v1.24.0"

  grafana_url     = azurerm_dashboard_grafana.grafana_dashboard.endpoint
  grafana_api_key = data.azurerm_key_vault_secret.grafana-key.value
  prefix          = var.prefix

  monitor_workspace_id = data.azurerm_log_analytics_workspace.log_analytics.id
  //dashboard_directory_path = "pagopa"
}

