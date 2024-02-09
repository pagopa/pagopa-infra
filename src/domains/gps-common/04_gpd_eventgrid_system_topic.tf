resource "azurerm_eventgrid_system_topic" "storage_topic" {
  name                   = "${local.product}-gpd-events-storage-topic"
  location               = var.location
  resource_group_name    = azurerm_resource_group.gpd_rg.name
  source_arm_resource_id = module.gpd_sa_sftp.id
  topic_type             = "Microsoft.Storage.StorageAccounts"

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_eventgrid_system_topic_event_subscription" "storage_subscription" {
  name                = "${local.product}-gpd-events-storage-subscription"
  system_topic        = azurerm_eventgrid_system_topic.storage_topic.name
  resource_group_name = azurerm_resource_group.gpd_rg.name

  included_event_types = ["Microsoft.Storage.BlobCreated"]

  storage_queue_endpoint {
    storage_account_id = module.gpd_sa_sftp.id
    queue_name         = "gpd-blob-events-queue"
  }

  subject_filter {
    subject_begins_with = "/blobServices/default/containers"
    subject_ends_with   = ".json"
    case_sensitive      = false
  }

  advanced_filter {
    string_not_contains {
      key = "subject"
      values = [
        "azure-webjobs-hosts", "azure-webjobs-secrets", "report"
      ]
    }
  }

  retry_policy {
    event_time_to_live    = 1440
    max_delivery_attempts = 30
  }

  depends_on = [azurerm_eventgrid_system_topic.storage_topic, azurerm_storage_queue.gpd_blob_events_queue, azurerm_storage_queue.gpd_valid_positions_queue]
}
