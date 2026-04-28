data "azurerm_resources" "alerting_redis_resources" {
  for_each = toset(local.alerting_domains)
  type     = local.azure_redis_resource_type

  required_tags = {
    domain = each.key
  }
}

locals {

## Redis resources and alerts mapping

  redis_id_map = flatten([
    for rp in data.azurerm_resources.alerting_redis_resources : [
        for r in rp.resources : {
            redis_name = r.name
            redis_rg = r.resource_group_name
            redis_id = r.id
        }
    ]
  ])

  # Cross join between Redis resources and configured alerts to create the final map used to create metric alerts

  redis_resource_metric_map = flatten([
    for rp in local.redis_id_map : [
        for m in var.redis_metric_alerts : {
            redis_name = rp.redis_name
            redis_rg = rp.redis_rg
            redis_id = rp.redis_id
            metric_name = m.metric_name
            metric_namespace = m.metric_namespace
            aggregation = m.aggregation
            operator = m.operator
            threshold = m.threshold
            frequency = m.frequency
            window_size = m.window_size
            severity = m.severity
        }
    ]
  ])
}

resource "azurerm_monitor_metric_alert" "redis_alerts" {
  for_each = { for idx, val in local.redis_resource_metric_map : "${val.redis_name}-${val.metric_name}" => val }

  enabled             = var.redis_alerts_enabled
  name                = "${each.value.redis_name}-${upper(each.key)}"
  resource_group_name = each.value.redis_rg
  scopes              = [each.value.redis_id]
  frequency           = each.value.frequency
  window_size         = each.value.window_size
  severity            = each.value.severity

#   dynamic "action" {
#     for_each = var.alert_action
#     content {
#       # action_group_id - (required) is a type of string
#       action_group_id = action.value["action_group_id"]
#       # webhook_properties - (optional) is a type of map of string
#       webhook_properties = action.value["webhook_properties"]
#     }
#   }

  criteria {
    aggregation      = each.value.aggregation
    metric_namespace = each.value.metric_namespace
    metric_name      = each.value.metric_name
    operator         = each.value.operator
    threshold        = each.value.threshold
  }

  tags = var.tags
}