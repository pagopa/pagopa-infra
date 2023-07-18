resource "azurerm_resource_group" "storage_ecommerce_rg" {
  name     = "${local.project}-storage-rg"
  location = var.location
  tags     = var.tags
}


module "ecommerce_storage_snet" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v6.7.0"

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

  tags = var.tags
}

module "ecommerce_storage_transient" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v6.7.0"


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
  tags = var.tags
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

  tags = var.tags
}

module "ecommerce_storage_deadletter" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v6.7.0"


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

  tags = var.tags
}

resource "azurerm_storage_queue" "transactions_dead_letter_queue" {
  name                 = "${local.project}-transactions-dead-letter-queue"
  storage_account_name = module.ecommerce_storage_deadletter.name
}

resource "azurerm_storage_queue" "notifications_service_errors_queue" {
  name                 = "${local.project}-notifications-service-errors-queue"
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
      "queue_key"   = "ecommerce-transactions-expiration-queue"
      "severity"    = 1
      "time_window" = 30
      "frequency"   = 15 
      "threshold"   = 10
    },
    {
      "queue_key"   = "ecommerce-transaction-notifications-queue"
      "severity"    = 1
      "time_window" = 30
      "frequency"   = 15 
      "threshold"   = 10
    },
    {
      "queue_key"   = "ecommerce-notifications-service-retry-queue"
      "severity"    = 1
      "time_window" = 30
      "frequency"   = 15 
      "threshold"   = 10
    },
    {
      "queue_key"   = "ecommerce-transaction-notifications-retry-queue"
      "severity"    = 1
      "time_window" = 30
      "frequency"   = 15 
      "threshold"   = 10
    },
    {
      "queue_key"   = "ecommerce-transactions-close-payment-queue"
      "severity"    = 1
      "time_window" = 30
      "frequency"   = 15 
      "threshold"   = 10
    },
    {
      "queue_key"   = "ecommerce-transactions-close-payment-retry-queue"
      "severity"    = 1
      "time_window" = 30
      "frequency"   = 15 
      "threshold"   = 10
    },
    {
      "queue_key"   = "ecommerce-transactions-refund-queue"
      "severity"    = 1
      "time_window" = 30
      "frequency"   = 15 
      "threshold"   = 10
    },
    {
      "queue_key"   = "ecommerce-transactions-refund-retry-queue"
      "severity"    = 1
      "time_window" = 30
      "frequency"   = 15 
      "threshold"   = 10
    },
  ] : []
}

# Queue size: Ecommerce - ecommerce queues enqueues rate alert
resource "azurerm_monitor_scheduled_query_rules_alert" "ecommerce_transient_enqueue_rate_alert" {
  for_each            = { for q in local.queue_transient_alert_prosp : q.queue_key => q }
  name                = "${local.project}-${each.value.queue_key}-rate-alert"
  resource_group_name = azurerm_resource_group.storage_ecommerce_rg.name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  data_source_id = module.ecommerce_storage_transient.id
  description    = format("Enqueuing rate for queue %s > ${each.threshold} during last ${each.value.time_window} minutes",replace("${each.value.queue_key}","-"," "))
  enabled        = true
  query = format(<<-QUERY
    let OpCountForQueue = (operation: string, queueKey: string) {
      StorageQueueLogs
      | where OperationName == operation and ObjectKey startswith queueKey
      | summarize count()
    };
    let MessageRateForQueue = (queueKey: string) {
      OpCountForQueue("PutMessage", queueKey)
      | join OpCountForQueue("DeleteMessage", queueKey) on count_
      | project name = queueKey, Count = count_ - count_1
      | where toint(Count) > ${each.value.threshold}
    };
    MessageRateForQueue("%s")
    QUERY
    , "${module.ecommerce_storage_transient.name}/pagopa-${var.env_short}-weu-${each.value.queue_key}"
  )
  severity    = each.value.severity
  frequency   = each.value.frequency
  time_window = each.value.time_window
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
}


locals {
  queue_deadletter_alert_props = var.env_short == "p" ? [
    {
      "queue_key"   = "ecommerce-notifications-service-errors-queue"
      "severity"    = 3
      "time_window" = 15
      "frequency"   = 15 
      "threshold"   = 0
    },
    {
      "queue_key"   = "ecommerce-transactions-dead-letter-queue"
      "severity"    = 3
      "time_window" = 15
      "frequency"   = 15 
      "threshold"   = 0
    },
  ] : []
}

# Queue size: Ecommerce - ecommerce deadletter queues write alert
resource "azurerm_monitor_scheduled_query_rules_alert" "ecommerce_deadletter_filling_rate_alert" {
  for_each            = { for q in local.queue_deadletter_alert_prosp : q.queue_key => q }
  name                = "${local.project}-${each.value.queue_key}-rate-alert"
  resource_group_name = azurerm_resource_group.storage_ecommerce_rg.name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  data_source_id = module.ecommerce_storage_deadletter.id
  description    = format("Deadletter message write happened in queue %s during the last ${each.value.time_window} mins",replace("${each.value.queue_key}","-"," "))
  enabled        = true
  query = format(<<-QUERY
      StorageQueueLogs
      | where OperationName == "PutMessage" and ObjectKey startswith "%s"
      | summarize count()
      | where toint(count_) > ${each.value.threshold}
    QUERY
    , "${module.ecommerce_storage_deadletter.name}/pagopa-${var.env_short}-weu-${each.value.queue_key}"
  )
  severity    = each.value.severity
  frequency   = each.value.frequency
  time_window = each.value.time_window
  trigger {
    operator  = "GreaterThan"
    threshold = 0
  }
}