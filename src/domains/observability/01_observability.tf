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

  tags = module.tag_config.tags

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

resource "azurerm_kusto_database" "pm_db" {
  count = var.dexp_pm_db.enable ? 1 : 0

  name                = "pm"
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
  location            = azurerm_kusto_cluster.data_explorer_cluster[count.index].location
  cluster_name        = azurerm_kusto_cluster.data_explorer_cluster[count.index].name

  hot_cache_period   = var.dexp_pm_db.hot_cache_period
  soft_delete_period = var.dexp_pm_db.soft_delete_period

  lifecycle {
    prevent_destroy = true
  }

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

#pagopa-evh-ns04_nodo-dei-pagamenti-negative-awakable-biz-evt_pagopa-biz-evt-tx

data "azurerm_eventhub" "pagopa-evh-ns04_nodo-dei-pagamenti-fdr-qi-flows" {
  name                = "fdr-qi-flows"
  resource_group_name = "${local.product}-msg-rg"
  namespace_name      = "${local.product}-${var.location_short}-core-evh-ns04"
}

resource "azurerm_kusto_eventhub_data_connection" "eventhub_connection_for_ingestion_qi_fdr" {
  count               = var.dexp_db.enable ? 1 : 0
  name                = "dataexp-${var.env_short}-ingestion-qi-fdr"
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
  location            = azurerm_kusto_cluster.data_explorer_cluster[count.index].location
  cluster_name        = azurerm_kusto_cluster.data_explorer_cluster[count.index].name
  database_name       = azurerm_kusto_database.re_db[0].name

  eventhub_id    = data.azurerm_eventhub.pagopa-evh-ns04_nodo-dei-pagamenti-fdr-qi-flows.id
  consumer_group = "fdr-qi-flows-rx"

  table_name        = "FLUSSI_RENDICONTAZIONE"
  mapping_rule_name = "IngestionFlussiEH"
  data_format       = "JSON"

  identity_id = azurerm_kusto_cluster.data_explorer_cluster[count.index].id
}

resource "azurerm_role_assignment" "fdr_qi_flow_data_evh_data_receiver_role" {
  count = var.dexp_db.enable ? 1 : 0

  scope                = data.azurerm_eventhub.pagopa-evh-ns04_nodo-dei-pagamenti-fdr-qi-flows.id # evh
  role_definition_name = "Azure Event Hubs Data Receiver"
  principal_id         = azurerm_kusto_cluster.data_explorer_cluster[count.index].identity[count.index].principal_id # data-exp
}


data "azurerm_eventhub" "pagopa-evh-ns04_nodo-dei-pagamenti-fdr-qi-fdr-iuvs" {
  name                = "fdr-qi-reported-iuv"
  resource_group_name = "${local.product}-msg-rg"
  namespace_name      = "${local.product}-${var.location_short}-core-evh-ns04"
}

resource "azurerm_kusto_eventhub_data_connection" "eventhub_connection_for_ingestion_qi_iuvs" {
  count               = var.dexp_db.enable ? 1 : 0
  name                = "dataexp-${var.env_short}-ingestion-qi-iuvs"
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
  location            = azurerm_kusto_cluster.data_explorer_cluster[count.index].location
  cluster_name        = azurerm_kusto_cluster.data_explorer_cluster[count.index].name
  database_name       = azurerm_kusto_database.re_db[0].name

  eventhub_id    = data.azurerm_eventhub.pagopa-evh-ns04_nodo-dei-pagamenti-fdr-qi-fdr-iuvs.id
  consumer_group = "fdr-qi-reported-iuv-rx"

  table_name        = "IUV_RENDICONTATI"
  mapping_rule_name = "IngestionIuvEH"
  data_format       = "JSON"

  identity_id = azurerm_kusto_cluster.data_explorer_cluster[count.index].id
}


resource "azurerm_role_assignment" "fdr_qi_fdr_iuvs_data_evh_data_receiver_role" {
  count = var.dexp_db.enable ? 1 : 0

  scope                = data.azurerm_eventhub.pagopa-evh-ns04_nodo-dei-pagamenti-fdr-qi-fdr-iuvs.id # evh
  role_definition_name = "Azure Event Hubs Data Receiver"
  principal_id         = azurerm_kusto_cluster.data_explorer_cluster[count.index].identity[count.index].principal_id # data-exp
}

# resource "azurerm_kusto_script" "create_tables" {

#   count = var.dexp_re_db_linkes_service.enable ? 1 : 0

#   name        = "CreateTables"
#   database_id = azurerm_kusto_database.re_db[count.index].id

#   script_content                     = file("scripts/create_tables.dexp")
#   continue_on_errors_enabled         = true
#   force_an_update_when_value_changed = "v6" # change this version to re-execute the script
# }


data "azuread_group" "adgroup_developers" {
  display_name = "${local.product}-adgroup-developers"
}
data "azuread_group" "adgroup_externals" {
  display_name = "${local.product}-adgroup-externals"
}
data "azuread_group" "adgroup_operations" {
  display_name = "${local.product}-adgroup-operations"
}
data "azuread_group" "adgroup_technical_project_managers" {
  display_name = "${local.product}-adgroup-technical-project-managers"
}

locals {
  # How to share an Azure Managed Grafana instance
  # https://learn.microsoft.com/en-us/azure/managed-grafana/how-to-share-grafana-workspace#assign-an-admin-viewer-or-editor-role-to-a-user

  grafana_admins = [
    data.azuread_group.adgroup_developers.id,
  ]

  grafana_editors = [
    data.azuread_group.adgroup_technical_project_managers.id,
  ]

  grafana_viewers = [
    data.azuread_group.adgroup_operations.id,
    data.azuread_group.adgroup_externals.id,
  ]
}


locals {
  dataexp_contributor_groups = [
    data.azuread_group.adgroup_technical_project_managers.id,
    data.azuread_group.adgroup_operations.id,
    data.azuread_group.adgroup_externals.id,
  ]

}
resource "azurerm_role_assignment" "adgroup_dataexp_reader" {
  for_each = toset(local.dataexp_contributor_groups)

  scope                = azurerm_kusto_cluster.data_explorer_cluster[0].id
  role_definition_name = "Reader"
  principal_id         = each.key
}
# resource "azurerm_role_assignment" "adgroup_dataexp_contributor" {
#   for_each = toset(local.dataexp_contributor_groups)

#   scope                = azurerm_kusto_cluster.data_explorer_cluster.id
#   role_definition_name = "Contributor"
#   principal_id         = each.key
# }