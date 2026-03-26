# To fully configure the storage account, there are some manual steps. See
# https://pagopa.atlassian.net/wiki/spaces/DEVOPS/pages/511738518/Enable+SFTP+with+Azure+Storage+Account

resource "azurerm_resource_group" "sftp" {
  name     = "${local.project}-sftp-rg"
  location = var.location
}

module "sftp" {
  source = "./.terraform/modules/__v4__/storage_account"
  #source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=add-SFTP-to-sa"

  name                = replace("${local.project}-sftp", "-", "")
  resource_group_name = azurerm_resource_group.sftp.name
  location            = azurerm_resource_group.sftp.location

  public_network_access_enabled = true
  is_sftp_enabled               = true
  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  account_replication_type      = var.sftp_account_replication_type
  access_tier                   = "Hot"
  is_hns_enabled                = true

  blob_versioning_enabled = false

  #  blob_delete_retention_days = var.sftp_sa_delete_retention_days
  #  blob_change_feed_enabled = var.enable_sftp_backup
  #  blob_change_feed_retention_in_days = var.enable_sftp_backup ? var.sftp_sa_backup_retention_days : null
  #  blob_container_delete_retention_days =  var.sftp_sa_backup_retention_days
  #  blob_storage_policy ={
  #    enable_immutability_policy = false
  #    blob_restore_policy_days = var.sftp_sa_backup_retention_days
  #  }

  network_rules = {
    default_action             = var.sftp_disable_network_rules ? "Allow" : "Deny"
    bypass                     = ["AzureServices"]
    ip_rules                   = var.sftp_ip_rules
    virtual_network_subnet_ids = []
  }

  tags = module.tag_config.tags
}

resource "azurerm_private_endpoint" "sftp_blob" {
  count = var.sftp_enable_private_endpoint ? 1 : 0

  name                = "${module.sftp.name}-blob-endpoint"
  resource_group_name = azurerm_resource_group.sftp.name
  location            = azurerm_resource_group.sftp.location
  subnet_id           = module.storage_account_snet.id

  private_service_connection {
    name                           = "${module.sftp.name}-blob-endpoint"
    private_connection_resource_id = module.sftp.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.storage.id]
  }

  tags = module.tag_config.tags
}

resource "azurerm_storage_container" "sogei" {
  name                  = "sogei"
  storage_account_name  = module.sftp.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "sogei_dirs" {
  for_each               = toset(["Inbox", "output"])
  name                   = "${each.key}/.test"
  storage_account_name   = module.sftp.name
  storage_container_name = azurerm_storage_container.sogei.name
  type                   = "Block"
}
