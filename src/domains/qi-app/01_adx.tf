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

resource "azurerm_kusto_script" "create_table" {

  count = var.dexp_re_db_linkes_service.enable ? 1 : 0

  name        = "CreateTable"
  database_id = data.azurerm_kusto_database.re_db[count.index].id

  script_content             = file("scripts/create_table_observ_bdi.dexp")
  continue_on_errors_enabled = true

  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_script#arguments-reference
  # should be useful use sha of scripts/create_table_observ_bdi.dexp and use it as value of `force_an_update_when_value_changed`
  # force_an_update_when_value_changed = "v6" 
}