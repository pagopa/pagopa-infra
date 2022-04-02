## Fdr - Flussi di rendicontazione

## Storage Account
module "fdr_flows_sa" {
  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v2.9.0"

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

# 1 - add Blob Data Contributor to apim for Fdr blob storage
resource "azurerm_role_assignment" "data_contributor_role" {
  scope                = module.fdr_flows_sa.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = module.apim.principal_id

  depends_on = [
    module.fdr_flows_sa
  ]
}

# 2 - Change container Authentication method to Azure AD authentication
resource "null_resource" "change_auth_fdr_blob_container" {

  triggers = {
    apim_principal_id = module.apim.principal_id
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
