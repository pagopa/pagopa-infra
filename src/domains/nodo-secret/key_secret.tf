
resource "azurerm_key_vault_key" "generated" {
  name         = "${local.product}-${var.domain}-sops-key"
  key_vault_id = module.key_vault.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
  ]
}

data "external" "external" {
  program = [
    "bash", "terrasops.sh"
  ]
  query = {
    env = "${var.location_short}-${var.env}"
  }
}

locals {
  all_enc_secrets_value = flatten([
    for k, v in data.external.external.result : {
      valore = v
      chiave = k
    }
  ])

  clean_secret_data = jsondecode(file(var.input_file))
  all_clean_secrets_value = flatten([
    for kc, vc in local.clean_secret_data : {
      valore = vc
      chiave = kc
    }
  ])
}


## Upload all encryted secrets
resource "azurerm_key_vault_secret" "secret" {
  for_each = { for i, v in local.all_enc_secrets_value : local.all_enc_secrets_value[i].chiave => i }

  key_vault_id = module.key_vault.id
  name         = local.all_enc_secrets_value[each.value].chiave
  value        = local.all_enc_secrets_value[each.value].valore
}

## Upload all clean secrets
resource "azurerm_key_vault_secret" "clansecret" {
  for_each = { for i, v in local.all_clean_secrets_value : local.all_clean_secrets_value[i].chiave => i }

  key_vault_id = module.key_vault.id
  name         = local.all_clean_secrets_value[each.value].chiave
  value        = local.all_clean_secrets_value[each.value].valore
}