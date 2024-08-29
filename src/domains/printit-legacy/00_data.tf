#
# KV
#
data "azurerm_key_vault" "kv_printit" {
  name                = "${local.project}-kv"
  resource_group_name = "${local.project}-sec-rg"
}

#
# Storage
#
data "azurerm_storage_account" "notices" {
  name                = replace("${local.project_short}-notices", "-", "")
  resource_group_name = "${local.project}-pdf-rg"
}

