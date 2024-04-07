/**
 * nodo-dei-pagamenti resource group
 **/
resource "azurerm_resource_group" "nodo_pagamenti_test_rg" {
  count    = var.nodo_pagamenti_test_enabled ? 1 : 0
  name     = format("%s-nodo-test-rg", local.project)
  location = var.location

  tags = var.tags
}

/**
* STORAGE
*/
module "nodo_test_storage" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v7.76.0"
  count  = var.nodo_pagamenti_test_enabled ? 1 : 0

  name                             = replace(format("%s-nodotestsa", local.project), "-", "")
  account_kind                     = "StorageV2"
  account_tier                     = "Standard"
  account_replication_type         = "LRS"
  access_tier                      = "Hot"
  blob_versioning_enabled          = false
  resource_group_name              = azurerm_resource_group.nodo_pagamenti_test_rg[0].name
  location                         = var.location
  allow_nested_items_to_be_public  = true
  public_network_access_enabled    = true
  cross_tenant_replication_enabled = false

  index_document     = "index.html"
  error_404_document = "not_found.html"

  tags = var.tags
}

//resource "azurerm_storage_container" "nodo_test_storage_container" {
//  name                  = "$web"
//  storage_account_name  = module.nodo_test_storage[0].name
//  container_access_type = "blob"
//}
