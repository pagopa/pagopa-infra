/**
 * nodo-dei-pagamenti resource group
 **/
resource "azurerm_resource_group" "nodo_pagamenti_test_rg" {
  count    = var.nodo_pagamenti_test_enabled ? 1 : 0
  name     = format("%s-nodo-pagamenti-test-rg", local.project)
  location = var.location

  tags = var.tags
}

/**
 * CDN
 */
module "nodo_pagamenti_test_cdn" {
  source = "git::https://github.com/pagopa/azurerm.git//cdn?ref=v2.0.18"

  count               = var.nodo_pagamenti_test_enabled ? 1 : 0
  name                = "nodo-pagamenti-test"
  prefix              = local.project
  resource_group_name = azurerm_resource_group.nodo_pagamenti_test_rg[0].name
  location            = var.location

  keyvault_resource_group_name = module.key_vault.resource_group_name
  keyvault_subscription_id     = data.azurerm_subscription.current.subscription_id
  keyvault_vault_name          = module.key_vault.name

  querystring_caching_behaviour = "BypassCaching"

  tags = var.tags
}
