resource "azurerm_resource_group" "sec_rg" {
  name     = "${local.product}-${var.domain}-sec-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "key_vault" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault?ref=v8.20.1"

  name                       = "${local.product}-${var.domain}-kv"
  location                   = azurerm_resource_group.sec_rg.location
  resource_group_name        = azurerm_resource_group.sec_rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 90

  tags = module.tag_config.tags
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "ad_group_policy" {
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

  key_permissions     = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions  = ["Get", "List", "Set", "Delete", ]
  storage_permissions = []
  certificate_permissions = [
    "Get", "List", "Update", "Create", "Import",
    "Delete", "Restore", "Purge", "Recover"
  ]
}

# azure devops policy
data "azuread_service_principal" "iac_principal" {
  count        = var.enable_iac_pipeline ? 1 : 0
  display_name = "pagopaspa-pagoPA-iac-${data.azurerm_subscription.current.subscription_id}"
}

data "azurerm_eventhub_authorization_rule" "sender_evt_tx_event_hub_connection_string" {
  name                = "payment-wallet-evt-tx"
  namespace_name      = "${local.product_italy}-observ-evh"
  eventhub_name       = "payment-wallet-ingestion-dl"
  resource_group_name = "${local.product_italy}-observ-evh-rg"
}

resource "azurerm_key_vault_access_policy" "azdevops_iac_policy" {
  count        = var.enable_iac_pipeline ? 1 : 0
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azuread_service_principal.iac_principal[0].object_id

  secret_permissions      = ["Get", "List", "Set", ]
  certificate_permissions = ["SetIssuers", "DeleteIssuers", "Purge", "List", "Get"]
  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", "Encrypt", "Decrypt"]

  storage_permissions = []
}


resource "azurerm_key_vault_access_policy" "cdn_wallet_kv" {
  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = "f3b3f72f-4770-47a5-8c1e-aa298003be12"

  secret_permissions      = ["Get", ]
  storage_permissions     = []
  certificate_permissions = ["Get", ]
}

resource "azurerm_key_vault_secret" "ai_connection_string" {
  name         = "ai-${var.env_short}-connection-string"
  value        = data.azurerm_application_insights.application_insights_italy.connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "redis_wallet_password" {
  name         = "redis-wallet-password"
  value        = module.pagopa_pay_wallet_redis[0].primary_access_key
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "sender_evt_tx_event_hub_connection_string" {
  name         = "sender-evt-tx-event-hub-connection-string"
  value        = data.azurerm_eventhub_authorization_rule.sender_evt_tx_event_hub_connection_string.primary_connection_string
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "personal-data-vault-api-key" {
  name         = "personal-data-vault-api-key"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "wallet-jwt-signing-key" {
  name         = "wallet-jwt-signing-key"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "payment-method-api-key" {
  name         = "payment-method-api-key"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}


resource "azurerm_key_vault_secret" "mongo_wallet_password" {
  name         = "mongo-wallet-password"
  value        = module.cosmosdb_account_mongodb[0].primary_master_key
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

resource "azurerm_key_vault_secret" "npg_service_api_key" {
  name         = "npg-service-api-key"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "wallet-token-test-key" {
  count        = var.env_short != "p" ? 1 : 0
  name         = "wallet-token-test-key"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "paypal_psp_api_key" {
  name         = "paypal-psp-api-key"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id
  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "npg_notifications_jwt_secret_key" {
  name         = "npg-notifications-jwt-secret-key"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id
  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "wallet_storage_connection_string" {
  name         = "wallet-storage-connection-string"
  value        = module.pay_wallet_storage[0].primary_connection_string
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "wallet_storage_account_key" {
  name         = "wallet-storage-account-key"
  value        = module.pay_wallet_storage[0].primary_access_key
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "wallet_migration_api_key_test_dev" {
  count        = var.env_short != "p" ? 1 : 0
  name         = "wallet-migration-api-key-test-dev"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "wallet_migration_cstar_api_key_test_dev" {
  count        = var.env_short != "p" ? 1 : 0
  name         = "wallet-migration-cstar-api-key-test-dev"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "migration_wallet_token_test_dev" {
  count        = var.env_short != "p" ? 1 : 0
  name         = "migration-wallet-token-test-dev"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}


resource "azurerm_key_vault_secret" "payment_wallet_opsgenie_webhook_token" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "payment-wallet-opsgenie-webhook-token"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

//connection string to soak test evh instance
data "azurerm_eventhub_authorization_rule" "sender_evt_tx_event_hub_connection_string_soak_test" {
  count               = var.env_short == "u" ? 1 : 0
  name                = "payment-wallet-evt-tx-soak-test"
  namespace_name      = "${local.product_italy}-observ-evh"
  eventhub_name       = "payment-wallet-ingestion-dl-soak-test"
  resource_group_name = "${local.product_italy}-observ-evh-rg"
}


resource "azurerm_key_vault_secret" "sender_evt_tx_event_hub_connection_string_soak_test" {
  count        = var.env_short == "u" ? 1 : 0
  name         = "sender-evt-tx-event-hub-connection-string-soak-test"
  value        = data.azurerm_eventhub_authorization_rule.sender_evt_tx_event_hub_connection_string_soak_test[0].primary_connection_string
  key_vault_id = module.key_vault.id
}


//connection string to staging evh instance
data "azurerm_eventhub_authorization_rule" "sender_evt_tx_event_hub_connection_string_staging" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "payment-wallet-evt-tx-staging"
  namespace_name      = "${local.product_italy}-observ-evh"
  eventhub_name       = "payment-wallet-ingestion-dl-staging"
  resource_group_name = "${local.product_italy}-observ-evh-rg"
}


resource "azurerm_key_vault_secret" "sender_evt_tx_event_hub_connection_string_staging" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "sender-evt-tx-event-hub-connection-string-staging"
  value        = data.azurerm_eventhub_authorization_rule.sender_evt_tx_event_hub_connection_string_staging[0].primary_connection_string
  key_vault_id = module.key_vault.id
}



resource "azurerm_key_vault_secret" "payment_wallet_gha_bot_pat" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "payment-wallet-gha-bot-pat"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}


resource "azurerm_key_vault_certificate" "pay-wallet-jwt-token-issuer-certificate" {
  name         = "jwt-token-issuer-cert"
  key_vault_id = module.key_vault.id

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = true
      key_size   = 2048
      key_type   = "RSA"
      reuse_key  = false
    }

    lifetime_action {
      action {
        action_type = "AutoRenew"
      }

      trigger {
        days_before_expiry = 2
      }
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }

    x509_certificate_properties {
      key_usage = [
        "digitalSignature"
      ]
      subject            = "CN=${var.env}-${var.domain}-jwt-issuer"
      validity_in_months = 1
    }
  }
}

resource "azurerm_key_vault_certificate" "pay-wallet-jwt-token-issuer-certificate-ec" {
  name         = "jwt-token-issuer-cert-ec"
  key_vault_id = module.key_vault.id

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = true
      key_size   = 256
      key_type   = "EC"
      reuse_key  = false
      curve      = "P-256"
    }

    lifetime_action {
      action {
        action_type = "AutoRenew"
      }

      trigger {
        days_before_expiry = 2
      }
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }

    x509_certificate_properties {
      key_usage = [
        "digitalSignature"
      ]
      subject            = "CN=${var.env}-${var.domain}-jwt-issuer"
      validity_in_months = 1
    }
  }
}

resource "random_password" "pay_wallet_jwt_issuer_service_primary_api_key_pass" {
  length  = 32
  special = false
  #key-value string map used to track resource state: if one key-value change a resource regeneration is triggered
  keepers = {
    "version" : "1"
  }
}

resource "random_password" "pay_wallet_jwt_issuer_service_secondary_api_key_pass" {
  length  = 32
  special = false
  #key-value string map used to track resource state: if one key-value change a resource regeneration is triggered
  keepers = {
    "version" : "1"
  }
}

resource "azurerm_key_vault_secret" "pay_wallet_jwt_issuer_service_primary_api_key" {
  name         = "pay-wallet-jwt-issuer-service-primary-api-key"
  value        = random_password.pay_wallet_jwt_issuer_service_primary_api_key_pass.result
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "pay_wallet_jwt_issuer_service_secondary_api_key" {
  name         = "pay-wallet-jwt-issuer-service-secondary-api-key"
  value        = random_password.pay_wallet_jwt_issuer_service_secondary_api_key_pass.result
  key_vault_id = module.key_vault.id
}
