module "secret_core" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query?ref=v8.54.0"

  resource_group = local.key_vault_rg_name
  key_vault_name = local.key_vault_name

  secrets = [
    "synthetic-monitoring-nodo-subscription-key"
  ]
}
