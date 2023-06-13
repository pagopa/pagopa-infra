data "azurerm_cosmosdb_account" "mongo_ndp_re_account" {
  name                = "${local.project}-cosmos-account"
  resource_group_name = "${local.project}-db-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns01_nodo-dei-pagamenti-re-ndp_nodo-dei-pagamenti-re-to-datastore-rx" {
  name                = "${var.prefix}-re-to-datastore-rx"
  namespace_name      = "${local.product}-evh-ns01"
  eventhub_name       = "nodo-dei-pagamenti-re-ndp"
  resource_group_name = "${local.product}-msg-rg"
}

resource "azurerm_resource_group" "nodo_re_to_datastore_rg" {
  name     = format("%s-re-to-datastore-rg", local.project)
  location = var.location

  tags = var.tags
}

resource "azurerm_service_plan" "nodo_re_to_datastore_service_plan" {
  name                = format("%s-nodo-re-to-datastore", local.project)
  location            = var.location
  resource_group_name = azurerm_resource_group.nodo_re_to_datastore_rg.name
  sku_name            = var.nodo_re_to_datastore_function.sku_name
  os_type             = var.nodo_re_to_datastore_function.os_type

  tags = var.tags
}



locals {
  function_re_to_datastore_settings = {
    FUNCTIONS_WORKER_RUNTIME = "java"
    // Keepalive fields are all optionals
    FETCH_KEEPALIVE_ENABLED             = "true"
    FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
    FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
    FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
    FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
    FETCH_KEEPALIVE_TIMEOUT             = "60000"

    EVENTHUB_CONN_STRING = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns01_nodo-dei-pagamenti-re-ndp_nodo-dei-pagamenti-re-to-datastore-rx.primary_key
    COSMOS_CONN_STRING   = data.azurerm_cosmosdb_account.mongo_ndp_re_account.primary_key
  }
}

output "COSMOS_CONN_STRING" {
  value     = data.azurerm_cosmosdb_account.mongo_ndp_re_account.primary_key
  sensitive = false
}

## Function reporting_batch
module "nodo_re_to_datastore_function" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app?ref=v6.9.0"

  resource_group_name = azurerm_resource_group.nodo_re_to_datastore_rg.name
  name                = replace("${local.project}nodo-re-to-datastore", "gps", "")
  location            = var.location
  health_check_path   = "/api/info"
  subnet_id           = module.nodo_re_to_datastore_function_snet.id
  runtime_version     = "~4"
  storage_account_info = {
    account_kind                      = "StorageV2"
    account_tier                      = "Standard"
    account_replication_type          = "LRS"
    access_tier                       = "Hot"
    advanced_threat_protection_enable = true
  }
  always_on                                = var.nodo_re_to_datastore_function_always_on
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key
  app_service_plan_id                      = azurerm_service_plan.nodo_re_to_datastore_service_plan.id
  app_settings                             = local.function_re_to_datastore_settings

  allowed_subnets = []
  allowed_ips     = []


  tags = var.tags

  depends_on = [
    azurerm_service_plan.nodo_re_to_datastore_service_plan
  ]
}
