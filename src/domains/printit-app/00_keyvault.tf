data "azurerm_key_vault" "kv" {
  name                = "${local.project}-kv"
  resource_group_name = "${local.project}-sec-rg"
}

data "azurerm_key_vault_secret" "elastic_otel_token_header" {
  name         = "elastic-apm-secret-token"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = local.aks_name
  resource_group_name = local.aks_resource_group_name
}
