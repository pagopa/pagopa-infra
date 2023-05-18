data "azurerm_resource_group" "sec_rg" {
  name = format("%s-sec-rg", local.product)
}

data "azurerm_key_vault" "key_vault" {
  name                = format("%s-kv", local.parent_project)
  resource_group_name = data.azurerm_resource_group.sec_rg.name
}
