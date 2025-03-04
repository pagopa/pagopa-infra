#
# 🇮🇹 Monitor Italy
#
data "azurerm_resource_group" "monitor_italy_rg" {
  name = var.monitor_italy_resource_group_name
}

data "azurerm_log_analytics_workspace" "log_analytics_italy" {
  name                = var.log_analytics_italy_workspace_name
  resource_group_name = var.log_analytics_italy_workspace_resource_group_name
}

data "azurerm_application_insights" "application_insights_italy" {
  name                = local.monitor_appinsights_italy_name
  resource_group_name = data.azurerm_resource_group.monitor_italy_rg.name
}

#
# Actions Group
#
data "azurerm_monitor_action_group" "slack" {
  name                = local.monitor_action_group_slack_name
  resource_group_name = var.monitor_italy_resource_group_name
}

data "azurerm_monitor_action_group" "email" {
  resource_group_name = var.monitor_italy_resource_group_name
  name                = local.monitor_action_group_email_name
}

data "azurerm_monitor_action_group" "opsgenie" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_opsgenie_name
}
