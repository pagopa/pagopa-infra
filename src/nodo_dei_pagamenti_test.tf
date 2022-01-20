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
  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v2.1.13"
  count  = var.nodo_pagamenti_test_enabled ? 1 : 0

  name                     = replace(format("%s-nodotestsa", local.project), "-", "")
  account_kind             = "BlobStorage"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  access_tier              = "Hot"
  enable_versioning        = false
  resource_group_name      = azurerm_resource_group.nodo_pagamenti_test_rg[0].name
  location                 = var.location
  allow_blob_public_access = true

  index_document     = "index.html"
  error_404_document = "not_found.html"

  tags = var.tags
}
