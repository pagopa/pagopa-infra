resource "azurerm_resource_group" "storage_ecommerce_rg" {
  name     = "${local.project}-storage-rg"
  location = var.location
  tags     = module.tag_config.tags
}


module "ecommerce_storage_snet" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v8.42.3"

  name                 = "${local.project}-storage-snet"
  address_prefixes     = var.cidr_subnet_storage_ecommerce
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.vnet_name

  private_endpoint_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Storage",
  ]
}


resource "azurerm_private_endpoint" "storage_transient_private_endpoint" {
  count = var.env_short != "d" ? 1 : 0

  name                = "${local.project}-tr-storage-private-endpoint"
  location            = var.location
  resource_group_name = azurerm_resource_group.storage_ecommerce_rg.name
  subnet_id           = module.ecommerce_storage_snet.id
  private_dns_zone_group {
    name                 = "${local.project}-storage-private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.storage.id]
  }

  private_service_connection {
    name                           = "${local.project}-storage-private-service-connection"
    private_connection_resource_id = module.ecommerce_storage_transient.id
    is_manual_connection           = false
    subresource_names              = ["queue"]
  }

  tags = module.tag_config.tags
}

module "ecommerce_storage_transient" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v8.42.3"


  name                            = replace("${local.project}-tr-sa", "-", "")
  account_kind                    = var.ecommerce_storage_transient_params.kind
  account_tier                    = var.ecommerce_storage_transient_params.tier
  account_replication_type        = var.ecommerce_storage_transient_params.account_replication_type
  access_tier                     = "Hot"
  blob_versioning_enabled         = true
  resource_group_name             = azurerm_resource_group.storage_ecommerce_rg.name
  location                        = var.location
  advanced_threat_protection      = var.ecommerce_storage_transient_params.advanced_threat_protection
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = var.ecommerce_storage_transient_params.public_network_access_enabled

  blob_delete_retention_days = var.ecommerce_storage_transient_params.retention_days

  network_rules = var.env_short != "d" ? {
    default_action             = "Deny"
    ip_rules                   = []
    virtual_network_subnet_ids = [module.ecommerce_storage_snet.id]
    bypass                     = ["AzureServices"]
  } : null
  tags = module.tag_config.tags
}

resource "azurerm_storage_queue" "notifications_service_retry_queue" {
  name                 = "${local.project}-notifications-service-retry-queue"
  storage_account_name = module.ecommerce_storage_transient.name
}

resource "azurerm_storage_queue" "transactions_expiration_queue" {
  name                 = "${local.project}-transactions-expiration-queue"
  storage_account_name = module.ecommerce_storage_transient.name
}

resource "azurerm_storage_queue" "transactions_close_payment_queue" {
  name                 = "${local.project}-transactions-close-payment-queue"
  storage_account_name = module.ecommerce_storage_transient.name
}

resource "azurerm_storage_queue" "transactions_close_payment_retry_queue" {
  name                 = "${local.project}-transactions-close-payment-retry-queue"
  storage_account_name = module.ecommerce_storage_transient.name
}

resource "azurerm_storage_queue" "transactions_refund_retry_queue" {
  name                 = "${local.project}-transactions-refund-retry-queue"
  storage_account_name = module.ecommerce_storage_transient.name
}

resource "azurerm_storage_queue" "transactions_refund_queue" {
  name                 = "${local.project}-transactions-refund-queue"
  storage_account_name = module.ecommerce_storage_transient.name
}

resource "azurerm_storage_queue" "transactions_notifications_retry_queue" {
  name                 = "${local.project}-transaction-notifications-retry-queue"
  storage_account_name = module.ecommerce_storage_transient.name
}

resource "azurerm_storage_queue" "transactions_notifications_queue" {
  name                 = "${local.project}-transaction-notifications-queue"
  storage_account_name = module.ecommerce_storage_transient.name
}

resource "azurerm_storage_queue" "transactions_authorization_requested_queue" {
  name                 = "${local.project}-transaction-auth-requested-queue"
  storage_account_name = module.ecommerce_storage_transient.name
}

resource "azurerm_storage_queue" "transactions_authorization_outcome_waiting_queue" {
  name                 = "${local.project}-transaction-auth-outcome-waiting-queue"
  storage_account_name = module.ecommerce_storage_transient.name
}
//storage queue for blue deployment
resource "azurerm_storage_queue" "notifications_service_retry_queue_blue" {
  count                = var.env_short != "p" ? 1 : 0
  name                 = "${local.project}-notifications-service-retry-queue-b"
  storage_account_name = module.ecommerce_storage_transient.name
}

resource "azurerm_storage_queue" "transactions_expiration_queue_blue" {
  count                = var.env_short != "p" ? 1 : 0
  name                 = "${local.project}-transactions-expiration-queue-b"
  storage_account_name = module.ecommerce_storage_transient.name
}

resource "azurerm_storage_queue" "transactions_close_payment_queue_blue" {
  count                = var.env_short != "p" ? 1 : 0
  name                 = "${local.project}-transactions-close-payment-queue-b"
  storage_account_name = module.ecommerce_storage_transient.name
}

resource "azurerm_storage_queue" "transactions_close_payment_retry_queue_blue" {
  count                = var.env_short != "p" ? 1 : 0
  name                 = "${local.project}-transactions-close-payment-retry-queue-b"
  storage_account_name = module.ecommerce_storage_transient.name
}

resource "azurerm_storage_queue" "transactions_refund_retry_queue_blue" {
  count                = var.env_short != "p" ? 1 : 0
  name                 = "${local.project}-transactions-refund-retry-queue-b"
  storage_account_name = module.ecommerce_storage_transient.name
}

resource "azurerm_storage_queue" "transactions_refund_queue_blue" {
  count                = var.env_short != "p" ? 1 : 0
  name                 = "${local.project}-transactions-refund-queue-b"
  storage_account_name = module.ecommerce_storage_transient.name
}

resource "azurerm_storage_queue" "transactions_notifications_retry_queue_blue" {
  count                = var.env_short != "p" ? 1 : 0
  name                 = "${local.project}-transaction-notifications-retry-queue-b"
  storage_account_name = module.ecommerce_storage_transient.name
}

resource "azurerm_storage_queue" "transactions_notifications_queue_blue" {
  count                = var.env_short != "p" ? 1 : 0
  name                 = "${local.project}-transaction-notifications-queue-b"
  storage_account_name = module.ecommerce_storage_transient.name
}

resource "azurerm_storage_queue" "transactions_authorization_requested_queue_blue" {
  count                = var.env_short != "p" ? 1 : 0
  name                 = "${local.project}-transaction-auth-requested-queue-b"
  storage_account_name = module.ecommerce_storage_transient.name
}

resource "azurerm_storage_queue" "transactions_authorization_outcome_waiting_queue_blue" {
  count                = var.env_short != "p" ? 1 : 0
  name                 = "${local.project}-transaction-auth-outcome-waiting-queue-b"
  storage_account_name = module.ecommerce_storage_transient.name
}

resource "azurerm_private_endpoint" "storage_deadletter_private_endpoint" {
  count = var.env_short != "d" ? 1 : 0

  name                = "${local.project}-dl-storage-private-endpoint"
  location            = var.location
  resource_group_name = azurerm_resource_group.storage_ecommerce_rg.name
  subnet_id           = module.ecommerce_storage_snet.id

  private_dns_zone_group {
    name                 = "${local.project}-storage-private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.storage.id]
  }

  private_service_connection {
    name                           = "${local.project}-storage-private-service-connection"
    private_connection_resource_id = module.ecommerce_storage_deadletter.id
    is_manual_connection           = false
    subresource_names              = ["queue"]
  }

  tags = module.tag_config.tags
}

module "ecommerce_storage_deadletter" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v8.42.3"


  name                            = replace("${local.project}-dl-sa", "-", "")
  account_kind                    = var.ecommerce_storage_deadletter_params.kind
  account_tier                    = var.ecommerce_storage_deadletter_params.tier
  account_replication_type        = var.ecommerce_storage_deadletter_params.account_replication_type
  access_tier                     = "Hot"
  blob_versioning_enabled         = true
  resource_group_name             = azurerm_resource_group.storage_ecommerce_rg.name
  location                        = var.location
  advanced_threat_protection      = var.ecommerce_storage_deadletter_params.advanced_threat_protection
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = var.ecommerce_storage_deadletter_params.public_network_access_enabled

  blob_delete_retention_days = var.ecommerce_storage_deadletter_params.retention_days

  network_rules = var.env_short != "d" ? {
    default_action             = "Deny"
    ip_rules                   = []
    virtual_network_subnet_ids = [module.ecommerce_storage_snet.id]
    bypass                     = ["AzureServices"]
  } : null

  tags = module.tag_config.tags
}

resource "azurerm_storage_queue" "transactions_dead_letter_queue" {
  name                 = "${local.project}-transactions-dead-letter-queue"
  storage_account_name = module.ecommerce_storage_deadletter.name
}

resource "azurerm_storage_queue" "notifications_service_errors_queue" {
  name                 = "${local.project}-notifications-service-errors-queue"
  storage_account_name = module.ecommerce_storage_deadletter.name
}

//dead letter queues for blue deployment
resource "azurerm_storage_queue" "transactions_dead_letter_queue_blue" {
  count                = var.env_short != "p" ? 1 : 0
  name                 = "${local.project}-transactions-dead-letter-queue-b"
  storage_account_name = module.ecommerce_storage_deadletter.name
}

resource "azurerm_storage_queue" "notifications_service_errors_queue_blue" {
  count                = var.env_short != "p" ? 1 : 0
  name                 = "${local.project}-notifications-service-errors-queue-b"
  storage_account_name = module.ecommerce_storage_deadletter.name
}

# Ecommerce transient queue alert diagnostic settings
resource "azurerm_monitor_diagnostic_setting" "ecommerce_transient_queue_diagnostics" {
  count                      = var.env_short == "p" ? 1 : 0
  name                       = "${module.ecommerce_storage_transient.name}-diagnostics"
  target_resource_id         = "${module.ecommerce_storage_transient.id}/queueServices/default/"
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics.id

  enabled_log {
    category = "StorageWrite"

    retention_policy {
      enabled = true
      days    = 7
    }
  }
  metric {
    category = "Capacity"
    enabled  = false

    retention_policy {
      days    = 0
      enabled = false
    }
  }
  metric {
    category = "Transaction"
    enabled  = false

    retention_policy {
      days    = 0
      enabled = false
    }
  }


  enabled_log {
    category = "StorageDelete"

    retention_policy {
      enabled = true
      days    = 7
    }
  }
}

locals {
  queue_transient_alert_props = var.env_short == "p" ? [
    {
      "queue_key"         = "transaction-notifications-queue"
      "severity"          = 1
      "time_window"       = 30
      "fetch_time_window" = 45
      "frequency"         = 15
      "threshold"         = 20
      "dynamic_threshold" = 2.0
    },
    {
      "queue_key"         = "transactions-close-payment-queue"
      "severity"          = 1
      "time_window"       = 30
      "fetch_time_window" = 45
      "frequency"         = 15
      "threshold"         = 20
      "dynamic_threshold" = 2.0
    },
    {
      "queue_key"         = "transactions-refund-queue"
      "severity"          = 1
      "time_window"       = 30
      "fetch_time_window" = 45
      "frequency"         = 15
      "threshold"         = 20
      "dynamic_threshold" = 2.0
    },
    {
      "queue_key"         = "transaction-auth-outcome-waiting-queue"
      "severity"          = 1
      "time_window"       = 30
      "fetch_time_window" = 45
      "frequency"         = 15
      "threshold"         = 100
      "dynamic_threshold" = 3.0
    },
    {
      "queue_key"         = "transaction-auth-requested-queue"
      "severity"          = 1
      "time_window"       = 30
      "fetch_time_window" = 45
      "frequency"         = 15
      "threshold"         = 400
      "dynamic_threshold" = 3.0
    }
  ] : []
}

# Queue size: Ecommerce - ecommerce queues enqueues rate alert
resource "azurerm_monitor_scheduled_query_rules_alert" "ecommerce_transient_enqueue_rate_alert" {
  for_each            = { for q in local.queue_transient_alert_props : q.queue_key => q }
  name                = "${local.project}-${each.value.queue_key}-rate-alert"
  resource_group_name = azurerm_resource_group.storage_ecommerce_rg.name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.ecommerce_opsgenie[0].id, azurerm_monitor_action_group.service_management_opsgenie[0].id]
    email_subject          = "[eCommerce] Enqueue rate for transient queue too high (instant processing)"
    custom_webhook_payload = "{}"
  }
  data_source_id = module.ecommerce_storage_transient.id
  description    = format("Enqueuing rate for queue %s > ${each.value.dynamic_threshold} percent threshold of 'PutMessage' (at least 10) during last ${each.value.time_window} minutes", replace("${each.value.queue_key}", "-", " "))
  enabled        = true
  query = format(<<-QUERY
    let endDelete = ago(10m);
    let startDelete = endDelete - ${each.value.time_window}m;
    let endPut = endDelete;
    let startPut = endPut - ${each.value.time_window}m;
    let OpCountForQueue = (operation: string, queueKey: string, timestart: datetime, timeend: datetime) {
        StorageQueueLogs
        | where OperationName == operation and ObjectKey startswith queueKey
        | where TimeGenerated between (timestart .. timeend)
        | summarize count()
        | project count_
        | extend dummy=1
    };
    let PutMessages = (queueName: string, timestart: datetime, timeend: datetime) {
      OpCountForQueue("PutMessage", queueName, timestart, timeend)
        | project PutCount = count_
        | extend dummy = 1
    };
    let DeletedMessages =  (queueName: string, timestart: datetime, timeend: datetime) {
      OpCountForQueue("DeleteMessage", queueName, timestart, timeend)
        | project DeleteCount = count_
        | extend dummy = 1
    };
    let MessageRateForQueue = (queueKey: string, timestartPut: datetime, timeendPut: datetime, timestartDelete: datetime, timeendDelete: datetime) {
        PutMessages(queueKey, timestartPut, timeendPut)
        | join kind=inner (DeletedMessages(queueKey, timestartDelete, timeendDelete)) on dummy
        | extend Diff = PutCount - DeleteCount
        | project PutCount, DeleteCount, Diff
    };
    MessageRateForQueue("%s", startPut, endPut, startDelete, endDelete)
    | where Diff > max_of(PutCount*(${each.value.dynamic_threshold}/100.0), ${each.value.threshold})
    QUERY
    , "/${module.ecommerce_storage_transient.name}/${local.project}-${each.value.queue_key}"
  )
  severity    = each.value.severity
  frequency   = each.value.frequency
  time_window = each.value.fetch_time_window
  trigger {
    operator  = "GreaterThan"
    threshold = 0
  }
}

locals {
  queue_expiration_alert_props = var.env_short == "p" ? [
    {
      "queue_key"         = "transactions-expiration-queue"
      "severity"          = 1
      "time_window"       = 15
      "fetch_time_window" = 75
      "frequency"         = 15
      "threshold"         = 40
    },
    {
      "queue_key"         = "notifications-service-retry-queue"
      "severity"          = 1
      "time_window"       = 30
      "fetch_time_window" = 75
      "frequency"         = 15
      "threshold"         = 10
    },
    {
      "queue_key"         = "transaction-notifications-retry-queue"
      "severity"          = 1
      "time_window"       = 30
      "fetch_time_window" = 75
      "frequency"         = 15
      "threshold"         = 20
    },
    {
      "queue_key"         = "transactions-refund-retry-queue"
      "severity"          = 1
      "time_window"       = 30
      "fetch_time_window" = 75
      "frequency"         = 15
      "threshold"         = 10
    },
    {
      "queue_key"         = "transactions-close-payment-retry-queue"
      "severity"          = 1
      "time_window"       = 30
      "fetch_time_window" = 75
      "frequency"         = 15
      "threshold"         = 10
    }
  ] : []
}

# Queue size: Ecommerce - ecommerce queues enqueues rate alert
resource "azurerm_monitor_scheduled_query_rules_alert" "ecommerce_enqueue_rate_alert_visibility_timeout_diff" {
  for_each            = { for q in local.queue_expiration_alert_props : q.queue_key => q }
  name                = "${local.project}-${each.value.queue_key}-rate-alert"
  resource_group_name = azurerm_resource_group.storage_ecommerce_rg.name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.ecommerce_opsgenie[0].id, azurerm_monitor_action_group.service_management_opsgenie[0].id]
    email_subject          = "[eCommerce] Enqueue rate for transient queue too high (delayed processing)"
    custom_webhook_payload = "{}"
  }
  data_source_id = module.ecommerce_storage_transient.id
  description    = format("Enqueuing rate for queue %s > ${each.value.threshold} during last ${each.value.time_window} minutes", replace("${each.value.queue_key}", "-", " "))
  enabled        = true
  query = format(<<-QUERY
    let endDelete = ago(10m);
    let startDelete = endDelete - ${each.value.time_window}m;
    let endPut = startDelete;
    let startPut = endPut - ${each.value.time_window}m;
    let OpCountForQueue = (operation: string, queueKey: string, timestart: datetime, timeend: datetime) {
        StorageQueueLogs
        | where OperationName == operation and ObjectKey startswith queueKey
        | where TimeGenerated between(timestart .. timeend)
        | summarize count()
        | project count_
        | extend dummy=1
    };
    let PutMessages = (queueName: string, timestart: datetime, timeend: datetime) {
      OpCountForQueue("PutMessage", queueName, timestart, timeend)
        | project PutCount = count_
        | extend dummy = 1
    };
    let DeletedMessages =  (queueName: string, timestart: datetime, timeend: datetime) {
      OpCountForQueue("DeleteMessage", queueName, timestart, timeend)
        | project DeleteCount = count_
        | extend dummy = 1
    };
    let MessageRateForQueue = (queueKey: string, timestartPut: datetime, timeendPut: datetime, timestartDelete: datetime, timeendDelete: datetime) {
        PutMessages(queueKey, timestartPut, timeendPut)
        | join kind=inner (DeletedMessages(queueKey, timestartDelete, timeendDelete)) on dummy
        | extend Diff = PutCount - DeleteCount
        | project PutCount, DeleteCount, Diff
    };
    MessageRateForQueue("%s", startPut, endPut, startDelete, endDelete)
    | where Diff > ${each.value.threshold}
    QUERY
    , "/${module.ecommerce_storage_transient.name}/${local.project}-${each.value.queue_key}"
  )
  severity    = each.value.severity
  frequency   = each.value.frequency
  time_window = each.value.fetch_time_window
  trigger {
    operator  = "GreaterThan"
    threshold = 0
  }
}


# eCommerce deadletter queue alert diagnostic settings
resource "azurerm_monitor_diagnostic_setting" "ecommerce_deadletter_queue_diagnostics" {
  count                      = var.env_short == "p" ? 1 : 0
  name                       = "${module.ecommerce_storage_deadletter.name}-diagnostics"
  target_resource_id         = "${module.ecommerce_storage_deadletter.id}/queueServices/default/"
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics.id

  enabled_log {
    category = "StorageWrite"

    retention_policy {
      enabled = true
      days    = 7
    }
  }
  metric {
    category = "Capacity"
    enabled  = false

    retention_policy {
      days    = 0
      enabled = false
    }
  }
  metric {
    category = "Transaction"
    enabled  = false

    retention_policy {
      days    = 0
      enabled = false
    }
  }

}


locals {
  queue_deadletter_alert_props = var.env_short == "p" ? [
    {
      "queue_key"   = "notifications-service-errors-queue"
      "severity"    = 3
      "time_window" = 15
      "frequency"   = 15
      "threshold"   = 5
    },
    {
      "queue_key"   = "transactions-dead-letter-queue"
      "severity"    = 3
      "time_window" = 15
      "frequency"   = 15
      "threshold"   = 25
    },
  ] : []
}

# Queue size: Ecommerce - ecommerce deadletter queues write alert
resource "azurerm_monitor_scheduled_query_rules_alert" "ecommerce_deadletter_filling_rate_alert" {
  for_each            = { for q in local.queue_deadletter_alert_props : q.queue_key => q }
  name                = "${local.project}-${each.value.queue_key}-rate-alert"
  resource_group_name = azurerm_resource_group.storage_ecommerce_rg.name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.ecommerce_opsgenie[0].id, azurerm_monitor_action_group.service_management_opsgenie[0].id]
    email_subject          = "[eCommerce] Writes for dead letter queue too high"
    custom_webhook_payload = "{}"
  }
  data_source_id = module.ecommerce_storage_deadletter.id
  description    = format("Deadletter message write happened in queue %s during the last ${each.value.time_window} mins", replace("${each.value.queue_key}", "-", " "))
  enabled        = true
  query = format(<<-QUERY
      StorageQueueLogs
      | where OperationName == "PutMessage" and ObjectKey startswith "%s"
      | summarize count()
      | where count_ > ${each.value.threshold}
    QUERY
    , "/${module.ecommerce_storage_deadletter.name}/${local.project}-${each.value.queue_key}"
  )
  severity    = each.value.severity
  frequency   = each.value.frequency
  time_window = each.value.time_window
  trigger {
    operator  = "GreaterThan"
    threshold = 0
  }
}

locals {
  storage_accounts_queue_message_count_alert_props = var.env_short == "p" ? [
    {
      "storage_account_id"   = "${module.ecommerce_storage_transient.id}"
      "storage_account_name" = "${module.ecommerce_storage_transient.name}"
      "severity"             = 1
      "time_window"          = "PT1H"
      "frequency"            = "PT15M"
      "threshold"            = 10000
    },
    {
      "storage_account_id"   = "${module.ecommerce_storage_deadletter.id}"
      "storage_account_name" = "${module.ecommerce_storage_deadletter.name}"
      "severity"             = 1
      "time_window"          = "PT1H"
      "frequency"            = "PT15M"
      "threshold"            = 200
    },
  ] : []
}

resource "azurerm_monitor_metric_alert" "queue_storage_account_average_messge_count" {
  for_each = { for q in local.storage_accounts_queue_message_count_alert_props : q.storage_account_id => q }

  action {
    action_group_id = data.azurerm_monitor_action_group.email.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack.id
  }

  action {
    action_group_id = azurerm_monitor_action_group.ecommerce_opsgenie[0].id
  }

  action {
    action_group_id = azurerm_monitor_action_group.service_management_opsgenie[0].id
  }

  name                = "[${var.domain != null ? "${var.domain} | " : ""}${each.value.storage_account_name}] Queue message count average exceeds ${each.value.threshold}"
  resource_group_name = azurerm_resource_group.storage_ecommerce_rg.name
  scopes              = ["${each.value.storage_account_id}/queueServices/default"]
  description         = "Queue message count average exceeds ${each.value.threshold} for the storage"
  severity            = each.value.severity
  window_size         = each.value.time_window
  frequency           = each.value.frequency
  auto_mitigate       = false
  # Metric info
  # https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/metrics-supported#microsoftclassicstoragestorageaccountsqueueservices
  criteria {
    metric_namespace       = "Microsoft.Storage/storageAccounts/queueServices"
    metric_name            = "QueueMessageCount"
    aggregation            = "Average"
    operator               = "GreaterThan"
    threshold              = each.value.threshold
    skip_metric_validation = false
  }
}

## storage to support pm transaction migration for helpdesk-service
module "ecommerce_pm_history_storage" {
  count  = var.env_short == "p" ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v8.42.3"

  name                            = replace("${local.project}-pm-h-sa", "-", "")
  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  account_replication_type        = "GZRS"
  access_tier                     = "Hot"
  blob_versioning_enabled         = true
  resource_group_name             = azurerm_resource_group.storage_ecommerce_rg.name
  location                        = var.location
  advanced_threat_protection      = true
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true
  blob_delete_retention_days      = 30

  network_rules = null

  tags = module.tag_config.tags
}

## table#1 storage pm-transaction-ecommerce-history-logs
resource "azurerm_storage_table" "pm_history_ingestion_log_table" {
  count                = var.env_short == "p" ? 1 : 0
  name                 = "pmHistoryIngestionLogTable"
  storage_account_name = module.ecommerce_pm_history_storage[0].name
}

## storage to support ecommerce reporting
module "ecommerce_reporting_storage" {
  source = "./.terraform/modules/__v3__/storage_account"

  name                            = replace("${local.project}-rep-sa", "-", "")
  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  account_replication_type        = "GZRS"
  access_tier                     = "Hot"
  blob_versioning_enabled         = true
  resource_group_name             = azurerm_resource_group.storage_ecommerce_rg.name
  location                        = var.location
  advanced_threat_protection      = true
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true
  blob_delete_retention_days      = 30

  network_rules = null

  tags = module.tag_config.tags
}

resource "azurerm_storage_table" "ecommerce_reporting_table" {
  name                 = "TransactionStatusReporting"
  storage_account_name = module.ecommerce_reporting_storage.name
}
