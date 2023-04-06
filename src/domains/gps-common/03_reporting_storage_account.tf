module "flows" {
  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v2.0.28"

  name                       = replace(format("%s-flow-sa", local.project), "-", "")
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  account_replication_type   = "LRS"
  access_tier                = "Hot"
  versioning_name            = "versioning"
  enable_versioning          = var.gpd_enable_versioning
  resource_group_name        = azurerm_resource_group.gps_rg.name
  location                   = var.location
  advanced_threat_protection = var.gpd_reporting_advanced_threat_protection
  allow_blob_public_access   = false

  blob_properties_delete_retention_policy_days = var.gpd_reporting_delete_retention_days

  tags = var.tags
}

## table#1 storage
resource "azurerm_storage_table" "reporting_organizations_table" {
  name                 = format("%sorgstable", module.flows.name)
  storage_account_name = module.flows.name
}

## table#2 storage
resource "azurerm_storage_table" "reporting_flows_table" {
  name                 = format("%stable", module.flows.name)
  storage_account_name = module.flows.name
}

## queue#1 storage flows
resource "azurerm_storage_queue" "reporting_flows_queue" {
  name                 = format("%squeueflows", module.flows.name)
  storage_account_name = module.flows.name
}

## queue#2 storage organization
resource "azurerm_storage_queue" "reporting_organizations_queue" {
  name                 = format("%squeueorg", module.flows.name)
  storage_account_name = module.flows.name
}

## queue#3 storage flows
resource "azurerm_storage_queue" "reporting_options_queue" {
  name                 = format("%squeueopt", module.flows.name)
  storage_account_name = module.flows.name
}

## blob container flows
resource "azurerm_storage_container" "reporting_flows_container" {
  name                  = format("%sflowscontainer", module.flows.name)
  storage_account_name  = module.flows.name
  container_access_type = "private"
}
