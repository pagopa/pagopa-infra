#Shared security resource group
data "azurerm_resource_group" "sec_rg" {
  name = "${local.product}-${var.domain}-sec-rg"
}
#pay-wallet security resource group
data "azurerm_resource_group" "pay_wallet_sec_rg" {
  name = "${local.product}-${var.pay_wallet_domain}-sec-rg"
}
#eCommerce security resource group
data "azurerm_resource_group" "ecommerce_sec_rg" {
  name = "${local.product}-${var.ecommerce_domain}-sec-rg"
}

# Shared KV
data "azurerm_key_vault" "shared_kv" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = data.azurerm_resource_group.sec_rg.name
}

# pay-wallet KV
data "azurerm_key_vault" "pay_wallet_kv" {
  name                = "${local.product}-${var.pay_wallet_domain}-kv"
  resource_group_name = data.azurerm_resource_group.pay_wallet_sec_rg.name
}

# eCommerce KV
data "azurerm_key_vault" "ecommerce_kv" {
  name                = "${local.product}-${var.ecommerce_domain}-kv"
  resource_group_name = data.azurerm_resource_group.ecommerce_sec_rg.name
}

resource "azurerm_key_vault_key" "generated" {
  name         = "${local.product}-${var.domain}-sops-key"
  key_vault_id = data.azurerm_key_vault.shared_kv.id
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

  personal_data_vault_secret_name = "personal-data-vault-api-key-wallet-session"

  //search for PDV api key that will be pushed to both Wallet and eCommerce KV on each update in order to synchronize api key updates
  personal_data_vault_secret_value = tolist([for each in local.all_secrets_value : each.valore if each.chiave == local.personal_data_vault_secret_name])[0]
}


## Upload all encrypted secrets
resource "azurerm_key_vault_secret" "secret" {
  for_each = { for i, v in local.all_secrets_value : local.all_secrets_value[i].chiave => i }

  key_vault_id = data.azurerm_key_vault.shared_kv.id
  name         = local.all_secrets_value[each.value].chiave
  value        = local.all_secrets_value[each.value].valore

  depends_on = [
    azurerm_key_vault_key.generated,
    data.external.external
  ]
}

## Synchronize PDV api key secret on pay wallet KV
resource "azurerm_key_vault_secret" "pay_wallet_pdv_secret" {
  key_vault_id = data.azurerm_key_vault.pay_wallet_kv.id
  name         = local.personal_data_vault_secret_name
  value        = local.personal_data_vault_secret_value

  depends_on = [
    azurerm_key_vault_key.generated,
    data.external.external
  ]
}

## Synchronize PDV api key on eCommerce KV
resource "azurerm_key_vault_secret" "ecommerce_pdv_secret" {
  key_vault_id = data.azurerm_key_vault.ecommerce_kv.id
  name         = local.personal_data_vault_secret_name
  value        = local.personal_data_vault_secret_value

  depends_on = [
    azurerm_key_vault_key.generated,
    data.external.external
  ]
}

