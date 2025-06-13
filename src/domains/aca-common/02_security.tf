resource "azurerm_resource_group" "sec_rg" {
  name     = "${local.product}-${var.domain}-sec-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "key_vault" {
  source                     = "./.terraform/modules/__v3__/key_vault"
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

data "azurerm_api_management_product" "apim_aca_product" {
  product_id          = "aca"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

resource "azurerm_api_management_subscription" "gpd_like_for_aca_subkey" {
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  product_id    = data.azurerm_api_management_product.apim_aca_product.id
  display_name  = "Used by ACA to call GPD-Like-API"
  allow_tracing = false
  state         = "active"
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

resource "azurerm_key_vault_secret" "ai_connection_string" {
  name         = "ai-${var.env_short}-connection-string"
  value        = data.azurerm_application_insights.application_insights.connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "gpd-api-key" {
  depends_on   = [azurerm_api_management_subscription.gpd_like_for_aca_subkey]
  name         = "gpd-api-key"
  value        = azurerm_api_management_subscription.gpd_like_for_aca_subkey.primary_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "api-config-api-key" {
  name         = "api-config-api-key"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "aca-api-key" {
  count        = var.env_short != "p" ? 1 : 0
  name         = "aca-api-key"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_key_vault_secret" "aca-load-test-api-key" {
  count        = var.env_short != "p" ? 1 : 0
  name         = "aca-load-test-api-key"
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
