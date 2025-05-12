data "azurerm_key_vault" "core_kv" {
  name                = "${local.product}-kv"
  resource_group_name = "${local.product}-sec-rg"
}

data "azurerm_key_vault_secret" "apm_api_key" {
  count        = var.otel_collector_cloud_migration ? 1 : 0
  key_vault_id = data.azurerm_key_vault.core_kv.id
  name         = "otel-collector-es-api-key"
}
