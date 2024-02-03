data "azurerm_key_vault" "kv_domain" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = "${local.product}-${var.domain}-sec-rg"
}

module "domain_key_vault_secrets_query" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query?ref=v7.50.0"

  key_vault_name = data.azurerm_key_vault.kv_domain.name
  resource_group = data.azurerm_key_vault.kv_domain.resource_group_name

  secrets = [
    "alert-error-notification-email"
  ]
}
