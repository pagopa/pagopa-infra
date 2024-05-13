data "azurerm_log_analytics_workspace" "log_analytics" {
  name                = var.log_analytics_workspace_name
  resource_group_name = var.log_analytics_workspace_resource_group_name
}

data "azurerm_application_insights" "application_insights" {
  name                = local.monitor_appinsights_name
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
}

data "azurerm_resource_group" "monitor_rg" {
  name = var.monitor_resource_group_name
}

data "azurerm_monitor_action_group" "slack" {
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_slack_name
}

data "azurerm_monitor_action_group" "slacknodo" {
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_slack_name
}

data "azurerm_monitor_action_group" "email" {
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_email_name
}

data "azurerm_monitor_action_group" "opsgenie" {
  count = var.env_short != "d" ? 1 : 0

  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_opsgenie_name
}


resource "azurerm_monitor_metric_alert" "aks_nodo_moetrics" {
  name                = "${local.aks_name}-nodo-cron-pod_number"
  resource_group_name = var.monitor_resource_group_name
  scopes              = [data.azurerm_kubernetes_cluster.aks.id]
  description         = "Action will be triggered when Pod count nodo-cron is greater than 200."

  criteria {
    aggregation      = "Average"
    metric_namespace = "Insights.Container/pods"
    metric_name      = "podCount"
    operator         = "GreaterThan"
    threshold        = 200
    dimension {
      name     = "kubernetes namespace"
      operator = "Include"
      values   = ["nodo-cron"]
    }
  }
  action {
    action_group_id    = data.azurerm_monitor_action_group.slack.id
    webhook_properties = null
  }
}

resource "azurerm_monitor_metric_alert" "aks_nodo_moetrics_error" {
  name                = "${local.aks_name}-nodo-cron-pod_error"
  resource_group_name = var.monitor_resource_group_name
  scopes              = [data.azurerm_kubernetes_cluster.aks.id]
  description         = "Action will be triggered when Pod count nodo-cron is greater than 200."

  criteria {
    aggregation      = "Average"
    metric_namespace = "Insights.Container/pods"
    metric_name      = "podCount"
    operator         = "GreaterThan"
    threshold        = 30
    dimension {
      name     = "kubernetes namespace"
      operator = "Include"
      values   = ["nodo-cron"]
    }
    dimension {
      name     = "phase"
      operator = "Include"
      values   = ["Failed", "Pending"]
    }

  }

  action {
    action_group_id    = data.azurerm_monitor_action_group.slack.id
    webhook_properties = null
  }
}
