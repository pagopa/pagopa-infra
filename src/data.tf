resource "azurerm_resource_group" "data" {
  name     = format("%s-data-rg", local.project)
  location = var.location

  tags = var.tags
}

## Storage Account
resource "azurerm_storage_account" "fdr_flows" {
  name                      = replace(format("%s-fdr-flows-sa", local.project), "-", "")
  resource_group_name       = azurerm_resource_group.data.name
  location                  = var.location
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"
  account_tier              = "Standard"

  account_replication_type = "LRS"

  tags = var.tags
}

## blob container flows
resource "azurerm_storage_container" "fdr_rend_flow" {
  name                  = format("%xmlrendflow", azurerm_storage_account.fdr_flows.name)
  storage_account_name  = azurerm_storage_account.fdr_flows.name
  container_access_type = "private"
}
