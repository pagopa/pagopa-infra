resource "azurerm_resource_group" "storage_pay_wallet_rg" {
  name     = "${local.project}-storage-rg"
  location = var.location
  tags     = var.tags
}

module "pay_wallet_storage" {

  count  = var.is_feature_enabled.storage ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v8.5.0"

  name                                       = replace("${local.project}-sa", "-", "")
  account_kind                               = var.pay_wallet_storage_params.kind
  account_tier                               = var.pay_wallet_storage_params.tier
  account_replication_type                   = var.pay_wallet_storage_params.account_replication_type
  access_tier                                = "Hot"
  blob_versioning_enabled                    = true
  resource_group_name                        = azurerm_resource_group.storage_pay_wallet_rg.name
  location                                   = var.location
  enable_resource_advanced_threat_protection = var.pay_wallet_storage_params.advanced_threat_protection
  advanced_threat_protection                 = var.pay_wallet_storage_params.advanced_threat_protection
  allow_nested_items_to_be_public            = false
  public_network_access_enabled              = var.pay_wallet_storage_params.public_network_access_enabled

  blob_delete_retention_days = var.pay_wallet_storage_params.retention_days

  network_rules = var.env_short != "d" ? {
    default_action             = "Deny"
    ip_rules                   = []
    virtual_network_subnet_ids = [module.storage_pay_wallet_snet.id]
    bypass                     = ["AzureServices"]
  } : null
  tags = var.tags
}


resource "azurerm_private_endpoint" "storage_private_endpoint" {
  count = var.is_feature_enabled.storage && var.env_short != "d" ? 1 : 0

  name                = "${local.project}-tr-storage-private-endpoint"
  location            = var.location
  resource_group_name = azurerm_resource_group.storage_pay_wallet_rg.name
  subnet_id           = module.storage_pay_wallet_snet.id
  private_dns_zone_group {
    name                 = "${local.project}-storage-private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_blob_azure_com.id]
  }

  private_service_connection {
    name                           = "${local.project}-storage-private-service-connection"
    private_connection_resource_id = module.pay_wallet_storage[0].id
    is_manual_connection           = false
    subresource_names              = ["queue"]
  }

  tags = var.tags
}

resource "azurerm_storage_queue" "pay_wallet_usage_update_queue" {
  count                = var.is_feature_enabled.storage ? 1 : 0
  name                 = "${local.project}-usage-update-queue"
  storage_account_name = module.pay_wallet_storage[0].name
}

//storage queue for blue deployment
resource "azurerm_storage_queue" "pay_wallet_usage_update_queue_blue" {
  count                = var.is_feature_enabled.storage && var.env_short == "u" ? 1 : 0
  name                 = "${local.project}-usage-update-queue-b"
  storage_account_name = module.pay_wallet_storage[0].name
}

# wallet queue alert diagnostic settings
resource "azurerm_monitor_diagnostic_setting" "pay_wallet_queue_diagnostics" {
  count                      = var.is_feature_enabled.storage && var.env_short == "p" ? 1 : 0
  name                       = "${module.pay_wallet_storage[0].name}-diagnostics"
  target_resource_id         = "${module.pay_wallet_storage[0].id}/queueServices/default/"
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics_italy.id

  enabled_log {
    category = "StorageWrite"

    retention_policy {
      enabled = true
      days    = 3
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
      days    = 3
    }
  }
}

locals {
  queue_alert_props = var.env_short == "p" ? [
    {
      queue_key   = "usage-update-queue"
      severity    = 1
      time_window = 30
      frequency   = 15
      threshold   = 10
    },
  ] : []
}

# Queue size: wallet - wallet queues enqueues rate alert
resource "azurerm_monitor_scheduled_query_rules_alert" "pay_wallet_enqueue_rate_alert" {
  for_each            = var.is_feature_enabled.storage ? { for q in local.queue_alert_props : q.queue_key => q } : {}
  name                = "${local.project}-${each.value.queue_key}-rate-alert"
  resource_group_name = azurerm_resource_group.storage_pay_wallet_rg.name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  data_source_id = module.pay_wallet_storage[0].id
  description    = format("Enqueuing rate for queue %s > ${each.value.threshold} during last ${each.value.time_window} minutes", replace("${each.value.queue_key}", "-", " "))
  enabled        = true
  query = format(<<-QUERY
    let OpCountForQueue = (operation: string, queueKey: string) {
      StorageQueueLogs
      | where OperationName == operation and ObjectKey startswith queueKey
      | summarize count()
    };
    let MessageRateForQueue = (queueKey: string) {
      OpCountForQueue("PutMessage", queueKey)
      | join kind=fullouter OpCountForQueue("DeleteMessage", queueKey) on count_
      | project name = queueKey, Count = count_ - count_1
    };
    MessageRateForQueue("%s")
    | where Count > ${each.value.threshold}
    QUERY
    , "/${module.pay_wallet_storage[0].name}/${local.project}-${each.value.queue_key}"
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
      "storage_account_id"   = can(module.pay_wallet_storage[0].id) ? module.pay_wallet_storage[0].id : ""
      "storage_account_name" = can(module.pay_wallet_storage[0].name) ? module.pay_wallet_storage[0].name : ""
      "severity"             = 1
      "time_window"          = "PT1H"
      "frequency"            = "PT15M"
      "threshold"            = 1000
    },
  ] : []
}

resource "azurerm_monitor_metric_alert" "queue_storage_account_average_message_count" {
  for_each = var.is_feature_enabled.storage ? { for q in local.storage_accounts_queue_message_count_alert_props : q.storage_account_id => q } : {}

  action {
    action_group_id = data.azurerm_monitor_action_group.email.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack.id
  }

  # action {
  #   action_group_id = azurerm_monitor_action_group.pay_wallet_opsgenie[0].id
  # }

  name                = "[${var.domain != null ? "${var.domain} | " : ""}${each.value.storage_account_name}] Queue message count average exceeds ${each.value.threshold}"
  resource_group_name = azurerm_resource_group.storage_pay_wallet_rg.name
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