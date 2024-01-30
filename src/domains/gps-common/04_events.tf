resource "azurerm_eventgrid_system_topic" "storage_topic" {
  name                   = format("%s-gpd-events-storage-topic", local.product)
  location               = var.location
  resource_group_name    = azurerm_resource_group.gpd_rg.name
  source_arm_resource_id = module.gpd_sa_sftp.id
  topic_type             = "Microsoft.Storage.StorageAccounts"

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_eventgrid_system_topic_event_subscription" "storage_subscription" {
  name                = "${local.project}-events-storage-subscription"
  system_topic        = azurerm_eventgrid_system_topic.storage_topic.name
  resource_group_name = azurerm_resource_group.gpd_rg.name

  webhook_endpoint {
    url                               = "https://api.${var.env}.platform.pagopa.it/gpd/event/v1/upload"
    max_events_per_batch              = 1
    preferred_batch_size_in_kilobytes = 64
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

  delivery_property {
    header_name = "Ocp-Apim-Subscription-Key"
    type        = "Static"
    value       = azurerm_key_vault_secret.gpd_upload_fn_subkey.value
    secret      = true
  }

  delivery_identity {
    type = "SystemAssigned"
  }
}
