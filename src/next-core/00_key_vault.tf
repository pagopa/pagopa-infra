 data "azurerm_key_vault" "kv_core" {
   name                = "${local.product}-kv"
   resource_group_name = "${local.product}-sec-rg"
 }

 data "azurerm_key_vault" "kv_domain" {
  name                = "${local.product}-kv"
  resource_group_name = "${local.product}-sec-rg"
}

module "domain_key_vault_secrets_query" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query?ref=v7.50.0"

  key_vault_name = data.azurerm_key_vault.kv_domain.name
  resource_group = data.azurerm_key_vault.kv_domain.resource_group_name

  secrets = [
    "alert-error-notification-email"
  ]
}

resource "azurerm_key_vault_secret" "delete_me" {
  name         = "secret-sauce"
  value        = "szechuan"
  key_vault_id = data.azurerm_key_vault.kv_domain.id
}


data "azurerm_key_vault_secret" "apim_publisher_email" {
  name         = "apim-publisher-email"
  key_vault_id = data.azurerm_key_vault.kv_core.id
}
