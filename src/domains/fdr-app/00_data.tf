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
  name = "${local.product}-vnet-rg"
}

data "azurerm_storage_account" "fdr_flows_sa" {
  name                = replace("${local.product}-fdr-flows-sa", "-", "")
  resource_group_name = data.azurerm_resource_group.data.name
}

data "azurerm_storage_account" "fdr_conversion_sa" {
  name                = replace("${local.project}-sa", "-", "")
  resource_group_name = data.azurerm_resource_group.fdr_rg.name
}

data "azurerm_resource_group" "data" {
  name = "${local.product}-data-rg"
}

data "azurerm_storage_container" "fdr_rend_flow" {
  name                 = "${data.azurerm_storage_account.fdr_flows_sa.name}xmlfdrflow"
  storage_account_name = data.azurerm_storage_account.fdr_flows_sa.name
}

data "azurerm_container_registry" "common-acr" {
  name                = replace("${local.product}-common-acr", "-", "")
  resource_group_name = data.azurerm_resource_group.container_registry_rg.name
}

data "azurerm_resource_group" "container_registry_rg" {
  name = "${local.product}-container-registry-rg"
}

data "azurerm_storage_container" "fdr_rend_flow_out" {
  name                 = "${data.azurerm_storage_account.fdr_flows_sa.name}xmlfdrflowout"
  storage_account_name = data.azurerm_storage_account.fdr_flows_sa.name
}

data "azurerm_subnet" "apim_snet" {
  name                 = "${local.product}-apim-snet"
  virtual_network_name = data.azurerm_virtual_network.vnet_integration.name
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
}

data "azurerm_virtual_network" "vnet_integration" {
  name                = "${local.product}-vnet-integration"
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
}


data "azurerm_eventhub_namespace" "event_hub03_namespace" {
  name                = "${local.product}-${var.location_short}-core-evh-ns03"
  resource_group_name = data.azurerm_resource_group.msg_rg.name
}


data "azurerm_eventhub_authorization_rule" "events_03" {
  name                = var.event_name
  namespace_name      = data.azurerm_eventhub_namespace.event_hub03_namespace.name
  eventhub_name       = var.eventhub_name
  resource_group_name = data.azurerm_resource_group.msg_rg.name
}

data "azurerm_resource_group" "msg_rg" {
  name = "${local.product}-msg-rg"
}

# container registry
data "azurerm_container_registry" "login_server" {
  name                = replace("${local.product}-common-acr", "-", "")
  resource_group_name = data.azurerm_resource_group.container_registry_rg.name
}

# apim
data "azurerm_api_management" "apim" {
  name                = "${local.product}-apim"
  resource_group_name = data.azurerm_resource_group.rg_api.name
}

data "azurerm_api_management_api" "apim_nodo_per_pa_api_v1" {
  name                = "${var.env_short}-nodo-per-pa-api"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  revision            = "1"
}

data "azurerm_api_management_api" "apim_nodo_per_pa_api_v1_auth" {
  name                = "${var.env_short}-nodo-per-pa-api-auth"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  revision            = "1"
}

data "azurerm_api_management_api" "apim_node_for_pa_api_v1_auth" {
  name                = "${var.env_short}-node-for-pa-api-auth"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  revision            = "1"
}

data "azurerm_api_management_api" "apim_nodo_per_psp_api_v1" {
  name                = "${var.env_short}-nodo-per-psp-api"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  revision            = "1"
}

data "azurerm_api_management_api" "apim_node_for_psp_api_v1_auth" {
  name                = "${var.env_short}-node-for-psp-api-auth"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  revision            = "1"
}

data "azurerm_api_management_api" "apim_nodo_per_psp_api_v1_auth" {
  name                = "${var.env_short}-nodo-per-psp-api-auth"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  revision            = "1"
}

data "azurerm_resource_group" "rg_api" {
  name = "${local.product}-api-rg"
}

data "azurerm_resource_group" "identity_rg" {
  name = "${local.product}-identity-rg"
}

data "azurerm_resource_group" "fdr_rg" {
  name = "${local.project}-rg"
}
