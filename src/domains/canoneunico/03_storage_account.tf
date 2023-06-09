module "cu_sa" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v6.15.2"

  name                            = replace(format("%s-canoneunico-sa", local.project), "-", "")
  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  access_tier                     = "Hot"
  blob_versioning_enabled         = var.canoneunico_enable_versioning
  resource_group_name             = azurerm_resource_group.canoneunico_rg.name
  location                        = var.location
  advanced_threat_protection      = var.canoneunico_advanced_threat_protection
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = false

  blob_delete_retention_days = var.canoneunico_delete_retention_days

  tags = var.tags
}


## table#1 storage (EC Config)
resource "azurerm_storage_table" "cu_ecconfig_table" {
  name                 = format("%secconfigtable", module.cu_sa.name)
  storage_account_name = module.cu_sa.name
}

## table#2 storage (Debt Position)
resource "azurerm_storage_table" "cu_debtposition_table" {
  name                 = format("%sdebtpostable", module.cu_sa.name)
  storage_account_name = module.cu_sa.name
}

## table#3 storage (IUVs Table)
resource "azurerm_storage_table" "cu_iuvs_table" {
  name                 = format("%siuvstable", module.cu_sa.name)
  storage_account_name = module.cu_sa.name
}

## queue#1 storage (Debt Position)
resource "azurerm_storage_queue" "cu_debtposition_queue" {
  name                 = format("%sdebtposqueue", module.cu_sa.name)
  storage_account_name = module.cu_sa.name
}

## blob container (Input CSV Blob)
resource "azurerm_storage_container" "in_csv_blob_container" {
  name                  = format("%sincsvcontainer", module.cu_sa.name)
  storage_account_name  = module.cu_sa.name
  container_access_type = "private"
}

## blob container (Output CSV Blob)
resource "azurerm_storage_container" "out_csv_blob_container" {
  name                  = format("%soutcsvcontainer", module.cu_sa.name)
  storage_account_name  = module.cu_sa.name
  container_access_type = "private"
}

## blob container (Error CSV Blob)
resource "azurerm_storage_container" "err_csv_blob_container" {
  name                  = format("%serrcsvcontainer", module.cu_sa.name)
  storage_account_name  = module.cu_sa.name
  container_access_type = "private"
}