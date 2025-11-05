data "azurerm_key_vault" "kv" {
  name                = "${local.project}-kv"
  resource_group_name = "${local.project}-sec-rg"
}


data "azurerm_kubernetes_cluster" "aks" {
  name                = local.aks_name
  resource_group_name = local.aks_resource_group_name
}
