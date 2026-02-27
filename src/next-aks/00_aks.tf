data "azurerm_resource_group" "aks_rg" {
  name = "${local.project}-aks-rg"
}

data "azurerm_kubernetes_cluster" "weu_aks" {
  name                = local.aks_name
  resource_group_name = "${local.project}-aks-rg"
}


data "kubernetes_all_namespaces" "all_ns" {}


