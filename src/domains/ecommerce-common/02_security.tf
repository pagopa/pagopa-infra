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

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", "Encrypt", "Decrypt", "GetRotationPolicy", "SetRotationPolicy", "Purge", "Recover", "Restore", "Rotate"]
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

  key_permissions     = ["Get", "List", "Update", "Create", "Import", "Delete", "Encrypt", "Decrypt", "GetRotationPolicy", "SetRotationPolicy", "Rotate"]
  secret_permissions  = ["Get", "List", "Set", "Delete", ]
  storage_permissions = []
  certificate_permissions = [
    "Get", "List", "Update", "Create", "Import",
    "Delete", "Restore", "Purge", "Recover"
  ]
}

resource "azurerm_key_vault_access_policy" "adgroup_external_dev_policy" {
  count = var.env_short != "p" ? 1 : 0

  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_developer_externals[0].object_id

  key_permissions     = ["Get", "List", "Update", "Create", "Import", "Delete", "Encrypt", "Decrypt", "GetRotationPolicy"]
  secret_permissions  = ["Get", "List", "Set", "Delete", ]
  storage_permissions = []
  certificate_permissions = [
    "Get", "List", "Update", "Create", "Import",
    "Delete", "Restore", "Purge", "Recover"
  ]
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "adgroup_admin_dev_policy" {

  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_admin_dev.object_id

  key_permissions     = ["Get", "List", "Update", "Create", "Import", "Delete", "Encrypt", "Decrypt", "GetRotationPolicy", "SetRotationPolicy", "Purge", "Recover", "Restore", "Rotate"]
  secret_permissions  = ["Get", "List", "Set", "Delete", ]
  storage_permissions = []
  certificate_permissions = [
    "Get", "List", "Update", "Create", "Import",
    "Delete", "Restore", "Purge", "Recover"
  ]
}

resource "azurerm_key_vault_secret" "ai_connection_string" {
  name         = "applicationinsights-connection-string"
  value        = data.azurerm_application_insights.application_insights.connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
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

resource "azurerm_key_vault_secret" "ecommerce_storage_dead_letter_account_key" {
  name         = "ecommerce-storage-dead-letter-account-key"
  value        = module.ecommerce_storage_deadletter.primary_access_key
  key_vault_id = module.key_vault.id
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

resource "random_password" "ecommerce_notification_service_primary_api_key_pass" {
  length  = 32
  special = false
  #key-value string map used to track resource state: if one key-value change a resource regeneration is triggered
  keepers = {
    "version" : "1"
  }
}

resource "random_password" "ecommerce_notification_service_secondary_api_key_pass" {
  length  = 32
  special = false
  #key-value string map used to track resource state: if one key-value change a resource regeneration is triggered
  keepers = {
    "version" : "1"
  }
}

resource "azurerm_key_vault_secret" "ecommerce_notification_service_primary_api_key" {
  name         = "ecommerce-notification-service-primary-api-key"
  value        = random_password.ecommerce_notification_service_primary_api_key_pass.result
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "ecommerce_notification_service_secondary_api_key" {
  name         = "ecommerce-notification-service-secondary-api-key"
  value        = random_password.ecommerce_notification_service_secondary_api_key_pass.result
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



resource "random_password" "ecommerce_transactions_service_primary_api_key_pass" {
  length  = 32
  special = false
  #key-value string map used to track resource state: if one key-value change a resource regeneration is triggered
  keepers = {
    "version" : "1"
  }
}

resource "random_password" "ecommerce_transactions_service_secondary_api_key_pass" {
  length  = 32
  special = false
  #key-value string map used to track resource state: if one key-value change a resource regeneration is triggered
  keepers = {
    "version" : "1"
  }
}

resource "azurerm_key_vault_secret" "ecommerce_transactions_service_primary_api_key" {
  name         = "ecommerce-transactions-service-primary-api-key"
  value        = random_password.ecommerce_transactions_service_primary_api_key_pass.result
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "ecommerce_transactions_service_secondary_api_key" {
  name         = "ecommerce-transactions-service-secondary-api-key"
  value        = random_password.ecommerce_transactions_service_secondary_api_key_pass.result
  key_vault_id = module.key_vault.id
}



resource "random_password" "ecommerce_event_dispatcher_service_primary_api_key_pass" {
  length  = 32
  special = false
  #key-value string map used to track resource state: if one key-value change a resource regeneration is triggered
  keepers = {
    "version" : "1"
  }
}

resource "random_password" "ecommerce_event_dispatcher_service_secondary_api_key_pass" {
  length  = 32
  special = false
  #key-value string map used to track resource state: if one key-value change a resource regeneration is triggered
  keepers = {
    "version" : "1"
  }
}

resource "azurerm_key_vault_secret" "ecommerce_event_dispatcher_service_primary_api_key" {
  name         = "ecommerce-event-dispatcher-service-primary-api-key"
  value        = random_password.ecommerce_event_dispatcher_service_primary_api_key_pass.result
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "ecommerce_event_dispatcher_service_secondary_api_key" {
  name         = "ecommerce-event-dispatcher-service-secondary-api-key"
  value        = random_password.ecommerce_event_dispatcher_service_secondary_api_key_pass.result
  key_vault_id = module.key_vault.id
}

resource "random_password" "ecommerce_user_stats_service_primary_api_key_pass" {
  length  = 32
  special = false
  #key-value string map used to track resource state: if one key-value change a resource regeneration is triggered
  keepers = {
    "version" : "1"
  }
}

resource "random_password" "ecommerce_user_stats_service_secondary_api_key_pass" {
  length  = 32
  special = false
  #key-value string map used to track resource state: if one key-value change a resource regeneration is triggered
  keepers = {
    "version" : "1"
  }
}

resource "azurerm_key_vault_secret" "ecommerce_user_stats_service_primary_api_key" {
  name         = "ecommerce-user-stats-service-primary-api-key"
  value        = random_password.ecommerce_user_stats_service_primary_api_key_pass.result
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "ecommerce_user_stats_service_secondary_api_key" {
  name         = "ecommerce-user-stats-service-secondary-api-key"
  value        = random_password.ecommerce_user_stats_service_secondary_api_key_pass.result
  key_vault_id = module.key_vault.id
}

resource "random_password" "ecommerce_jwt_issuer_service_primary_api_key_pass" {
  length  = 32
  special = false
  #key-value string map used to track resource state: if one key-value change a resource regeneration is triggered
  keepers = {
    "version" : "1"
  }
}

resource "random_password" "ecommerce_jwt_issuer_service_secondary_api_key_pass" {
  length  = 32
  special = false
  #key-value string map used to track resource state: if one key-value change a resource regeneration is triggered
  keepers = {
    "version" : "1"
  }
}

resource "azurerm_key_vault_secret" "ecommerce_jwt_issuer_service_primary_api_key" {
  name         = "ecommerce-jwt-issuer-service-primary-api-key"
  value        = random_password.ecommerce_jwt_issuer_service_primary_api_key_pass.result
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "ecommerce_jwt_issuer_service_secondary_api_key" {
  name         = "ecommerce-jwt-issuer-service-secondary-api-key"
  value        = random_password.ecommerce_jwt_issuer_service_secondary_api_key_pass.result
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "ecommerce_jwt_issuer_service_active_api_key" {
  name         = "ecommerce-jwt-issuer-service-active-api-key"
  value        = var.ecommerce_jwt_issuer_api_key_use_primary ? azurerm_key_vault_secret.ecommerce_jwt_issuer_service_primary_api_key.value : azurerm_key_vault_secret.ecommerce_jwt_issuer_service_secondary_api_key.value
  key_vault_id = module.key_vault.id
}

resource "random_password" "ecommerce_helpdesk_command_service_primary_api_key_pass" {
  length  = 32
  special = false
  #key-value string map used to track resource state: if one key-value change a resource regeneration is triggered
  keepers = {
    "version" : "1"
  }
}

resource "random_password" "ecommerce_helpdesk_command_service_secondary_api_key_pass" {
  length  = 32
  special = false
  #key-value string map used to track resource state: if one key-value change a resource regeneration is triggered
  keepers = {
    "version" : "1"
  }
}

resource "azurerm_key_vault_secret" "ecommerce_helpdesk_command_service_primary_api_key" {
  name         = "ecommerce-helpdesk-command-service-primary-api-key"
  value        = random_password.ecommerce_helpdesk_command_service_primary_api_key_pass.result
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "ecommerce_helpdesk_command_service_secondary_api_key" {
  name         = "ecommerce-helpdesk-command-service-secondary-api-key"
  value        = random_password.ecommerce_helpdesk_command_service_secondary_api_key_pass.result
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_certificate" "ecommerce-watchdog-deadletter-jwt-certificate" {
  name         = "watchdog-jwt-cert"
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
      subject            = "CN=${var.env}-${var.domain}-watchdog-deadletter"
      validity_in_months = 1
    }
  }
}
