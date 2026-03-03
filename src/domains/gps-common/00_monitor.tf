## Alert
#
# This alert cover two error cases:
# 1. PaymentOption is not found after calling service.gpd.host
# 2. Receipt is not in eligible because PaymentsOption and Receipt are not coherent each other
#
resource "azurerm_monitor_scheduled_query_rules_alert" "payments_gpd_inconsistency_error" {
  count = var.env_short == "p" ? 1 : 0

  name                = format("%s-gpd-payments-api-alert", var.env_short)
  resource_group_name = azurerm_resource_group.gps_rg.name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[Payments] call GPD payment position error"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Payments API Call Error"
  enabled        = true
  query = format(<<-QUERY
  traces
    | where cloud_RoleName == "%s"
    | order by timestamp desc
    | where message contains "[getGPDCheckedReceiptsList] Non-blocking error"
  QUERY
    , format("pagopa-%s-gpd-payments-service", var.env_short) # from HELM's parameter WEBSITE_SITE_NAME
  )
  severity    = 1
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

resource "azurerm_monitor_metric_alert" "pipeline_lifecycle_management_failure" {
  count = var.env_short == "p" ? 1 : 0

  name                = "pipeline-gpd-lifecycle-management-failure-alert"
  resource_group_name = azurerm_resource_group.gps_rg.name

  scopes      = [data.azurerm_data_factory.data_factory.id]
  description = "Triggers whenever GPD_LIFECYCLE_MANAGEMENT pipeline fails."

  severity = 2

  criteria {
    metric_namespace = "Microsoft.DataFactory/factories"
    metric_name      = "PipelineFailedRuns"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 0

    dimension {
      name     = "PipelineName"
      operator = "Include"
      values   = ["GPD_MIGRATION_PIPELINE"]
    }
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.email.id
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.slack.id
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.opsgenie[0].id
  }
}

resource "azurerm_monitor_metric_alert" "pipeline_lifecycle_script_execution_failure" {
  count = var.env_short == "p" ? 1 : 0

  name                = "pipeline-gpd-lifecycle_script_execution-failure-alert"
  resource_group_name = azurerm_resource_group.gps_rg.name

  scopes      = [data.azurerm_data_factory.data_factory.id]
  description = "Triggers whenever GPD_LIFECYCLE_SCRIPT_EXECUTION pipeline fails."

  severity = 3

  criteria {
    metric_namespace = "Microsoft.DataFactory/factories"
    metric_name      = "PipelineFailedRuns"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 0

    dimension {
      name     = "PipelineName"
      operator = "Include"
      values   = ["GPD_LIFECYCLE_SCRIPT_EXECUTION"]
    }
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.email.id
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.slack.id
  }
}

resource "azurerm_monitor_metric_alert" "pipeline_lifecycle_script_execution_delete_failure" {
  count = var.env_short == "p" ? 1 : 0

  name                = "pipeline-gpd-lifecycle-script-execution-delete-failure-alert"
  resource_group_name = azurerm_resource_group.gps_rg.name

  scopes      = [data.azurerm_data_factory.data_factory.id]
  description = "Triggers whenever Delete_elements_from_online activity fails."

  severity = 2

  criteria {
    metric_namespace = "Microsoft.DataFactory/factories"
    metric_name      = "ActivityFailedRuns"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 0

    dimension {
      name     = "ActivityName"
      operator = "Include"
      values   = ["Delete_elements_from_online"]
    }
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.email.id
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.slack.id
  }
  action {
    action_group_id = data.azurerm_monitor_action_group.opsgenie[0].id
  }
}
