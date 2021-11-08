/**
 * Checkout resource group
 **/
resource "azurerm_resource_group" "api_config_fe_rg" {
  count    = var.api_config_fe_enabled ? 1 : 0
  name     = format("%s-api-config-fe-rg", local.project)
  location = var.location

  tags = var.tags
}

/**
  * STORAGE
  */
module "api_config_fe_storage" {
  source                    = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v1.0.82"

  count                     = var.api_config_fe_enabled ? 1 : 0
  name                      = "api-config-fe"
  resource_group_name       = azurerm_resource_group.api_config_fe_rg[0].name
  location                  = var.location
  account_tier              = "Standard"
  account_replication_type  = "LRS" // local redundant storage

  index_document            = "index.html"
  error_404_document        = "not_found.html"

  tags                      = var.tags

}

/**
 * CDN
 */
module "api_config_fe_cdn" {
  source                        = "git::https://github.com/pagopa/azurerm.git//cdn?ref=v1.0.82"

  count                         = var.api_config_fe_enabled ? 1 : 0
  name                          = "api-config-fe"
  prefix                        = local.project
  resource_group_name           = azurerm_resource_group.api_config_fe_rg[0].name
  location                      = var.location
  hostname                      = format("%s.%s", var.dns_zone_api_config_fe, var.external_domain)
  https_rewrite_enabled         = true
  lock_enabled                  = var.lock_enable

  index_document                = "index.html"
  error_404_document            = "not_found.html"

  dns_zone_name                 = azurerm_dns_zone.api_config_fe_public[0].name
  dns_zone_resource_group_name  = azurerm_dns_zone.api_config_fe_public[0].resource_group_name

  keyvault_resource_group_name  = module.key_vault.resource_group_name
  keyvault_subscription_id      = data.azurerm_subscription.current.subscription_id
  keyvault_vault_name           = module.key_vault.name

  tags                          = var.tags
}
