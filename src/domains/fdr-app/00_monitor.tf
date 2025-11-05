data "azurerm_log_analytics_workspace" "log_analytics" {
  name                = var.log_analytics_workspace_name
  resource_group_name = var.log_analytics_workspace_resource_group_name
}

data "azurerm_resource_group" "monitor_rg" {
  name = var.monitor_resource_group_name
}

data "azurerm_application_insights" "application_insights" {
  name                = local.monitor_appinsights_name
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
}

data "azurerm_monitor_action_group" "slack" {
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_slack_name
}

data "azurerm_monitor_action_group" "slack_pagopa_pagamenti_alert" {
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_slack_pagamenti_alert_name
}

data "azurerm_monitor_action_group" "email" {
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_email_name
}

data "azurerm_monitor_action_group" "opsgenie" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_opsgenie_name
}

data "azurerm_monitor_action_group" "smo_opsgenie" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = var.monitor_resource_group_name
  name                = "SmoOpsgenie"
}

resource "azurerm_portal_dashboard" "fdr-dashboard" { # FDR1
  count               = var.env_short == "p" ? 1 : 0
  name                = "FLussiDiRendicontazione-${var.env}-FdR"
  resource_group_name = var.monitor_resource_group_name
  location            = var.location
  tags = {
    source = "terraform"
  }
  dashboard_properties = templatefile("./dashboard/dashboard-apim-fdr.tpl", {
    subscription_id = data.azurerm_subscription.current.subscription_id,
    env_short       = var.env_short
  })
}

resource "azurerm_portal_dashboard" "fdr-general-dashboard" { # FDR3
  name                = "General-Dashboard-FDR-${var.env}"
  resource_group_name = var.monitor_resource_group_name
  location            = var.location
  tags = {
    source = "terraform"
  }
  dashboard_properties = templatefile("./dashboard/dashboard-general-fdr.json", {
    subscription_id = data.azurerm_subscription.current.subscription_id,
    env_short       = var.env_short
    env_elk         = var.env_short == "p" ? "p" : "s"
    env             = var.env
  })
}
