resource "azurerm_resource_group" "buyerbanks_rg" {
  name     = format("%s-buyerbanks-rg", local.project)
  location = var.location

  tags = var.tags
}


#tfsec:ignore:azure-storage-default-action-deny
module "buyerbanks_storage" {

  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v2.0.28"

  name                       = replace(format("%s-buyerbanks-storage", local.project), "-", "")
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  account_replication_type   = var.buyer_banks_storage_account_replication_type
  access_tier                = "Hot"
  versioning_name            = "versioning"
  enable_versioning          = var.buyerbanks_enable_versioning
  resource_group_name        = azurerm_resource_group.buyerbanks_rg.name
  location                   = var.location
  advanced_threat_protection = var.buyerbanks_advanced_threat_protection
  allow_blob_public_access   = false

  blob_properties_delete_retention_policy_days = var.buyerbanks_delete_retention_days

  # TODO FIXME
  # network_rules = {
  #   default_action             = "Deny"
  #   ip_rules                   = []
  #   bypass                     = ["AzureServices"]
  #   virtual_network_subnet_ids = [module.buyerbanks_function_snet.id]
  # }

  tags = var.tags
}

## blob container buyerbanks
resource "azurerm_storage_container" "banks" {

  name                  = "banks"
  storage_account_name  = module.buyerbanks_storage.name
  container_access_type = "private"
}

# 🐞https://github.com/hashicorp/terraform-provider-azurerm/pull/15832
## blob lifecycle policy
resource "azurerm_storage_management_policy" "buyerbanks_storage_lifeclycle_policies" {
  storage_account_id = module.buyerbanks_storage.id

  rule {
    name    = "BlobRetentionRule"
    enabled = true
    filters {
      prefix_match = ["banks/"]
      blob_types   = ["blockBlob"]
    }
    actions {
      base_blob {
        delete_after_days_since_modification_greater_than           = 30
        tier_to_cool_after_days_since_last_access_time_greater_than = 0
      }
      snapshot {
        delete_after_days_since_creation_greater_than = 30
      }
    }
  }

}
