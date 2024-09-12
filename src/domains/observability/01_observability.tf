# Data Explorer
# https://learn.microsoft.com/en-us/azure/data-explorer/ingest-data-event-hub
# https://learn.microsoft.com/it-it/azure/data-explorer/grafana

resource "azurerm_kusto_cluster" "data_explorer_cluster" {
  count = var.dexp_params.enabled ? 1 : 0

  name                = replace(format("%sdataexplorer", local.project_legacy), "-", "")
  location            = data.azurerm_resource_group.monitor_rg.location
  resource_group_name = data.azurerm_resource_group.monitor_rg.name

  auto_stop_enabled           = false
  streaming_ingestion_enabled = true

  sku {
    name     = var.dexp_params.sku.name
    capacity = var.dexp_params.sku.capacity
  }

  dynamic "optimized_auto_scale" {
    for_each = var.dexp_params.autoscale.enabled ? [1] : []

    content {
      minimum_instances = var.dexp_params.autoscale.min_instances
      maximum_instances = var.dexp_params.autoscale.max_instances
    }
  }

  identity {
    type = "SystemAssigned"
  }

  public_network_access_enabled = var.dexp_params.public_network_access_enabled
  double_encryption_enabled     = var.dexp_params.double_encryption_enabled
  engine                        = "V3"

  tags = var.tags

  lifecycle {
    ignore_changes = [
      tags,
      sku
    ]
  }
}

resource "azurerm_kusto_database" "re_db" {
  count = var.dexp_db.enable ? 1 : 0

  name                = "re"
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
  location            = azurerm_kusto_cluster.data_explorer_cluster[count.index].location
  cluster_name        = azurerm_kusto_cluster.data_explorer_cluster[count.index].name

  hot_cache_period   = var.dexp_db.hot_cache_period
  soft_delete_period = var.dexp_db.soft_delete_period

}


data "azurerm_eventhub" "pagopa-evh-ns03_nodo-dei-pagamenti-re_nodo-dei-pagamenti-re" {
  name                = "nodo-dei-pagamenti-re"
  resource_group_name = "${local.product}-msg-rg"
  namespace_name      = "${local.product}-${var.location_short}-core-evh-ns03"
}

resource "azurerm_kusto_eventhub_data_connection" "eventhub_connection_for_re_event" {
  count               = var.dexp_db.enable ? 1 : 0
  name                = "dataexp-${var.env_short}-connection"
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
  location            = azurerm_kusto_cluster.data_explorer_cluster[count.index].location
  cluster_name        = azurerm_kusto_cluster.data_explorer_cluster[count.index].name
  database_name       = azurerm_kusto_database.re_db[0].name

  eventhub_id    = data.azurerm_eventhub.pagopa-evh-ns03_nodo-dei-pagamenti-re_nodo-dei-pagamenti-re.id
  consumer_group = "nodo-dei-pagamenti-oper"

  table_name        = "ReEvent"
  mapping_rule_name = "ReMapping"
  data_format       = "JSON"

  identity_id = azurerm_kusto_cluster.data_explorer_cluster[count.index].id
}

# resource "azurerm_kusto_script" "create_tables" {

#   count = var.dexp_re_db_linkes_service.enable ? 1 : 0

#   name        = "CreateTables"
#   database_id = azurerm_kusto_database.re_db[count.index].id

#   script_content                     = file("scripts/create_tables.dexp")
#   continue_on_errors_enabled         = true
#   force_an_update_when_value_changed = "v6" # change this version to re-execute the script
# }
