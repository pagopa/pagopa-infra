### 🔮 Private DNS Zone for Cosmos Document DB
# https://docs.microsoft.com/it-it/azure/cosmos-db/how-to-configure-private-endpoints
data "azurerm_private_dns_zone" "privatelink_documents_azure_com" {
  name = "privatelink.documents.azure.com"
}
