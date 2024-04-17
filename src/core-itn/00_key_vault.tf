data "azurerm_key_vault" "kv_core" {
  name                = "${local.product}-kv"
  resource_group_name = "${local.product}-sec-rg"
}


module "domain_key_vault_secrets_query" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query?ref=v7.77.0"

  key_vault_name = data.azurerm_key_vault.kv_core.name
  resource_group = data.azurerm_key_vault.kv_core.resource_group_name

  secrets = [
    "alert-error-notification-email"
  ]
}
