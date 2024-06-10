data "external" "external" {
  program = [
    "bash", "terrasops.sh"
  ]
  query = {
    env = "${var.location_short}-${var.env}"
  }

}

locals {
  all_enc_secrets_value = can(data.external.external.result) ? flatten([
    for k, v in data.external.external.result : {
      valore = v
      chiave = k
    }
  ]) : []

  config_secret_data = jsondecode(file(var.input_file))
  all_config_secrets_value = flatten([
    for kc, vc in local.config_secret_data : {
      valore = vc
      chiave = kc
    }
  ])

  all_secrets_value = concat(local.all_config_secrets_value, local.all_enc_secrets_value)
}

## SOPS secrets

## Upload all encrypted secrets
resource "azurerm_key_vault_secret" "secret" {
  for_each = { for i, v in local.all_secrets_value : local.all_secrets_value[i].chiave => i }

  key_vault_id = data.azurerm_key_vault.kv.id
  name         = local.all_secrets_value[each.value].chiave
  value        = local.all_secrets_value[each.value].valore

  depends_on = [
    data.azurerm_key_vault.kv,
    azurerm_key_vault_key.generate_key_sops,
    data.external.external,
  ]
}


# ⚠️ The secrets from resources are set in printit-app to avoid circular dependency
