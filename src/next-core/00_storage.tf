data "azurerm_storage_account" "fdr_flows_sa" {
  name                = replace("${local.product}-fdr-flows-sa", "-", "")
  resource_group_name = data.azurerm_resource_group.data.name
}

data "azurerm_storage_container" "fdr_rend_flow" {
  name                 = "${data.azurerm_storage_account.fdr_flows_sa.name}xmlfdrflow"
  storage_account_name = data.azurerm_storage_account.fdr_flows_sa.name
}
