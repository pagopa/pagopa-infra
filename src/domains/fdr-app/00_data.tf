data "azurerm_api_management_group" "group_guests" {
  name                = "guests"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

data "azurerm_api_management_group" "group_developers" {
  name                = "developers"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

data "azurerm_resource_group" "rg_vnet" {
  name = "${local.project}-vnet-rg"
}

data "azurerm_storage_account" "fdr_flows_sa" {
  name                = replace("${local.project}-fdr-flows-sa", "-", "")
  resource_group_name = data.azurerm_resource_group.data.name
}

data "azurerm_resource_group" "data" {
  name = "${local.project}-data-rg"
}

data "azurerm_storage_container" "fdr_rend_flow" {
  name                 = "${data.azurerm_storage_account.fdr_flows_sa.name}xmlfdrflow"
  storage_account_name = data.azurerm_storage_account.fdr_flows_sa.name
}

data "azurerm_container_registry" "common-acr" {
  name                = replace("${local.project}-common-acr", "-", "")
  resource_group_name = data.azurerm_resource_group.container_registry_rg.name
}

data "azurerm_resource_group" "container_registry_rg" {
  name = "${local.project}-container-registry-rg"
}

data "azurerm_storage_container" "fdr_rend_flow_out" {
  name                 = "${data.azurerm_storage_account.fdr_flows_sa.name}xmlfdrflowout"
  storage_account_name = data.azurerm_storage_account.fdr_flows_sa.name
}

data "azurerm_subnet" "apim_snet" {
  name                 = "${local.project}-apim-snet"
  virtual_network_name = data.azurerm_virtual_network.vnet_integration.name
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
}

data "azurerm_virtual_network" "vnet_integration" {
  name                = "${local.project}-vnet-integration"
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
}

data "azurerm_eventhub" "event_hub01" {
  name                = "${local.project}-evh-ns01"
  resource_group_name = data.azurerm_resource_group.msg_rg.name
  namespace_name      = "search-eventhubns"
}

data "azurerm_eventhub_namespace" "event_hub01_namespace" {
  name                = "${local.project}-evh-ns01"
  resource_group_name = data.azurerm_resource_group.msg_rg.name
}

data "azurerm_resource_group" "msg_rg" {
  name = "${local.project}--msg-rg"
}