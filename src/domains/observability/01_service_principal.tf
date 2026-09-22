resource "azuread_application" "celonis_adx_reader" {
  display_name = "sp-${local.project}-celonis-adx-reader"
}

resource "azuread_service_principal" "celonis_adx_reader_sp" {
  client_id = azuread_application.celonis_adx_reader.client_id
}

resource "time_rotating" "celonis_application" {
  rotation_days = 300
}

resource "azuread_application_password" "celonis_adx_secret" {
  application_id = azuread_application.celonis_adx_reader.id
  display_name   = "celonis-read-access-secret"
  rotate_when_changed = {
    rotation = time_rotating.celonis_application.id
  }
}

resource "azurerm_kusto_database_principal_assignment" "celonis_db_viewer" {
  name                = "celonis-viewer-assignment"
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
  cluster_name        = azurerm_kusto_cluster.data_explorer_cluster[0].name
  database_name       = azurerm_kusto_database.public_re_db[0].name

  tenant_id      = data.azurerm_client_config.current.tenant_id
  principal_id   = azuread_service_principal.celonis_adx_reader_sp.client_id
  principal_type = "App"
  role           = "Viewer"
}

resource "azurerm_key_vault_secret" "celonis_service_principal_client_id" {
  name         = "celonis-client-id"
  value        = azuread_application.celonis_adx_reader.client_id
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "celonis_service_principal_client_secret" {
  name         = "celonis-client-secret"
  value        = azuread_application_password.celonis_adx_secret.value
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}


