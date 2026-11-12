resource "azurerm_stream_analytics_job" "biz_send_filter_stream" {
  count                                    = var.env_short != "p" ? 1 : 0
  name                                     = "${local.project}-evh-stream-send-filter-job"
  resource_group_name                      = azurerm_resource_group.bizevents_rg.name
  location                                 = var.location
  compatibility_level                      = "1.2"
  data_locale                              = "it-IT"
  events_out_of_order_policy               = "Adjust"
  events_out_of_order_max_delay_in_seconds = 5
  output_error_policy                      = "Drop"
  streaming_units                          = 1

  # Flat output: UDFs cannot return records and the query language cannot build nested ones
  transformation_query = <<QUERY
SELECT
  CAST(e.debtorPosition.modelType AS nvarchar(max)) AS modelType,
  CAST(e.debtorPosition.iuv AS nvarchar(max)) AS iuv,
  CAST(e.paymentInfo.IUR AS nvarchar(max)) AS iur,
  CAST(e.debtorPosition.noticeNumber AS nvarchar(max)) AS noticeNumber,
  CAST(e.creditor.idPA AS nvarchar(max)) AS idPA,
  CAST(e.creditor.companyName AS nvarchar(max)) AS companyName,
  CAST(e.paymentInfo.paymentDateTime AS nvarchar(max)) AS paymentDateTime,
  CAST(e.paymentInfo.dueDate AS nvarchar(max)) AS dueDate,
  CAST(e.paymentInfo.totalNotice AS nvarchar(max)) AS totalNotice,
  CAST(e.paymentInfo.touchpoint AS nvarchar(max)) AS touchpoint,
  CAST(e.paymentInfo.paymentChannel AS nvarchar(max)) AS paymentChannel,
  CAST(e.paymentInfo.amount AS nvarchar(max)) AS amount,
  CAST(e.paymentInfo.fee AS nvarchar(max)) AS fee,
  e.id AS id,
  e.timestamp AS timestamp
INTO [evh-tx-stream-send-filter]
FROM [evh-rx-stream-send-filter] e
QUERY

  tags = module.tag_config.tags

  lifecycle {
    ignore_changes = [streaming_units]
  }
}

resource "azurerm_stream_analytics_stream_input_eventhub" "biz_send_filter_stream_in" {
  count                        = var.env_short != "p" ? 1 : 0
  name                         = "evh-rx-stream-send-filter"
  stream_analytics_job_name    = azurerm_stream_analytics_job.biz_send_filter_stream[0].name
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
  count                     = var.env_short != "p" ? 1 : 0
  name                      = "evh-tx-stream-send-filter"
  stream_analytics_job_name = azurerm_stream_analytics_job.biz_send_filter_stream[0].name
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
  count              = var.env_short != "p" ? 1 : 0
  name               = "biz-send-filter-dlq-stream-logs"
  target_resource_id = azurerm_stream_analytics_job.biz_send_filter_stream[0].id
  storage_account_id = module.bizevents_sa.id

  enabled_log {
    category = "Execution"
  }
}
