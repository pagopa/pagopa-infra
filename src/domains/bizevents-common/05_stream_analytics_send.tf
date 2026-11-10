resource "azurerm_stream_analytics_job" "biz_send_filter_stream" {
  name                                     = "${local.project}-evh-stream-send-filter-job"
  resource_group_name                      = azurerm_resource_group.bizevents_rg.name
  location                                 = var.location
  compatibility_level                      = "1.2"
  data_locale                              = "it-IT"
  events_out_of_order_policy               = "Adjust"
  events_out_of_order_max_delay_in_seconds = 5
  output_error_policy                      = "Drop"
  streaming_units                          = 1

  transformation_query = <<QUERY
SELECT e.id
INTO [evh-tx-stream-send-filter]
FROM [evh-rx-stream-send-filter] e
QUERY

  tags = module.tag_config.tags

  lifecycle {
    ignore_changes = [streaming_units]
  }
}

resource "azurerm_stream_analytics_stream_input_eventhub" "biz_send_filter_stream_in" {
  name                         = "evh-rx-stream-send-filter"
  stream_analytics_job_name    = azurerm_stream_analytics_job.biz_send_filter_stream.name
  resource_group_name          = azurerm_resource_group.bizevents_rg.name
  eventhub_name                = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-biz-evt_pagopa-biz-evt-rx-send-filter.eventhub_name
  eventhub_consumer_group_name = "${var.prefix}-biz-evt-rx-send-filter"
  servicebus_namespace         = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-biz-evt_pagopa-biz-evt-rx-send-filter.namespace_name
  shared_access_policy_name    = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-biz-evt_pagopa-biz-evt-rx-send-filter.name
  shared_access_policy_key     = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-biz-evt_pagopa-biz-evt-rx-send-filter.primary_key

  serialization {
    type     = "Json"
    encoding = "UTF8"
  }
}

resource "azurerm_stream_analytics_output_eventhub" "biz_send_filter_stream_out" {
  name                      = "evh-tx-stream-send-filter"
  stream_analytics_job_name = azurerm_stream_analytics_job.biz_send_filter_stream.name
  resource_group_name       = azurerm_resource_group.bizevents_rg.name
  eventhub_name             = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-biz-evt-send_pagopa-biz-evt-tx-send-filter.eventhub_name
  servicebus_namespace      = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-biz-evt-send_pagopa-biz-evt-tx-send-filter.namespace_name
  shared_access_policy_name = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-biz-evt-send_pagopa-biz-evt-tx-send-filter.name
  shared_access_policy_key  = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns03_nodo-dei-pagamenti-biz-evt-send_pagopa-biz-evt-tx-send-filter.primary_key

  serialization {
    type     = "Json"
    encoding = "UTF8"
    format   = "LineSeparated"
  }
}

## DLQ: malformed events are dropped by Stream Analytics before the query runs, so they cannot be routed by an output.
## Execution logs (which include input deserialization errors and the offending payload) are archived to bizevents_sa.
resource "azurerm_monitor_diagnostic_setting" "biz_send_filter_stream_logs" {
  name               = "biz-send-filter-dlq-stream-logs"
  target_resource_id = azurerm_stream_analytics_job.biz_send_filter_stream.id
  storage_account_id = module.bizevents_sa.id

  enabled_log {
    category = "Execution"
  }
}
