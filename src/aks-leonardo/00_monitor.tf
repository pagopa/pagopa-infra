# 🔭 Monitor
data "azurerm_resource_group" "rg_monitor" {
  name = local.monitor_rg_name
}

data "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = local.monitor_log_analytics_workspace_name
  resource_group_name = data.azurerm_resource_group.rg_monitor.name
}

# ⚡️ monitor action groups

data "azurerm_monitor_action_group" "slack" {
  resource_group_name = local.monitor_rg_name
  name                = local.monitor_action_group_slack_name
}

data "azurerm_monitor_action_group" "email" {
  resource_group_name = local.monitor_rg_name
  name                = local.monitor_action_group_email_name
}


