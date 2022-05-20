data "azurerm_kubernetes_cluster" "aks" {
  name                = local.aks_name
  resource_group_name = local.aks_resource_group_name
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "aks_apiserver_url" {
  name         = "${local.aks_name}-apiserver-url"
  value        = "https://${data.azurerm_kubernetes_cluster.aks.private_fqdn}:443"
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}
