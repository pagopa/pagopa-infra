data "azurerm_key_vault" "kv_core" {
  name                = "${local.project}-kv"
  resource_group_name = "${local.project}-sec-rg"
}