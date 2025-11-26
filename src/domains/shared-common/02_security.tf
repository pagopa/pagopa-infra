data "azurerm_redis_cache" "redis_cache" {
  name                = var.redis_ha_enabled ? format("%s-%s-%s-redis", var.prefix, var.env_short, var.location_short) : format("%s-%s-redis", var.prefix, var.env_short)
  resource_group_name = format("%s-%s-data-rg", var.prefix, var.env_short)
}

resource "azurerm_resource_group" "sec_rg" {
  name     = "${local.product}-${var.domain}-sec-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "key_vault" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault?ref=v8.53.0"

  name                       = "${local.product}-${var.domain}-kv"
  location                   = azurerm_resource_group.sec_rg.location
  resource_group_name        = azurerm_resource_group.sec_rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 90

  tags = module.tag_config.tags
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "ad_admin_group_policy" {
  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_admin.object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", "Encrypt", "Decrypt", "GetRotationPolicy", "Purge", "Recover", "Restore"]
  secret_permissions      = ["Get", "List", "Set", "Delete", "Purge", "Recover", "Restore"]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Purge", "Recover"]
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "adgroup_developers_policy" {
  count = var.env_short != "p" ? 1 : 0

  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_developers.object_id

  key_permissions     = ["Get", "List", "Update", "Create", "Import", "Delete", "Encrypt", "Decrypt", ]
  secret_permissions  = ["Get", "List", "Set", "Delete", "Restore", "Recover", ]
  storage_permissions = []
  certificate_permissions = [
    "Get", "List", "Update", "Create", "Import",
    "Delete", "Restore", "Purge", "Recover"
  ]
}

resource "azurerm_key_vault_access_policy" "adgroup_externals_policy" {
  count = var.env_short == "d" ? 1 : 0

  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_externals.object_id

  key_permissions     = ["Get", "List", "Update", "Create", "Import", "Delete", "Encrypt", "Decrypt", ]
  secret_permissions  = ["Get", "List", "Set", "Delete", "Restore", "Recover", ]
  storage_permissions = []
  certificate_permissions = [
    "Get", "List", "Update", "Create", "Import",
    "Delete", "Restore", "Purge", "Recover"
  ]
}

resource "azurerm_key_vault_secret" "iuv_generator_cosmos_connection_string" {
  name = "iuv-generator-cosmos-primary-connection-string"
  // the array is related to the input box in the following section https://portal.azure.com/#@pagopait.onmicrosoft.com/resource/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-weu-shared-rg/providers/Microsoft.DocumentDB/databaseAccounts/pagopa-d-weu-shared-iuv-gen-cosmos-account/tableKeys
  // the 4th input box is the PRIMARY CONNECTION STRING
  value        = module.iuvgenerator_cosmosdb_account.connection_strings[4]
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "storage_connection_string" {
  count        = var.env_short == "d" ? 1 : 0
  name         = format("poc-reporting-enrollment-%s-sa-connection-string", var.env_short)
  value        = module.poc_reporting_enrollment_sa[0].primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "poc_reporting_enrollment_subscription_key" {
  name         = format("poc-%s-reporting-enrollment-subscription-key", var.env_short)
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "authorizer_cosmos_connection_string" {
  name         = format("auth-%s-cosmos-connection-string", var.env_short)
  value        = module.authorizer_cosmosdb_account.connection_strings[0]
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

}

resource "azurerm_key_vault_secret" "authorizer_cosmos_uri" {
  name         = format("auth-%s-cosmos-uri", var.env_short)
  value        = module.authorizer_cosmosdb_account.endpoint
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

}

resource "azurerm_key_vault_secret" "authorizer_cosmos_key" {
  name         = format("auth-%s-cosmos-key", var.env_short)
  value        = module.authorizer_cosmosdb_account.primary_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

}

resource "azurerm_key_vault_secret" "redis_password" {
  name  = "redis-password"
  value = data.azurerm_redis_cache.redis_cache.primary_access_key

  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}


resource "azurerm_key_vault_secret" "redis_hostname" {
  name  = "redis-hostname"
  value = data.azurerm_redis_cache.redis_cache.hostname

  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

# https://api.dev.platform.pagopa.it/shared/authorizer/v1
resource "azurerm_key_vault_secret" "authorizer_refresh_configuration_url" {
  name         = format("auth-%s-refresh-configuration-url", var.env_short)
  value        = var.env == "prod" ? "https://api.platform.pagopa.it/shared/authorizer/v1" : "https://api.${var.env}.platform.pagopa.it/shared/authorizer/v1"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

}

# https://api.dev.platform.pagopa.it/apiconfig-selfcare-integration/v1
resource "azurerm_key_vault_secret" "apiconfig_selfcare_integration_url" {
  name         = format("auth-%s-apiconfig-selfcare-integration-url", var.env_short)
  value        = var.env == "prod" ? "https://api.platform.pagopa.it/apiconfig-selfcare-integration/v1" : "https://api.${var.env}.platform.pagopa.it/apiconfig-selfcare-integration/v1"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

}

resource "azurerm_key_vault_secret" "apiconfig_selfcare_integration_subkey" {
  name         = format("auth-%s-apiconfig-selfcare-integration-subkey", var.env_short)
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "authorizer_integrationtest_external_subkey" {
  name         = format("auth-%s-integrationtest-external-subkey", var.env_short)
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "authorizer_integrationtest_valid_subkey" {
  name         = format("auth-%s-integrationtest-valid-subkey", var.env_short)
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "authorizer_integrationtest_invalid_subkey" {
  name         = format("auth-%s-integrationtest-invalid-subkey", var.env_short)
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "pdf_engine_node_subkey" {

  name         = format("pdf-engine-node-subkey")
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "pdf_engine_perf_test_subkey" {
  count = var.env_short == "p" ? 0 : 1

  name         = format("pdf-engine-%s-perftest-subkey", var.env_short)
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}
resource "azurerm_key_vault_secret" "pdf_engine_node_perf_test_subkey" {
  count = var.env_short == "p" ? 0 : 1

  name         = format("pdf-engine-node-%s-perftest-subkey", var.env_short)
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "elastic_otel_token_header" {
  name         = "elastic-otel-token-header"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

#
# IaC
#

#pagopaspa-cstar-platform-iac-projects-{subscription}
data "azuread_service_principal" "platform_iac_sp" {
  display_name = "pagopaspa-pagoPA-iac-${data.azurerm_subscription.current.subscription_id}"
}

resource "azurerm_key_vault_access_policy" "azdevops_platform_iac_policy" {
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azuread_service_principal.platform_iac_sp.object_id

  secret_permissions      = ["Get", "List", "Set", ]
  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", "Encrypt", "Decrypt"]
  certificate_permissions = ["SetIssuers", "DeleteIssuers", "Purge", "List", "Get", ]

  storage_permissions = []
}

resource "azurerm_key_vault_secret" "ai_connection_string" {
  name         = "ai-${var.env_short}-connection-string"
  value        = data.azurerm_application_insights.application_insights.connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}


resource "azurerm_key_vault_secret" "elastic_apm_secret_token" {
  name         = "elastic-apm-secret-token"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "nodo5_slack_webhook_url" {
  name         = "nodo5-slack-webhook-url"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

# Wallet secrets ( JWT_SIGNATURE_KEY and PDV Tokenizer key )

#tfsec:ignore:azure-keyvault-ensure-secret-expiry:exp:2022-05-01 # already ignored, maybe a bug in tfsec
module "pagopa_wallet_jwt" {
  source = "github.com/pagopa/terraform-azurerm-v3//jwt_keys?ref=v8.21.0"
  # Save on KV :
  #  - pagopa-wallet-session-jwt-signature-key-private-key
  #  - pagopa-wallet-session-jwt-signature-key-public-key
  jwt_name         = "pagopa-wallet-session-jwt-signature-key"
  key_vault_id     = module.key_vault.id
  cert_common_name = "pagoPA platform session wallet token for IO"
  cert_password    = ""

  tags = module.tag_config.tags
}
# JWT_SIGNATURE_KEY   = trimspace(module.pagopa_wallet_jwt.jwt_private_key_pem) # to avoid unwanted changes


# DEPRECATED the real one is called personal-data-vault-api-key-wallet-session and is located in shared-secrets domain
resource "azurerm_key_vault_secret" "wallet_session_pdv_api_key" {
  name         = "personal-data-vault-api-key"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

# ##########################
# Anonymizer Shared domain subkey
# ##########################
data "azurerm_api_management_product" "anonymizer_product" {
  product_id          = "anonymizer"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}
resource "azurerm_api_management_subscription" "shared_anonymizer_api_key_subkey" {
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  product_id    = data.azurerm_api_management_product.anonymizer_product.id
  display_name  = "Anonymizer shared-anonymizer-api-key"
  allow_tracing = false
  state         = "active"
}
resource "azurerm_key_vault_secret" "shared_anonymizer_api_keysubkey_store_kv" {
  depends_on = [
    azurerm_api_management_subscription.shared_anonymizer_api_key_subkey
  ]
  name         = "shared-anonymizer-api-key"
  value        = azurerm_api_management_subscription.shared_anonymizer_api_key_subkey.primary_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}
