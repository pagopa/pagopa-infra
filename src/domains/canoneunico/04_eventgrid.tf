resource "azurerm_eventgrid_system_topic" "storage_topic" {
  name                   = "${local.project}-cu-events-storage-topic"
  location               = var.location
  resource_group_name    = azurerm_resource_group.canoneunico_rg.name
  source_arm_resource_id = module.canoneunico_sa.id
  topic_type             = "Microsoft.Storage.StorageAccounts"

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_eventgrid_system_topic_event_subscription" "storage_subscription" {
  name                = "${local.project}-cu-events-storage-subscription"
  system_topic        = azurerm_eventgrid_system_topic.storage_topic.name
  resource_group_name = azurerm_resource_group.canoneunico_rg.name

  included_event_types = ["Microsoft.Storage.BlobCreated"]

  storage_queue_endpoint {
    storage_account_id = module.canoneunico_sa.id
    queue_name         = "pagopa${var.env_short}canoneunicosablobeventqueue"
  }

  subject_filter {
    subject_begins_with = "/blobServices/default/containers"
    subject_ends_with   = ".csv"
    case_sensitive      = false
  }

  advanced_filter {
    string_contains {
      key = "subject"
      values = [
        "pagopa${var.env_short}canoneunicosaincsvcontainer",
        "input/"
      ]
    }
    string_not_contains {
      key = "subject"
      values = [
        "error/",
        "output/",
        "pagopa${var.env_short}canoneunicosaerrcsvcontainer",
        "pagopa${var.env_short}canoneunicosaoutcsvcontainer"
      ]
    }
  }

  retry_policy {
    event_time_to_live    = 1440
    max_delivery_attempts = 30
  }

  depends_on = [azurerm_eventgrid_system_topic.storage_topic, azurerm_storage_queue.cu_blob_event_queue]
}
