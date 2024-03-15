data "azurerm_container_registry" "container_registry" {
  name                = replace("${local.product}-common-acr", "-", "")
  resource_group_name = "${local.product}-container-registry-rg"
}
