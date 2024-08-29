data "azurerm_key_vault" "kv_italy" {
  name                = local.kv_italy_name
  resource_group_name = local.kv_italy_rg_name
}
