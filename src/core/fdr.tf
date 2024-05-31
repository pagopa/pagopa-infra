## Fdr - Flussi di rendicontazione

## Storage Account
module "fdr_flows_sa" {
  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v2.0.28"

  name                       = replace(format("%s-fdr-flows-sa", local.project), "-", "")
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  account_replication_type   = var.fdr_flow_sa_replication_type
  access_tier                = "Hot"
  versioning_name            = "versioning"
  enable_versioning          = var.fdr_enable_versioning
  resource_group_name        = azurerm_resource_group.data.name
  location                   = var.location
  advanced_threat_protection = var.fdr_advanced_threat_protection
  allow_blob_public_access   = false

  blob_properties_delete_retention_policy_days = var.fdr_delete_retention_days

  tags = var.tags
}

## blob container flows
resource "azurerm_storage_container" "fdr_rend_flow" {
  name                  = format("%sxmlfdrflow", module.fdr_flows_sa.name)
  storage_account_name  = module.fdr_flows_sa.name
  container_access_type = "private"
}


## blob container flows OUTPUT
resource "azurerm_storage_container" "fdr_rend_flow_out" {
  name                  = format("%sxmlfdrflowout", module.fdr_flows_sa.name)
  storage_account_name  = module.fdr_flows_sa.name
  container_access_type = "private"
}


## 🐞https://github.com/hashicorp/terraform-provider-azurerm/pull/15832
## blob lifecycle policy
# https://azure.microsoft.com/it-it/blog/azure-blob-storage-lifecycle-management-now-generally-available/
resource "azurerm_storage_management_policy" "storage_account_fdr_management_policy" {
  storage_account_id = module.fdr_flows_sa.id

  rule {
    name    = "deleteafterdays"
    enabled = true
    filters {
      prefix_match = [format("%s/", azurerm_storage_container.fdr_rend_flow_out.name)]
      blob_types   = ["blockBlob"]
    }

    # https://docs.microsoft.com/en-us/azure/storage/blobs/access-tiers-overview
    actions {
      # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy#delete_after_days_since_modification_greater_than
      base_blob {
        tier_to_cool_after_days_since_modification_greater_than     = 0
        tier_to_archive_after_days_since_modification_greater_than  = 0
        delete_after_days_since_modification_greater_than           = var.reporting_fdr_blobs_retention_days
        tier_to_cool_after_days_since_last_access_time_greater_than = 0
      }
      snapshot {
        delete_after_days_since_creation_greater_than = 30
      }
    }
  }

}


# https://medium.com/marcus-tee-anytime/secure-azure-blob-storage-with-azure-api-management-managed-identities-b0b82b53533c

# 1 - add Blob Data Contributor to apim for Fdr blob storage
resource "azurerm_role_assignment" "data_contributor_role" {
  scope                = module.fdr_flows_sa.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.enabled_features.apim_migrated ? data.azurerm_api_management.apim_migrated[0].identity[0].principal_id : module.apim.principal_id

  depends_on = [
    module.fdr_flows_sa
  ]
}

# 2 - Change container Authentication method to Azure AD authentication
resource "null_resource" "change_auth_fdr_blob_container" {

  triggers = {
    apim_principal_id = var.enabled_features.apim_migrated ? data.azurerm_api_management.apim_migrated[0].identity[0].principal_id : module.apim.principal_id
  }

  provisioner "local-exec" {
    command = <<EOT
              az storage container set-permission \
                --name ${azurerm_storage_container.fdr_rend_flow.name} \
                --account-name ${module.fdr_flows_sa.name} \
                --account-key ${module.fdr_flows_sa.primary_access_key} \
                --auth-mode login
          EOT
  }

  depends_on = [
    azurerm_storage_container.fdr_rend_flow
  ]
}

# Alerting
resource "azurerm_monitor_scheduled_query_rules_alert" "fdr_parsing_0_flows_alert" {
  count = var.env_short == "p" ? 1 : 0

  name                = format("%s-fdr-parsing-0-flows-alertx", module.reporting_fdr_function.name)
  resource_group_name = azurerm_resource_group.reporting_fdr_rg.name
  location            = var.location

  action {
    action_group           = [azurerm_monitor_action_group.email.id, azurerm_monitor_action_group.slack.id]
    email_subject          = "[Fdr] FdR Flow Parsing Error"
    custom_webhook_payload = "{}"
  }
  data_source_id = azurerm_application_insights.application_insights.id
  description    = "FdR Flow Parsing Error"
  enabled        = true
  query = format(<<-QUERY
  traces
    | where cloud_RoleName == "%s"
    | where message  matches regex "with.*flows"
    | extend flussi = extract("END opt2ehub.*with(.*)flows", 1, message)
    | where toint(flussi) == 0
  QUERY
    , module.reporting_fdr_function.name
  )
  severity    = 1
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}
