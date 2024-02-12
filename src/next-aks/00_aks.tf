data "azurerm_resource_group" "aks_rg" {
  name = "${local.project}-aks-rg"
}
