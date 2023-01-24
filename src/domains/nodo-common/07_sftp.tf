# To fully configure the storage account, there are some manual steps. See
# https://pagopa.atlassian.net/wiki/spaces/DEVOPS/pages/511738518/Enable+SFTP+with+Azure+Storage+Account

resource "azurerm_resource_group" "sftp" {
  name     = "${local.project}-sftp-rg"
  location = var.location
}

module "sftp" {
  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v4.3.0"

  name                = replace("${local.project}-sftp", "-", "")
  resource_group_name = azurerm_resource_group.sftp.name
  location            = azurerm_resource_group.sftp.location

  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = var.sftp_account_replication_type
  access_tier              = "Hot"
  is_hns_enabled           = true

  network_rules = {
    default_action             = var.sftp_disable_network_rules ? "Allow" : "Deny"
    bypass                     = ["AzureServices"]
    ip_rules                   = var.sftp_ip_rules
    virtual_network_subnet_ids = []
  }

  tags = var.tags
}

# resource "azurerm_private_endpoint" "sftp_blob" {
#   count = var.sftp_enable_private_endpoint ? 1 : 0

#   name                = "${module.sftp.name}-blob-endpoint"
#   resource_group_name = azurerm_resource_group.sftp.name
#   location            = azurerm_resource_group.sftp.location
#   subnet_id           = module.storage_account_snet.id

#   private_service_connection {
#     name                           = "${module.sftp.name}-blob-endpoint"
#     private_connection_resource_id = module.sftp.id
#     is_manual_connection           = false
#     subresource_names              = ["blob"]
#   }

#   private_dns_zone_group {
#     name                 = "private-dns-zone-group"
#     private_dns_zone_ids = [azurerm_private_dns_zone.storage_account.id]
#   }

#   tags = var.tags
# }

resource "azurerm_storage_container" "sogei" {
  name                  = "sogei"
  storage_account_name  = module.sftp.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "sogei_dirs" {
  for_each               = toset(["in", "out", "error", "ack"])
  name                   = format("%s/.test", each.key)
  storage_account_name   = module.sftp.name
  storage_container_name = azurerm_storage_container.sogei.name
  type                   = "Block"
}
