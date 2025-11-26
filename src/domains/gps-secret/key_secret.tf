#gps security resource group
data "azurerm_resource_group" "sec_rg" {
  name = "${local.product}-${var.domain}-sec-rg"
}

# gps KV
data "azurerm_key_vault" "gps_kv" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = data.azurerm_resource_group.sec_rg.name
}

resource "azurerm_key_vault_key" "generated" {
  name         = "${local.product}-${var.domain}-sops-key"
  key_vault_id = data.azurerm_key_vault.gps_kv.id
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

  config_secret_data = jsondecode(file(var.input_file))
  all_config_secrets_value = flatten([
    for kc, vc in local.config_secret_data : {
      valore = vc
      chiave = kc
    }
  ])

  all_secrets_value = concat(local.all_config_secrets_value, local.all_enc_secrets_value)

}


## Upload all encrypted secrets
resource "azurerm_key_vault_secret" "secret" {
  for_each = { for i, v in local.all_secrets_value : local.all_secrets_value[i].chiave => i }

  key_vault_id = data.azurerm_key_vault.gps_kv.id
  name         = local.all_secrets_value[each.value].chiave
  value        = local.all_secrets_value[each.value].valore

  depends_on = [
    azurerm_key_vault_key.generated,
    data.external.external
  ]
}
