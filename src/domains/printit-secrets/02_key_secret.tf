
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
    data.external.external
  ]
}


## Manual secrets


resource "azurerm_key_vault_secret" "application_insights_connection_string" {
  name         = "app-insight-connection-string"
  value        = data.azurerm_application_insights.application_insights.connection_string
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "notices_mongo_connection_string" {
  name         = "notices-mongo-connection-string"
  value        = "AccountEndpoint=https://pagopa-${var.env_short}-${var.location_short}-${var.domain}-ds-cosmos-account.documents.azure.com:443/;AccountKey=${data.azurerm_cosmosdb_account.notices_cosmos_account.primary_key};"
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "notices_mongo_primary_key" {
  name         = "notices-mongo-primary-key"
  value        = data.azurerm_cosmosdb_account.notices_cosmos_account.primary_key
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "notices_storage_account_connection_string" {
  name         = "notices-storage-account-connection-string"
  value        = data.azurerm_storage_account.notices_storage_sa.primary_connection_string
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}
#
resource "azurerm_key_vault_secret" "notices_storage_account_pkey" {
  name         = "notices-storage-account-pkey"
  value        = data.azurerm_storage_account.notices_storage_sa.primary_access_key
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "templates_storage_account_connection_string" {
  name         = "templates-storage-account-connection-string"
  value        = data.azurerm_storage_account.templates_storage_sa.primary_connection_string
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "templates_storage_account_pkey" {
  name         = "templates-storage-account-pkey"
  value        = data.azurerm_storage_account.templates_storage_sa.primary_access_key
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "institutions_storage_account_connection_string" {
  name         = "institutions-storage-account-connection-string"
  value        = data.azurerm_storage_account.institutions_storage_sa.primary_connection_string
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "institutions_storage_account_pkey" {
  name         = "institutions-storage-account-pkey"
  value        = data.azurerm_storage_account.institutions_storage_sa.primary_access_key
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}


resource "azurerm_key_vault_secret" "ehub_notice_connection_string" {
  name         = format("ehub-%s-notice-connection-string", var.env_short)
  value        = data.azurerm_eventhub_authorization_rule.notices_evt_authorization_rule.primary_connection_string
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "ehub_notice_complete_connection_string" {
  name         = format("ehub-%s-notice-complete-connection-string", var.env_short)
  value        = data.azurerm_eventhub_authorization_rule.notices_complete_evt_authorization_rule.primary_connection_string
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "ehub_notice_error_connection_string" {
  name         = format("ehub-%s-notice-error-connection-string", var.env_short)
  value        = data.azurerm_eventhub_authorization_rule.notices_error_evt_authorization_rule.primary_connection_string
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}

resource "azurerm_api_management_subscription" "pdf_engine_node_subkey" {
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = data.azurerm_api_management_product.pdf_engine_product.id
  display_name        = "PDF Engine JS for Java"
}

resource "azurerm_key_vault_secret" "pdf_engine_node_subkey_secret" {
  name         = "pdf-engine-node-subkey"
  value        = azurerm_api_management_subscription.pdf_engine_node_subkey.primary_key
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}
