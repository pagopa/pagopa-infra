resource "azurerm_resource_group" "pagopa_logic_app" {
  name     = format("%s-logic-app-rg", local.project)
  location = var.location

  tags = var.tags
}

module "logic_app_biz_evt_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
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

# module "logic_app_biz_evt_sa" {
#   source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v2.0.13"

#   name                       = replace(format("%s-logic-app-biz-evt-sa", local.project), "-", "")
#   account_kind               = "StorageV2"
#   account_tier               = "Standard"
#   account_replication_type   = "LRS"
#   access_tier                = "Hot"
#   versioning_name            = "versioning"
#   enable_versioning          = false
#   resource_group_name        = azurerm_resource_group.pagopa_logic_app.name
#   location                   = var.location
#   advanced_threat_protection = false
#   allow_blob_public_access   = false

#   tags = var.tags
# }

# # resource "azurerm_storage_account" "logic_app_biz_evt_sa" {
# #   name                     = replace(format("%s-logic-app-biz-evt-sa", local.project), "-", "")
# #   resource_group_name      = azurerm_resource_group.pagopa_logic_app.name
# #   location                 = var.location
# #   account_tier             = "Standard"
# #   account_replication_type = "LRS"
# # }


# # resource "azurerm_app_service_plan" "logic_app_biz_evt_service_plan" {
# #   name                = format("%s-plan-logic-app-biz-evt", local.project)
# #   location            = var.location
# #   resource_group_name = azurerm_resource_group.pagopa_logic_app.name


# #   kind     = var.logic_app_biz_evt_plan_kind
# #   reserved = var.logic_app_biz_evt_plan_kind == "Linux" ? true : false

# #   sku {
# #     tier = var.logic_app_biz_evt_plan_sku_tier
# #     size = var.logic_app_biz_evt_plan_sku_size
# #   }

# #   tags = var.tags
# # }


# resource "azurerm_app_service_plan" "logic_app_biz_evt_service_plan" {
#   name                = format("%s-plan-logic-app-biz-evt", local.project)
#   location            = var.location
#   resource_group_name = azurerm_resource_group.pagopa_logic_app.name
#   kind                = "Linux"
#   reserved            = true

#   sku {
#     tier = "WorkflowStandard"
#     size = "WS1"
#   }
#   tags = var.tags
# }

# resource "azurerm_logic_app_standard" "logic_app_biz_evt" {
#   name                       = format("%s-logic-app-biz-evt", local.project)
#   location                   = var.location
#   resource_group_name        = azurerm_resource_group.pagopa_logic_app.name
#   app_service_plan_id        = azurerm_app_service_plan.logic_app_biz_evt_service_plan.id
#   storage_account_name       = module.logic_app_biz_evt_sa.name
#   storage_account_access_key = module.logic_app_biz_evt_sa.primary_access_key

#   # // Logic app declaration from docs 
#   # identity {
#   #     type = "SystemAssigned"
#   #   }
# }


# # vnet integration
# resource "azurerm_app_service_virtual_network_swift_connection" "logic_app_virtual_network_swift_connection" {
#   app_service_id = azurerm_logic_app_standard.logic_app_biz_evt.id
#   subnet_id      = module.logic_app_biz_evt_snet.id
# }

# # resource "azurerm_role_assignment" "logic_app_biz_evt_role_ass" {
# #   scope                = module.logic_app_biz_evt_sa.id
# #   role_definition_name = "Storage Blob Data Owner"
# #   principal_id         = azurerm_logic_app_standard.logic_app_biz_evt.identity[0].principal_id
# # }