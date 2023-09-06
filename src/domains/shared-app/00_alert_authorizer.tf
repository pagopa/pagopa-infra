
resource "azurerm_monitor_metric_alert" "function_app_health_check_v2" {
  count = var.env_short != "d" ? 1 : 0

  name                = "[${var.domain != null ? "${var.domain} | " : ""}${module.authorizer_function_app.name}] Health Check Failed V2"
  resource_group_name = "dashboards"
  scopes              = [module.authorizer_function_app.id]
  description         = "Availability for platform-authorizer is less than to 99%"
  severity            = 1
  frequency           = "PT5M"
  auto_mitigate       = false
  enabled             = true

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "HealthCheckStatus"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 99
  }

  dynamic "action" {
    for_each = local.authorizer_healthcheck_action
    content {
      action_group_id    = action.value["action_group_id"]
      webhook_properties = action.value["webhook_properties"]
    }
  }
}
