module "canoneunico_sa" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v6.15.2"

  name                            = replace("${local.project}-canoneunico-sa", "-", "")
  account_kind                    = var.storage_account_info.account_kind
  account_tier                    = var.storage_account_info.account_tier
  account_replication_type        = var.storage_account_info.account_replication_type
  access_tier                     = var.storage_account_info.access_tier
  blob_versioning_enabled         = var.canoneunico_enable_versioning
  resource_group_name             = azurerm_resource_group.canoneunico_rg.name
  location                        = var.location
  advanced_threat_protection      = var.canoneunico_advanced_threat_protection
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = var.public_network_access_enabled

  blob_delete_retention_days = var.canoneunico_delete_retention_days

  tags = var.tags
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

## blob container (Input CSV Blob)
resource "azurerm_storage_container" "in_csv_blob_container" {
  name                  = "${module.canoneunico_sa.name}incsvcontainer"
  storage_account_name  = module.canoneunico_sa.name
  container_access_type = "private"
}

## blob container (Output CSV Blob)
resource "azurerm_storage_container" "out_csv_blob_container" {
  name                  = "${module.canoneunico_sa.name}outcsvcontainer"
  storage_account_name  = module.canoneunico_sa.name
  container_access_type = "private"
}

## blob container (Error CSV Blob)
resource "azurerm_storage_container" "err_csv_blob_container" {
  name                  = "${module.canoneunico_sa.name}errcsvcontainer"
  storage_account_name  = module.canoneunico_sa.name
  container_access_type = "private"
}