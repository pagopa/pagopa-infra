module "canoneunico_sa" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v7.18.0"

  name                = replace("${local.project}-canoneunico-sa", "-", "")
  resource_group_name = azurerm_resource_group.canoneunico_rg.name
  location            = var.location

  public_network_access_enabled = var.public_network_access_enabled
  is_sftp_enabled               = true
  account_kind                  = var.storage_account_info.account_kind
  account_tier                  = var.storage_account_info.account_tier
  account_replication_type      = var.storage_account_info.account_replication_type
  access_tier                   = var.storage_account_info.access_tier

  is_hns_enabled             = true
  advanced_threat_protection = true
  # should be false when sftp is enabled, ref:https://learn.microsoft.com/en-us/azure/storage/blobs/secure-file-transfer-protocol-known-issues
  blob_versioning_enabled       = false
  blob_last_access_time_enabled = true


  tags = module.tag_config.tags
}


## table#1 storage (EC Config)
resource "azurerm_storage_table" "cu_ecconfig_table" {
  name                 = "${module.canoneunico_sa.name}ecconfigtable"
  storage_account_name = module.canoneunico_sa.name
}

## table#2 storage (Debt Position)
resource "azurerm_storage_table" "cu_debtposition_table" {
  name                 = "${module.canoneunico_sa.name}debtpostable"
  storage_account_name = module.canoneunico_sa.name
}

## table#3 storage (IUVs Table)
resource "azurerm_storage_table" "cu_iuvs_table" {
  name                 = "${module.canoneunico_sa.name}iuvstable"
  storage_account_name = module.canoneunico_sa.name
}

## queue#1 storage (Debt Position)
resource "azurerm_storage_queue" "cu_debtposition_queue" {
  name                 = "${module.canoneunico_sa.name}debtposqueue"
  storage_account_name = module.canoneunico_sa.name
}

## queue#2 blob event (EventGrid subscriber endpoint)
resource "azurerm_storage_queue" "cu_blob_event_queue" {
  name                 = "${module.canoneunico_sa.name}blobeventqueue"
  storage_account_name = module.canoneunico_sa.name
}


# Older container used by pagoPA ref
# from CUP'24 swithed to "CUP corporate automation itfself" see below 👇

## blob container (Input CSV Blob)
resource "azurerm_storage_container" "in_csv_blob_container" {
  count = var.env_short == "p" ? 1 : 0 // not del in prod only for backup

  name                  = "${module.canoneunico_sa.name}incsvcontainer"
  storage_account_name  = module.canoneunico_sa.name
  container_access_type = "private"
}

## blob container (Output CSV Blob)
resource "azurerm_storage_container" "out_csv_blob_container" {
  count = var.env_short == "p" ? 1 : 0 // not del in prod only for backup

  name                  = "${module.canoneunico_sa.name}outcsvcontainer"
  storage_account_name  = module.canoneunico_sa.name
  container_access_type = "private"
}

## blob container (Error CSV Blob)
resource "azurerm_storage_container" "err_csv_blob_container" {
  count = var.env_short == "p" ? 1 : 0 // not del in prod only for backup

  name                  = "${module.canoneunico_sa.name}errcsvcontainer"
  storage_account_name  = module.canoneunico_sa.name
  container_access_type = "private"
}


# ##################################### #
# CUP corporate automation itfself
# ##################################### #

# https://learn.microsoft.com/en-us/azure/templates/microsoft.storage/storageaccounts/localusers?pivots=deployment-language-terraform
# list of local user
locals {
  cup_localuser_corporate = var.corporate_cup_users
}


# 1. creare corporate container & directory
resource "azurerm_storage_container" "corporate_containers" {
  for_each = { for c in local.cup_localuser_corporate : c.username => c }

  name                  = "${each.value.username}container"
  storage_account_name  = module.canoneunico_sa.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "containers_err_directory" {
  for_each = { for c in local.cup_localuser_corporate : c.username => c }

  # name                   = "pagopa${var.env_short}canoneunicosaerrcsvcontainer/.info"
  name                   = "error/.info"
  storage_account_name   = module.canoneunico_sa.name
  storage_container_name = "${each.value.username}container"
  type                   = "Block"
  source                 = "./info.txt" # placeholder file
}

resource "azurerm_storage_blob" "containers_in_directory" {
  for_each = { for c in local.cup_localuser_corporate : c.username => c }

  # name                   = "pagopa${var.env_short}canoneunicosaincsvcontainer/.info"
  name                   = "input/.info"
  storage_account_name   = module.canoneunico_sa.name
  storage_container_name = "${each.value.username}container"
  type                   = "Block"
  source                 = "./info.txt" # placeholder file
}

resource "azurerm_storage_blob" "containers_out_directory" {
  for_each = { for c in local.cup_localuser_corporate : c.username => c }

  # name                   = "pagopa${var.env_short}canoneunicosaoutcsvcontainer/.info"
  name                   = "output/.info"
  storage_account_name   = module.canoneunico_sa.name
  storage_container_name = "${each.value.username}container"
  type                   = "Block"
  source                 = "info.txt" # placeholder file
}

# 2. Configure the Azure Storage Account Container User who will get access
resource "azapi_resource" "sftp_localuser_on_container" {
  for_each = { for c in local.cup_localuser_corporate : c.username => c }

  type = "Microsoft.Storage/storageAccounts/localUsers@2023-01-01"

  parent_id = module.canoneunico_sa.id
  name      = each.value.username // "username"

  body = jsonencode({
    properties = {
      hasSshPassword = true,
      homeDirectory  = "${each.value.username}container"
      hasSharedKey   = true,
      hasSshKey      = false,
      permissionScopes = [{
        permissions  = "cwlr",
        service      = "blob",
        resourceName = "${each.value.username}container" // "containername"
      }]
    }
  })
  # depends_on = [
  #   azurerm_storage_account.erpsftpserver,
  #   azapi_update_resource.enablesftp
  # ]
}

# 3. Configure/generate the Azure Storage Account Container password
resource "azapi_resource_action" "generate_sftp_user_password" {
  for_each = { for c in local.cup_localuser_corporate : c.username => c }

  type        = "Microsoft.Storage/storageAccounts/localUsers@2022-05-01"
  resource_id = azapi_resource.sftp_localuser_on_container[each.key].id
  action      = "regeneratePassword"
  body = jsonencode({
    username = azapi_resource.sftp_localuser_on_container[each.key].name
  })

  response_export_values = ["sshPassword"]
}
