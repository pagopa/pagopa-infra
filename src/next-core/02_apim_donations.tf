module "logos_donation_flows_sa" {
  source = "./.terraform/modules/__v4__/storage_account"

  name                            = replace("${local.product}-logos-donation-sa", "-", "")
  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  account_replication_type        = var.logos_donations_storage_account_replication_type
  access_tier                     = "Hot"
  blob_versioning_enabled         = var.enable_logos_backup
  resource_group_name             = azurerm_resource_group.data.name
  location                        = var.location
  advanced_threat_protection      = false
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true


  blob_change_feed_enabled             = var.enable_logos_backup
  blob_change_feed_retention_in_days   = var.enable_logos_backup ? var.logos_backup_retention + 1 : null
  blob_container_delete_retention_days = var.logos_backup_retention
  blob_storage_policy = {
    enable_immutability_policy = false
    blob_restore_policy_days   = var.logos_backup_retention
  }
  blob_delete_retention_days = var.logos_backup_retention + 1


  tags = module.tag_config.tags
}



## blob container logo 7
resource "azurerm_storage_container" "donation_logo7" {
  name                  = "${module.logos_donation_flows_sa.name}logo7"
  storage_account_name  = module.logos_donation_flows_sa.name
  container_access_type = "private"
}
resource "azurerm_storage_blob" "donation_logo7" {
  name                   = "logo7"
  storage_account_name   = module.logos_donation_flows_sa.name
  storage_container_name = azurerm_storage_container.donation_logo7.name
  type                   = "Block"
  source                 = "../core/api/donations/v1/logos/logo7"
}

## blob container logo 8
resource "azurerm_storage_container" "donation_logo8" {
  name                  = "${module.logos_donation_flows_sa.name}logo8"
  storage_account_name  = module.logos_donation_flows_sa.name
  container_access_type = "private"
}
resource "azurerm_storage_blob" "donation_logo8" {
  name                   = "logo8"
  storage_account_name   = module.logos_donation_flows_sa.name
  storage_container_name = azurerm_storage_container.donation_logo8.name
  type                   = "Block"
  source                 = "../core/api/donations/v1/logos/logo8"
}

## blob container logo 9
resource "azurerm_storage_container" "donation_logo9" {
  name                  = "${module.logos_donation_flows_sa.name}logo9"
  storage_account_name  = module.logos_donation_flows_sa.name
  container_access_type = "private"
}
resource "azurerm_storage_blob" "donation_logo9" {
  name                   = "logo9"
  storage_account_name   = module.logos_donation_flows_sa.name
  storage_container_name = azurerm_storage_container.donation_logo9.name
  type                   = "Block"
  source                 = "../core/api/donations/v1/logos/logo9"
}

## blob container logo 10
resource "azurerm_storage_container" "donation_logo10" {
  name                  = "${module.logos_donation_flows_sa.name}logo10"
  storage_account_name  = module.logos_donation_flows_sa.name
  container_access_type = "private"
}
resource "azurerm_storage_blob" "donation_logo10" {
  name                   = "logo10"
  storage_account_name   = module.logos_donation_flows_sa.name
  storage_container_name = azurerm_storage_container.donation_logo10.name
  type                   = "Block"
  source                 = "../core/api/donations/v1/logos/logo10"
}


# https://medium.com/marcus-tee-anytime/secure-azure-blob-storage-with-azure-api-management-managed-identities-b0b82b53533c

# 1 - add Blob Data Contributor to apim for Fdr blob storage
resource "azurerm_role_assignment" "data_contributor_role_donations" {
  scope                = module.logos_donation_flows_sa.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = module.apim[0].principal_id

  depends_on = [
    module.logos_donation_flows_sa
  ]
}
#
## 2 - Change container Authentication method to Azure AD authentication
resource "null_resource" "change_auth_donations_blob_container_logo7" {

  triggers = {
    apim_principal_id = module.apim[0].principal_id
  }

  provisioner "local-exec" {
    command = <<EOT
              az storage container set-permission \
                --name ${azurerm_storage_container.donation_logo7.name} \
                --account-name ${module.logos_donation_flows_sa.name} \
                --account-key ${module.logos_donation_flows_sa.primary_access_key} \
                --auth-mode login
          EOT
  }

  depends_on = [
    azurerm_storage_container.donation_logo7
  ]
}

resource "null_resource" "change_auth_donations_blob_container_logo8" {

  triggers = {
    apim_principal_id = module.apim[0].principal_id
  }

  provisioner "local-exec" {
    command = <<EOT
              az storage container set-permission \
                --name ${azurerm_storage_container.donation_logo8.name} \
                --account-name ${module.logos_donation_flows_sa.name} \
                --account-key ${module.logos_donation_flows_sa.primary_access_key} \
                --auth-mode login
          EOT
  }

  depends_on = [
    azurerm_storage_container.donation_logo8
  ]
}

resource "null_resource" "change_auth_donations_blob_container_logo9" {

  triggers = {
    apim_principal_id = module.apim[0].principal_id
  }

  provisioner "local-exec" {
    command = <<EOT
              az storage container set-permission \
                --name ${azurerm_storage_container.donation_logo9.name} \
                --account-name ${module.logos_donation_flows_sa.name} \
                --account-key ${module.logos_donation_flows_sa.primary_access_key} \
                --auth-mode login
          EOT
  }

  depends_on = [
    azurerm_storage_container.donation_logo9
  ]
}

resource "null_resource" "change_auth_donations_blob_container_logo10" {

  triggers = {
    apim_principal_id = module.apim[0].principal_id
  }

  provisioner "local-exec" {
    command = <<EOT
              az storage container set-permission \
                --name ${azurerm_storage_container.donation_logo10.name} \
                --account-name ${module.logos_donation_flows_sa.name} \
                --account-key ${module.logos_donation_flows_sa.primary_access_key} \
                --auth-mode login
          EOT
  }

  depends_on = [
    azurerm_storage_container.donation_logo10
  ]
}
