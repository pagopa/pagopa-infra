## Fdr - Flussi di rendicontazione

## Storage Account
module "fdr_flows_sa" {
  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v2.0.13"

  name                       = replace(format("%s-fdr-flows-sa", local.project), "-", "")
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  account_replication_type   = "LRS"
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


# https://medium.com/marcus-tee-anytime/secure-azure-blob-storage-with-azure-api-management-managed-identities-b0b82b53533c
# Change container Authentication method - to Azure AD authentication, too
resource "azurerm_role_assignment" "data-contributor-role" {
  scope                = module.fdr_flows_sa.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = module.apim.principal_id
}
