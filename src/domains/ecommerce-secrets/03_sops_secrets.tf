data "external" "terrasops" {
  program = [
    "bash", "terrasops.sh"
  ]
  query = {
    env = var.env
  }

}

locals {
  all_enc_secrets_entries = can(data.external.terrasops.result) ? flatten([
    for k, v in data.external.terrasops.result : {
      value = v
      key   = k
    }
  ]) : []

  config_secret_data = jsondecode(file("./secret/${var.env}/configs.json"))
  all_config_secrets_entries = flatten([
    for kc, vc in local.config_secret_data : {
      value = vc
      key   = kc
    }
  ])

  all_secrets_entries = concat(local.all_config_secrets_entries, local.all_enc_secrets_entries)
}

## SOPS secrets

## Upload all encrypted secrets
resource "azurerm_key_vault_secret" "secret" {
  for_each = { for i, v in local.all_secrets_entries : local.all_secrets_entries[i].key => i }

  key_vault_id = data.azurerm_key_vault.ecommerce_kv.id
  name         = local.all_secrets_entries[each.value].key
  value        = local.all_secrets_entries[each.value].value

  depends_on = [
    azurerm_key_vault_key.sops_key,
    data.external.terrasops,
  ]
}
