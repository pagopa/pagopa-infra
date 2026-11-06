resource "azurerm_stream_analytics_job" "biz_send_filter_stream" {
  name                                     = "${local.project}-evh-stream-send-filter-job"
  resource_group_name                      = azurerm_resource_group.bizevents_rg.name
  location                                 = var.location
  compatibility_level                      = "1.2"
  data_locale                              = "en-US"
  events_out_of_order_policy               = "Adjust"
  events_out_of_order_max_delay_in_seconds = 5
  output_error_policy                      = "Drop"
  streaming_units                          = 1

  transformation_query                     = <<QUERY
WITH parsed AS (
  SELECT udf.parseJson(e.payload) AS doc, e.payload AS payload
  FROM [evh-rx-send-filter] e
)

-- Valid JSON: keep only the selected fields (adjust to the fields required downstream)
SELECT p.doc.id
INTO [evh-tx-send-filter]
FROM parsed p
WHERE p.doc IS NOT NULL;

-- Corrupt JSON: store the raw payload in the DLQ
SELECT p.payload
INTO [blob-dlq-send-filter]
FROM parsed p
WHERE p.doc IS NULL;
QUERY

  tags = module.tag_config.tags
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

  # Raw string input: the payload is parsed in the query so corrupt JSON can be routed to the DLQ
  serialization {
    type            = "Csv"
    encoding        = "UTF8"
    field_delimiter = "\t"
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

## DLQ: corrupt payloads are stored in bizevents_sa / send_dead_letter_events
resource "azurerm_stream_analytics_output_blob" "biz_send_filter_stream_dlq" {
  name                      = "blob-dlq-send-filter"
  stream_analytics_job_name = azurerm_stream_analytics_job.biz_send_filter_stream.name
  resource_group_name       = azurerm_resource_group.bizevents_rg.name
  storage_account_name      = module.bizevents_sa.name
  storage_account_key       = module.bizevents_sa.primary_access_key
  storage_container_name    = azurerm_storage_container.send_dead_letter_events.name
  path_pattern              = "{date}/{time}"
  date_format               = "yyyy/MM/dd"
  time_format               = "HH"

  serialization {
    type     = "Json"
    encoding = "UTF8"
    format   = "LineSeparated"
  }
}

## Returns the parsed document, or null when the payload is not valid JSON
resource "azurerm_stream_analytics_function_javascript_udf" "parse_json" {
  name                      = "parseJson"
  stream_analytics_job_name = azurerm_stream_analytics_job.biz_send_filter_stream.name
  resource_group_name       = azurerm_resource_group.bizevents_rg.name

  script = <<SCRIPT
function parseJson(string) {
  try {
    return JSON.parse(string);
  } catch (error) {
    return null;
  }
}
SCRIPT

  input {
    type = "any"
  }

  output {
    type = "any"
  }
}
