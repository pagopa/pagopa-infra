data "azurerm_key_vault" "keyvault" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = "${local.product}-${var.domain}-sec-rg"
}

resource "azurerm_key_vault_key" "generated" {
  name         = "${local.product}-${var.domain}-sops-key"
  key_vault_id = data.azurerm_key_vault.keyvault.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
  ]
}

locals {
  secret_data = jsondecode(file(var.input_file))
  all_secrets_value = flatten([
    for secrets in local.secret_data.secrets : {
      valore = secrets.value
      chiave = secrets.key
    }
  ])
}

#Print secrets to screen
output "secrets" {
  value = local.all_secrets_value
}

## Upload all secrets
resource "azurerm_key_vault_secret" "secret" {
  for_each = { for i, v in local.all_secrets_value : local.all_secrets_value[i].chiave => i }

  key_vault_id = data.azurerm_key_vault.keyvault.id
  name         = local.all_secrets_value[each.value].chiave
  value        = local.all_secrets_value[each.value].valore
}
