data "azurerm_key_vault" "key_vault" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = "${local.product}-${var.domain}-sec-rg"
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "db_nodo_cfg_login" {
  name         = "db-nodo-cfg-login"
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "db_nodo_cfg_login_password" {
  name         = "db-nodo-cfg-login-password"
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "db_nodo_cfg_login" {
  name         = "db-nodo-cfg-login"
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
resource "azurerm_key_vault_secret" "db_nodo_cfg_login_password" {
  name         = "db-nodo-cfg-login-password"
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}
