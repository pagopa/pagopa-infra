resource "azurerm_resource_group" "sec_rg" {
  name     = "${local.product}-${var.domain}-sec-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "key_vault" {
  source = "./.terraform/modules/__v3__/key_vault"

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

  key_permissions     = ["Get", "List", "Update", "Create", "Import", "Delete", "Encrypt", "Decrypt"]
  secret_permissions  = ["Get", "List", "Set", "Delete", ]
  storage_permissions = []
  certificate_permissions = [
    "Get", "List", "Update", "Create", "Import",
    "Delete", "Restore", "Purge", "Recover"
  ]
}

resource "azurerm_key_vault_access_policy" "adgroup_externals_policy" {
  count = var.env_short != "p" ? 1 : 0

  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_externals.object_id

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

resource "azurerm_key_vault_secret" "cosmos_gps_pkey" {
  name         = format("cosmos-gps-%s-%s-pkey", var.location_short, var.env_short) # cosmos-gps-<REGION>-<ENV>-pkey
  value        = module.gps_cosmosdb_account.primary_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "ai_connection_string" {
  name         = format("ai-%s-connection-string", var.env_short)
  value        = data.azurerm_application_insights.application_insights.connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "flows_sa_connection_string" {
  name         = format("flows-sa-%s-connection-string", var.env_short)
  value        = module.flows.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "storage_reporting_connection_string" {
  # refers to pagopa<env>flowsa primary key
  name         = format("gpd-reporting-flow-%s-sa-connection-string", var.env_short)
  value        = module.flows.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "payments_cosmos_connection_string" {
  name         = format("gpd-payments-%s-cosmos-connection-string", var.env_short)
  value        = module.gpd_payments_cosmosdb_account.connection_strings[4]
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "gpd_reporting_batch_connection_string" {
  name         = format("gpd-%s-reporting-batch-connection-string", var.env_short)
  value        = module.flows.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

## ########################### ##
## TODO put it into gps-secret
## ########################### ##

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "monitor_notification_slack_email" {
  name         = "monitor-notification-slack-email"
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "monitor_notification_email" {
  name         = "monitor-notification-email"
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "gpd_reporting_enrollment_subscription_key" {
  name         = format("gpd-%s-reporting-enrollment-subscription-key", var.env_short)
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}


#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "gpd_apiconfig_subscription_key" {
  name         = format("gpd-%s-apiconfig-subscription-key", var.env_short)
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "gpd_gps_subscription_key" {
  name         = format("gpd-%s-gps-subscription-key", var.env_short)
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "gpd_gpd_subscription_key" {
  name         = format("gpd-%s-gpd-subscription-key", var.env_short)
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "gpd_node_subscription_key" {
  name         = format("gpd-%s-node-subscription-key", var.env_short)
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "gpd_iuv_generator_subscription_key" {
  name         = format("gpd-%s-iuv-generator-subscription-key", var.env_short)
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "gpd_donations_subscription_key" {
  name         = format("gpd-%s-donations-subscription-key", var.env_short)
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

## Used for integration test only ##
#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "gpd_payments_rest_subscription_key" {
  name         = format("gpd-%s-payments-rest-subscription-key", var.env_short)
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "gpd_payments_soap_subscription_key" {
  name         = format("gpd-%s-payments-soap-subscription-key", var.env_short)
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "gpd_reporting_subscription_key" {
  name         = format("gpd-%s-reporting-subscription-key", var.env_short)
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

# Reporting Batch
#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "gpd-paa-password" {
  name         = format("gpd-%s-paa-password", var.env_short)
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "gpd_db_usr" {
  name         = "db-apd-user-name"
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "gpd_db_pwd" {
  name         = "db-apd-user-password"
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

## KV secrets flex server ##

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "pgres_admin_login" {
  name         = "pgres-admin-login"
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "pgres_admin_pwd" {
  name         = "pgres-admin-pwd"
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "db_url" {
  name         = "db-url"
  value        = format("jdbc:postgresql://%s:%s/%s?sslmode=require%s", local.gpd_hostname, local.gpd_dbmsport, var.gpd_db_name, "&prepareThreshold=0")
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "flyway_db_url" {
  name         = "flyway-db-url"
  value        = format("jdbc:postgresql://%s:%s/%s?sslmode=require%s", local.gpd_hostname, local.flyway_gpd_dbmsport, var.gpd_db_name, "&prepareThreshold=0&lock_timeout=30000")
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

}

# resource "azurerm_key_vault_secret" "db_url" {
#   name         = "db-url"
#   value        = format("jdbc:postgresql://%s:%s/%s?sslmode=require%s", local.gpd_hostname, local.gpd_dbmsport, var.gpd_db_name, (var.env_short != "d" ? "&prepareThreshold=0" : ""))
#   content_type = "text/plain"

#   key_vault_id = module.key_vault.id

# }

## GPD-Upload secrets START ##

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "gpd_core_key_for_upload" {
  name         = "gpd-core-key-for-gpd-upload"
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "gpd_upload_sa_connection_string" {
  name         = "gpd-upload-sa-connection-string"
  value        = module.gpd_sa_sftp.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

}

resource "azurerm_key_vault_secret" "gpd_upload_db_key" {
  name         = "gpd-upload-db-key"
  value        = module.gps_cosmosdb_account.primary_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

}

## GPD-Upload secrets END ##


## GDP archive conn-string

resource "azurerm_key_vault_secret" "gpd_archive_sa_connection_string" {
  name = "gpd-archive-${var.env_short}-sa-connection-string"
  # value        = module.gpd_archive_sa.primary_connection_string // az sa tables
  value        = module.gpd_payments_cosmosdb_account.connection_strings[4] // az cosmos tables
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

}

# GPD Payments queue retry connection string

resource "azurerm_key_vault_secret" "gpd_payments_retry_sa_connection_string" {
  name         = "gpd-payments-${var.env_short}-queue-connection-string"
  value        = module.gpd_sa_sftp.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

}

resource "azurerm_key_vault_secret" "elastic_otel_token_header" {
  name         = "elastic-apm-secret-token" #"elastic-otel-token-header"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

# #######################
# CDC GPD config secrets
# #######################


data "azurerm_storage_account" "gpd_ingestion_sa" {
  name                = "pagopa${var.env_short}gpdingestsa"
  resource_group_name = "pagopa-${var.env_short}-itn-observ-gpd-rg"
}

resource "azurerm_key_vault_secret" "azure_web_jobs_storage_kv" {
  name         = "AzureWebJobsStorage-gdp-ingestion"
  value        = data.azurerm_storage_account.gpd_ingestion_sa.primary_connection_string
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}

# #############################
# CONFIG CACHE GDP in EventHub
# #############################

resource "azurerm_key_vault_secret" "config-cache-eh-connection-for-aca-payments" {
  name         = "config-cache-event-hub-connection-string-for-aca-payments"
  value        = data.azurerm_eventhub_authorization_rule.nodo_dei_pagamenti_cache_aca_rx.primary_connection_string
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}

# ##########################
# CDC GDP in eventhub
# ##########################
data "azurerm_eventhub_authorization_rule" "cdc-raw-auto_apd_payment_option-rx" {
  name                = "cdc-raw-auto.apd.payment_option-rx"
  namespace_name      = "pagopa-${var.env_short}-itn-observ-gpd-evh"
  eventhub_name       = "cdc-raw-auto.apd.payment_option"
  resource_group_name = "pagopa-${var.env_short}-itn-observ-evh-rg"
}
resource "azurerm_key_vault_secret" "cdc-raw-auto_apd_payment_option-rx_kv" {
  name         = "payment-option-topic-input-conn-string"
  value        = data.azurerm_eventhub_authorization_rule.cdc-raw-auto_apd_payment_option-rx.primary_connection_string
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}
data "azurerm_eventhub_authorization_rule" "cdc-raw-auto_apd_payment_position-rx" {
  name                = "cdc-raw-auto.apd.payment_position-rx"
  namespace_name      = "pagopa-${var.env_short}-itn-observ-gpd-evh"
  eventhub_name       = "cdc-raw-auto.apd.payment_position"
  resource_group_name = "pagopa-${var.env_short}-itn-observ-evh-rg"
}
resource "azurerm_key_vault_secret" "cdc-raw-auto_apd_payment_position-rx_kv" {
  name         = "payment-position-topic-input-conn-string"
  value        = data.azurerm_eventhub_authorization_rule.cdc-raw-auto_apd_payment_position-rx.primary_connection_string
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}
data "azurerm_eventhub_authorization_rule" "cdc-raw-auto_apd_transfer-rx" {
  name                = "cdc-raw-auto.apd.transfer-rx"
  namespace_name      = "pagopa-${var.env_short}-itn-observ-gpd-evh"
  eventhub_name       = "cdc-raw-auto.apd.transfer"
  resource_group_name = "pagopa-${var.env_short}-itn-observ-evh-rg"
}
resource "azurerm_key_vault_secret" "cdc-raw-auto_apd_transfer-rx_kv" {
  name         = "transfer-topic-input-conn-string"
  value        = data.azurerm_eventhub_authorization_rule.cdc-raw-auto_apd_transfer-rx.primary_connection_string
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}

# ##########################
# CDC GDP out eventhub
# ##########################
data "azurerm_eventhub_authorization_rule" "gpd_ingestion_apd_payment_option_tx" {
  count               = var.gpd_cdc_enabled ? 1 : 0
  name                = "gpd-ingestion.apd.payment_option-tx"
  namespace_name      = "pagopa-${var.env_short}-itn-observ-gpd-evh"
  eventhub_name       = "gpd-ingestion.apd.payment_option"
  resource_group_name = "pagopa-${var.env_short}-itn-observ-evh-rg"
}

resource "azurerm_key_vault_secret" "gpd_ingestion_apd_payment_option_tx_kv" {
  count        = var.gpd_cdc_enabled ? 1 : 0
  name         = "payment-option-topic-output-conn-string"
  value        = data.azurerm_eventhub_authorization_rule.gpd_ingestion_apd_payment_option_tx[0].primary_connection_string
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}

data "azurerm_eventhub_authorization_rule" "gpd_ingestion_apd_payment_position_tx" {
  count               = var.gpd_cdc_enabled ? 1 : 0
  name                = "gpd-ingestion.apd.payment_position-tx"
  namespace_name      = "pagopa-${var.env_short}-itn-observ-gpd-evh"
  eventhub_name       = "gpd-ingestion.apd.payment_position"
  resource_group_name = "pagopa-${var.env_short}-itn-observ-evh-rg"
}

resource "azurerm_key_vault_secret" "gpd_ingestion_apd_payment_position_tx_kv" {
  count        = var.gpd_cdc_enabled ? 1 : 0
  name         = "payment-position-topic-output-conn-string"
  value        = data.azurerm_eventhub_authorization_rule.gpd_ingestion_apd_payment_position_tx[0].primary_connection_string
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}

data "azurerm_eventhub_authorization_rule" "gpd_ingestion_apd_payment_option_transfer_tx" {
  count               = var.gpd_cdc_enabled ? 1 : 0
  name                = "gpd-ingestion.apd.transfer-tx"
  namespace_name      = "pagopa-${var.env_short}-itn-observ-gpd-evh"
  eventhub_name       = "gpd-ingestion.apd.transfer"
  resource_group_name = "pagopa-${var.env_short}-itn-observ-evh-rg"
}

resource "azurerm_key_vault_secret" "gpd_ingestion_apd_payment_option_transfer_tx_kv" {
  count        = var.gpd_cdc_enabled ? 1 : 0
  name         = "transfer-topic-output-conn-string"
  value        = data.azurerm_eventhub_authorization_rule.gpd_ingestion_apd_payment_option_transfer_tx[0].primary_connection_string
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}


data "azurerm_eventhub_authorization_rule" "pagopa-evh-rtp-integration-tx" {
  name                = "rtp-events-tx"
  namespace_name      = "${local.project_itn}-rtp-integration-evh"
  eventhub_name       = "rtp-events"
  resource_group_name = azurerm_resource_group.rtp_rg.name
}

resource "azurerm_key_vault_secret" "ehub_rtp_connection_string" {
  name         = format("ehub-%s-tx-rtp-connection-string", var.env_short)
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-rtp-integration-tx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

data "azurerm_redis_cache" "redis_cache" {
  name                = var.redis_ha_enabled ? format("%s-%s-%s-redis", var.prefix, var.env_short, var.location_short) : format("%s-%s-redis", var.prefix, var.env_short)
  resource_group_name = format("%s-%s-data-rg", var.prefix, var.env_short)
}

resource "azurerm_key_vault_secret" "redis_password" {
  name         = "redis-password"
  value        = data.azurerm_redis_cache.redis_cache.primary_access_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "redis_hostname" {
  name         = "redis-hostname"
  value        = data.azurerm_redis_cache.redis_cache.hostname
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "rtp_storage_account_connection_string" {
  name         = "rtp-storage-account-connection-string"
  value        = module.gpd_rtp_sa.primary_connection_string
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
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

# ##############################
# apiconfig-cache product subkey
# ##############################
data "azurerm_api_management_product" "apiconfig_cache_product" {
  product_id          = "apiconfig-cache"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}
resource "azurerm_api_management_subscription" "apiconfig_cache_subkey" {
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  product_id    = data.azurerm_api_management_product.apiconfig_cache_product.id
  display_name  = "apiconfig-cache-api-key-for-gpd"
  allow_tracing = false
  state         = "active"
}
resource "azurerm_key_vault_secret" "apiconfig_cache_subkey_store_kv" {
  depends_on = [
    azurerm_api_management_subscription.apiconfig_cache_subkey
  ]
  name         = "gpd-${var.env_short}-config-cache-subscription-key"
  value        = azurerm_api_management_subscription.apiconfig_cache_subkey.primary_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}