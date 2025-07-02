module "secret_core" {
  source = "./.terraform/modules/__v4__/key_vault_secrets_query"

  resource_group = local.key_vault_rg_name
  key_vault_name = local.key_vault_name

  secrets = [
    "tf-audit-slack-webhook-url",
    "tf-audit-storage-access-key"
  ]
}
