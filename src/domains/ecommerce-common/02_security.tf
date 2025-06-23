resource "azurerm_resource_group" "sec_rg" {
  name     = "${local.product}-${var.domain}-sec-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "key_vault" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault?ref=v8.42.3"


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
  display_name = format("pagopaspa-pagoPA-iac-%s", data.azurerm_subscription.current.subscription_id)
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

resource "azurerm_key_vault_secret" "elastic-apm-secret-token" {
  name         = "elastic-apm-secret-token"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "notifications_sender" {
  name         = "notifications-sender"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "touchpoint_mail" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "touchpoint-mail"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "ai_connection_string" {
  name         = "applicationinsights-connection-string"
  value        = data.azurerm_application_insights.application_insights.connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "sessions_jwt_secret" {
  name         = "sessions-jwt-secret"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "aws_ses_accesskey_id" {
  name         = "aws-ses-accesskey-id"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "aws_ses_accesskey_key" {
  name         = "aws-ses-secretaccess-key"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "ecommerce_storage_transient_connection_string" {
  name         = "ecommerce-storage-transient-connection-string"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "ecommerce_storage_deadletter_connection_string" {
  name         = "ecommerce-storage-deadletter-connection-string"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "ecommerce_storage_transient_account_key" {
  name         = "ecommerce-storage-transient-account-key"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "mongo_ecommerce_password" {
  name         = "mongo-ecommerce-password"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "redis_ecommerce_password" {
  name         = "redis-ecommerce-password"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "redis_ecommerce_access_key" {
  name         = "redis-ecommerce-access-key"
  value        = module.pagopa_ecommerce_redis.primary_access_key
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "redis_ecommerce_hostname" {
  name         = "redis-ecommerce-hostname"
  value        = module.pagopa_ecommerce_redis.hostname
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "nodo_connection_string" {
  name         = "nodo-connection-string"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "notifications_service_api_key" {
  name         = "notifications-service-api-key"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "payment_method_api_key" {
  name         = "payment-method-api-key"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
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

resource "azurerm_key_vault_secret" "npg_api_key" {
  name         = "npg-api-key"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "pm_oracle_db_host" {
  name         = "pm-oracle-db-host"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "pm_oracle_db_password" {
  name         = "pm-oracle-db-password"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "helpdesk-service-testing-api-key" {
  count        = var.env_short != "p" ? 1 : 0
  name         = "helpdesk-service-testing-api-key"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "helpdesk-service-testing-email" {
  count        = var.env_short != "p" ? 1 : 0
  name         = "helpdesk-service-testing-email"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "helpdesk-service-testing-fiscalCode" {
  count        = var.env_short != "p" ? 1 : 0
  name         = "helpdesk-service-testing-fiscalCode"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "npg_cards_psp_keys" {
  name         = "npg-cards-psp-keys"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "ecommerce_opsgenie_webhook_token" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "ecommerce-opsgenie-webhook-token"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "nodo_nodeforpsp_api_key" {
  name         = "nodo-nodeforpsp-api-key"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "nodo_nodeforpm_api_key" {
  name         = "nodo-nodeforpm-api-key"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "node_for_ecommerce_api_v1_key" {
  name         = "node-for-ecommerce-api-v1-key"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "node_for_ecommerce_api_v2_key" {
  name         = "node-for-ecommerce-api-v2-key"
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

resource "azurerm_key_vault_secret" "ecommerce-io-jwt-signing-key" {
  name         = "ecommerce-io-jwt-signing-key"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "ecommerce_storage_dead_letter_account_key" {
  name         = "ecommerce-storage-dead-letter-account-key"
  value        = module.ecommerce_storage_deadletter.primary_access_key
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "wallet-api-key" {
  name         = "wallet-api-key"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}


resource "azurerm_key_vault_secret" "npg_notification_signing_key" {
  name         = "npg-notification-signing-key"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}


resource "azurerm_key_vault_secret" "node_forwarder_api_key" {
  name         = "node-forwarder-api-key"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "transactions_service_auth_update_api_key" {
  name         = "transactions-service-auth-update-api-key"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}


resource "azurerm_key_vault_secret" "user_stats_for_event_dispatcher_api_key" {
  name         = "user-stats-for-event-dispatcher-api-key"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "redirect_url_mapping" {
  name         = "redirect-url-mapping"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "npg_paypal_psp_keys" {
  name         = "npg-paypal-psp-keys"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "npg_bancomatpay_psp_keys" {
  name         = "npg-bancomatpay-psp-keys"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "npg_mybank_psp_keys" {
  name         = "npg-mybank-psp-keys"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "npg_apple_pay_psp_keys" {
  name         = "npg-apple-pay-psp-keys"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "npg_satispay_psp_keys" {
  name         = "npg-satispay-psp-keys"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "helpdesk-service-testing-email-history" {
  count        = var.env_short != "p" ? 1 : 0
  name         = "helpdesk-service-testing-email-history"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "ecommerce_for_checkout_google_recaptcha_secret" {
  name         = "ecommerce-for-checkout-google-recaptcha-secret"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "ecommerce_dev_sendpaymentresult_subscription_key" {
  count        = var.env_short == "u" ? 1 : 0
  name         = "ecommerce-dev-sendpaymentresult-subscription-key"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "transactions_service_auth_update_api_key_v2" {
  name         = "transactions-service-auth-update-api-key-v2"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "npg_google_pay_psp_keys" {
  name         = "npg-google-pay-psp-keys"
  value        = "{}"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "ecommerce_reporting_webhook_url_slack" {
  name         = "ecommerce-reporting-webhook-url-slack"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "helpdesk_service_api_key_for_reporting" {
  name         = "helpdesk-service-api-key-for-reporting"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "ecommerce_storage_reporting_connection_string" {
  name         = "ecommerce-storage-reporting-connection-string"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "ecommerce_gha_bot_pat" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "ecommerce-gha-bot-pat"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "service_management_opsgenie_webhook_token" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "service-management-opsgenie-webhook-token"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "random_password" "ecommerce_payment_requests_primary_api_key_pass" {
  length  = 32
  special = false
}

resource "random_password" "ecommerce_payment_requests_secondary_api_key_pass" {
  length  = 32
  special = false
}

resource "azurerm_key_vault_secret" "ecommerce_payment_requests_primary_api_key" {
  name         = "ecommerce-payment-requests-primary-api-key"
  value        = random_password.ecommerce_payment_requests_primary_api_key_pass.result
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "ecommerce_payment_requests_secondary_api_key" {
  name         = "ecommerce-payment-requests-secondary-api-key"
  value        = random_password.ecommerce_payment_requests_secondary_api_key_pass.result
  key_vault_id = module.key_vault.id
}

resource "random_password" "ecommerce_payment_methods_primary_api_key_pass" {
  length  = 32
  special = false
  #key-value string map used to track resource state: if one key-value change a resource regeneration is triggered
  keepers = {
    "version" : "1"
  }
}

resource "random_password" "ecommerce_payment_methods_secondary_api_key_pass" {
  length  = 32
  special = false
  #key-value string map used to track resource state: if one key-value change a resource regeneration is triggered
  keepers = {
    "version" : "1"
  }
}

resource "azurerm_key_vault_secret" "ecommerce_payment_methods_primary_api_key" {
  name         = "ecommerce-payment-methods-primary-api-key"
  value        = random_password.ecommerce_payment_methods_primary_api_key_pass.result
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "ecommerce_payment_methods_secondary_api_key" {
  name         = "ecommerce-payment-methods-secondary-api-key"
  value        = random_password.ecommerce_payment_methods_secondary_api_key_pass.result
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_certificate" "ecommerce-jwt-token-issuer-certificate" {
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

resource "azurerm_key_vault_certificate" "ecommerce-jwt-token-issuer-certificate-ec" {
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

resource "random_password" "ecommerce_helpdesk_service_primary_api_key_pass" {
  length  = 32
  special = false
}

resource "random_password" "ecommerce_helpdesk_service_secondary_api_key_pass" {
  length  = 32
  special = false
}

resource "azurerm_key_vault_secret" "ecommerce_helpdesk_service_primary_api_key" {
  name         = "ecommerce-helpdesk-service-primary-api-key"
  value        = random_password.ecommerce_helpdesk_service_primary_api_key_pass.result
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "ecommerce_helpdesk_service_secondary_api_key" {
  name         = "ecommerce-helpdesk-service-secondary-api-key"
  value        = random_password.ecommerce_helpdesk_service_secondary_api_key_pass.result
  key_vault_id = module.key_vault.id
}
