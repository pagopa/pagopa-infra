data "azurerm_resources" "alerting_postgresql_resources" {
  for_each = toset(local.alerting_domains)
  type     = local.azure_postgresql_resource_type

  required_tags = {
    domain = each.key
  }
}

locals {

## Postgresql resources and alerts mapping

  postgresql_id_map = flatten([
    for rp in data.azurerm_resources.alerting_postgresql_resources : [
        for r in rp.resources : {
            pg_name = r.name
            pg_rg = r.resource_group_name
            pg_id = r.id
        }
    ]
  ])

  # Cross join between Postgresql resources and configured alerts to create the final map used to create metric alerts

  postgresql_resource_metric_map = flatten([
    for rp in local.postgresql_id_map : [
        for m in var.postgresql_metric_alerts : {
            pg_name = rp.pg_name
            pg_rg = rp.pg_rg
            pg_id = rp.pg_id
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

resource "azurerm_monitor_metric_alert" "postgresql_alerts" {
  for_each = { for idx, val in local.postgresql_resource_metric_map : "${val.pg_name}-${val.metric_name}" => val }

  enabled             = var.postgresql_alerts_enabled
  name                = "${each.value.pg_name}-${upper(each.key)}"
  resource_group_name = each.value.pg_rg
  scopes              = [each.value.pg_id]
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