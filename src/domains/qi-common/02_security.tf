resource "azurerm_resource_group" "sec_rg" {
  name     = "${local.product}-${var.domain}-sec-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "key_vault" {
  source = "./.terraform/modules/__v4__/key_vault"


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
  # count = var.env_short != "p" ? 1 : 0
  count = 1

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

## ad group policy ##
resource "azurerm_key_vault_access_policy" "adgroup_operation_policy" {
  # count = var.env_short != "p" ? 1 : 0
  count = 1

  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_operations.object_id

  key_permissions     = ["Get", "List", "Update", "Create", "Import", "Delete", "Encrypt", "Decrypt"]
  secret_permissions  = ["Get", "List", "Set", "Delete", ]
  storage_permissions = []
  certificate_permissions = [
    "Get", "List", "Update", "Create", "Import",
    "Delete", "Restore", "Purge", "Recover"
  ]
}
## ad group policy ##
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

# data "azuread_service_principal" "pipe_principal" {
#   count        = var.enable_iac_pipeline ? 1 : 0
#   display_name = format("pagopaspa-pagoPA-projects-%s", data.azurerm_subscription.current.subscription_id)
# }

# resource "azurerm_key_vault_access_policy" "azdevops_pipe_policy" {
#   count        = var.enable_iac_pipeline ? 1 : 0
#   key_vault_id = module.key_vault.id
#   tenant_id    = data.azurerm_client_config.current.tenant_id
#   object_id    = data.azuread_service_principal.pipe_principal[0].object_id

#   secret_permissions      = ["Get", "List", "Set", ]
#   certificate_permissions = ["SetIssuers", "DeleteIssuers", "Purge", "List", "Get"]
#   key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", "Encrypt", "Decrypt"]

#   storage_permissions = []
# }

################
##   Secrets  ##
################

resource "azurerm_key_vault_secret" "ai_connection_string" {
  name         = format("ai-%s-connection-string", var.env_short)
  value        = data.azurerm_application_insights.application_insights.connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

// SWITCHns02ns04
resource "azurerm_key_vault_secret" "ehub_alert_qi_rx_connection_string" {
  name         = format("ehub-%s-rx-qi-alert-connection-string", var.env_short)
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns04_quality-improvement-alerts_pagopa-qi-alert-rx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

// SWITCHns02ns04
resource "azurerm_key_vault_secret" "ehub_alert_qi_tx_connection_string" {
  name         = format("ehub-%s-tx-qi-alert-connection-string", var.env_short)
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns04_quality-improvement-alerts_pagopa-qi-alert-tx.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

// SWITCHns02ns04
resource "azurerm_key_vault_secret" "ehub_alert_qi_rx_pdnd_connection_string" {
  name         = format("ehub-%s-rx-qi-alert-pdnd-connection-string", var.env_short)
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns04_quality-improvement-alerts_pagopa-qi-alert-rx-pdnd.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

// SWITCHns02ns04
resource "azurerm_key_vault_secret" "ehub_alert_qi_rx_debug_connection_string" {
  name         = format("ehub-%s-rx-qi-alert-debug-connection-string", var.env_short)
  value        = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns04_quality-improvement-alerts_pagopa-qi-alert-rx-debug.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "qi_azurewebjobsstorage" {
  name         = format("qi-%s-azurewebjobsstorage", var.env_short)
  value        = module.qi_fn_sa.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

# create json letsencrypt inside kv
# requierd: Docker
module "letsencrypt_qi" {
  source = "./.terraform/modules/__v4__/letsencrypt_credential"

  prefix            = var.prefix
  env               = var.env_short
  key_vault_name    = "${local.product}-${var.domain}-kv"
  subscription_name = local.subscription_name
}

### TODO migrate in SOPS
resource "azurerm_key_vault_secret" "azure_data_explorer_re_client_id" {
  name         = "azure-data-explorer-re-client-id"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  content_type = "text/plain"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

### TODO migrate in SOPS
resource "azurerm_key_vault_secret" "azure_data_explorer_re_application_key" {
  name         = "azure-data-explorer-re-application-key"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  content_type = "text/plain"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

### TODO migrate in SOPS
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

### observability bdi secrets
resource "azurerm_key_vault_secret" "bdi_kpi_ingestion_dl_evt_tx_key" {
  name         = "evh-tx-bdi-kpi-key"
  value        = module.eventhub_qi_configuration.keys["bdi-kpi-ingestion-dl.bdi-kpi-ingestion-dl-evt-tx"].primary_key
  key_vault_id = module.key_vault.id
}
