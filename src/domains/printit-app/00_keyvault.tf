data "azurerm_key_vault" "kv" {
  name                = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}-kv"
  resource_group_name = "${var.prefix}-${var.env_short}-${var.domain}-sec-rg"
}

data "azurerm_key_vault_secret" "elastic_otel_token_header" {
  name         = "elastic-apm-secret-token"
  key_vault_id = data.azurerm_key_vault.kv.id
}

# data "azurerm_key_vault_secret" "pdf_engine_node_subkey" {
#   name         = "pdf-engine-node-subkey"
#   key_vault_id = data.azurerm_key_vault.kv.id
# }


data "azurerm_kubernetes_cluster" "aks" {
  name                = local.aks_name
  resource_group_name = local.aks_resource_group_name
}

locals {
  aks_api_url = var.env_short == "d" ? data.azurerm_kubernetes_cluster.aks.fqdn : data.azurerm_kubernetes_cluster.aks.private_fqdn
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "aks_apiserver_url" {
  name         = "${local.aks_name}-apiserver-url"
  value        = "https://${local.aks_api_url}:443"
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}
