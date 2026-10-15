data "azurerm_kusto_cluster" "dexp_cluster" {
  count = var.dexp_re_db_linkes_service.enable ? 1 : 0

  name                = replace(format("%sdataexplorer", local.product), "-", "")
  resource_group_name = var.monitor_resource_group_name
}

data "azurerm_kusto_database" "re_db" {
  count = var.dexp_re_db_linkes_service.enable ? 1 : 0

  name                = "re"
  resource_group_name = var.monitor_resource_group_name
  cluster_name        = data.azurerm_kusto_cluster.dexp_cluster[count.index].name
}

resource "azurerm_kusto_script" "create_tables" {

  count = var.dexp_re_db_linkes_service.enable ? 1 : 0

  name        = "CreateTables"
  database_id = data.azurerm_kusto_database.re_db[count.index].id

  script_content             = file("scripts/create_adx_nrt_tables.dexp")
  continue_on_errors_enabled = true
}