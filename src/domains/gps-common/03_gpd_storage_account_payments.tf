## GPD receipt dead-letter blob container
resource "azurerm_storage_container" "gpd_receipt_dead_letter" {
  name                  = "gpd-receipt-dead-letter"
  storage_account_id    = module.gpd_sa_sftp.id
  container_access_type = "private"
}