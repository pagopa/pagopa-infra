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

data "azuread_service_principal" "integration_runner" {
  count = var.dexp_re_db_linkes_service.enable && var.qa_integration_runner_adx_ingestion.enabled ? 1 : 0

  display_name = "${local.product}-qa-int-test-ca-job"
}

resource "azurerm_kusto_script" "create_tables" {

  count = var.dexp_re_db_linkes_service.enable ? 1 : 0

  name        = "QACreateTablesADX4NRT"
  database_id = data.azurerm_kusto_database.re_db[count.index].id

  script_content             = file("scripts/create_adx_nrt_tables.dexp")
  continue_on_errors_enabled = true
}

resource "azurerm_kusto_script" "create_staging_tables" {
  count = var.dexp_re_db_linkes_service.enable && var.qa_integration_runner_adx_ingestion.enabled ? 1 : 0

  name        = "QACreateStagingTablesADX4NRT"
  database_id = azurerm_kusto_script.create_tables[0].database_id

  script_content             = file("${path.module}/scripts/create_adx_nrt_staging_tables.dexp")
  continue_on_errors_enabled = false
}

resource "azurerm_kusto_database_principal_assignment" "integration_runner_admin" {
  count = var.dexp_re_db_linkes_service.enable && var.qa_integration_runner_adx_ingestion.enabled ? 1 : 0

  name                = "QAIntegrationRunnerNRTDatabaseAdmin"
  resource_group_name = data.azurerm_kusto_cluster.dexp_cluster[0].resource_group_name
  cluster_name        = data.azurerm_kusto_cluster.dexp_cluster[0].name
  database_name       = data.azurerm_kusto_database.re_db[0].name

  tenant_id      = data.azurerm_client_config.current.tenant_id
  principal_id   = data.azuread_service_principal.integration_runner[0].object_id
  principal_type = "App"
  role           = "Admin"
}