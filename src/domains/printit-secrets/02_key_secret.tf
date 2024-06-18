
resource "azurerm_key_vault_key" "generated" {
  name         = "${local.product}-${var.domain}-sops-key"
  key_vault_id = module.key_vault.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
  ]

  depends_on = [
    azurerm_key_vault_access_policy.adgroup_developers_policy,
    azurerm_key_vault_access_policy.ad_group_policy,
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

  key_vault_id = module.key_vault.id
  name         = local.all_secrets_value[each.value].chiave
  value        = local.all_secrets_value[each.value].valore

  depends_on = [
    module.key_vault,
    azurerm_key_vault_key.generated,
    data.external.external,
    azurerm_key_vault_access_policy.adgroup_developers_policy,
    azurerm_key_vault_access_policy.ad_group_policy,
  ]
}

resource "random_string" "random_aes_key" {
  length  = 16
  special = true
  upper   = true
}
resource "azurerm_key_vault_secret" "aes_key_secret" {
  key_vault_id = module.key_vault.id
  name         = "aes-key"
  value        = random_string.random_aes_key.result

  depends_on = [
    module.key_vault,
    azurerm_key_vault_access_policy.adgroup_developers_policy,
    azurerm_key_vault_access_policy.ad_group_policy,
  ]
}

resource "random_string" "random_aes_salt" {
  length  = 16
  special = true
  upper   = true
}
resource "azurerm_key_vault_secret" "aes_salt_secret" {
  key_vault_id = module.key_vault.id
  name         = "aes-salt"
  value        = random_string.random_aes_salt.result

  depends_on = [
    module.key_vault,
    azurerm_key_vault_access_policy.adgroup_developers_policy,
    azurerm_key_vault_access_policy.ad_group_policy,
  ]
}

# ⚠️ The secrets from resources are set in printit-app to avoid circular dependency
