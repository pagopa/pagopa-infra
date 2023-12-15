resource "azurerm_resource_group" "pagopa_logic_app" {
  name     = format("%s-logic-app-rg", local.project)
  location = var.location

  tags = var.tags
}

module "logic_app_biz_evt_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.90"
  name                                           = format("%s-logicapp-biz-evt-snet", local.project)
  address_prefixes                               = var.cidr_subnet_logicapp_biz_evt
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet.name
  enforce_private_link_endpoint_network_policies = true

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]
  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "logic_app_biz_evt_sa" {
  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v2.0.28"

  name                       = replace(format("%s-logic-app-biz-evt-sa", local.project), "-", "")
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  account_replication_type   = var.logic_app_storage_account_replication_type
  access_tier                = "Hot"
  versioning_name            = "versioning"
  enable_versioning          = false
  resource_group_name        = azurerm_resource_group.pagopa_logic_app.name
  location                   = var.location
  advanced_threat_protection = false
  allow_blob_public_access   = false

  tags = var.tags
}

resource "azurerm_app_service_plan" "logic_app_biz_evt_service_plan" {
  name                = format("%s-plan-logic-app-biz-evt", local.project)
  location            = var.location
  resource_group_name = azurerm_resource_group.pagopa_logic_app.name
  kind                = "elastic"

  sku {
    tier = "WorkflowStandard"
    size = "WS1"
  }
  tags = var.tags
}

resource "azurerm_logic_app_standard" "logic_app_biz_evt" {
  name                       = format("%s-logic-app-biz-evt", local.project)
  location                   = var.location
  resource_group_name        = azurerm_resource_group.pagopa_logic_app.name
  app_service_plan_id        = azurerm_app_service_plan.logic_app_biz_evt_service_plan.id
  storage_account_name       = module.logic_app_biz_evt_sa.name
  storage_account_access_key = module.logic_app_biz_evt_sa.primary_access_key

  site_config {
    vnet_route_all_enabled = true
  }

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME = "node"
    # FUNCTIONS_EXTENSION_VERSION  = "~4"
    WEBSITE_NODE_DEFAULT_VERSION = "~14"
    # eventHub_connectionString    = "Endpoint=sb://pagopa-d-evh-ns01.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=5lRq3MbZcPWw1tl2c7ytnHEcR5mIN7F9wc81rV20vo4="
    eventHub_connectionString = module.event_hub01.keys["nodo-dei-pagamenti-biz-evt.pagopa-biz-evt-rx"].primary_connection_string
  }
  version = "~4"

  // Logic app declaration from docs
  identity {
    type = "SystemAssigned"
  }
}


# vnet integration
resource "azurerm_app_service_virtual_network_swift_connection" "logic_app_virtual_network_swift_connection" {
  app_service_id = azurerm_logic_app_standard.logic_app_biz_evt.id
  subnet_id      = module.logic_app_biz_evt_snet.id
}
