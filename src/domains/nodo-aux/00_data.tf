data "azurerm_log_analytics_workspace" "log_analytics" {
  name                = var.log_analytics_workspace_name
  resource_group_name = var.log_analytics_workspace_resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = local.vnet_resource_group_name
}

data "azurerm_resource_group" "rg_vnet" {
  name = local.vnet_resource_group_name
}

data "azurerm_key_vault" "kv" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = "${local.product}-${var.domain}-sec-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns03_nodo-dei-pagamenti-re_observability" {
  name                = "nodo-dei-pagamenti-observability"
  namespace_name      = "${local.product}-${var.location_short}-core-evh-ns03"
  eventhub_name       = "nodo-dei-pagamenti-re"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_subnet" "private_endpoint_snet" {
  name                 = "${local.product}-common-private-endpoint-snet"
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
}

data "azurerm_private_dns_zone" "privatelink_blob_azure_com" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = local.vnet_resource_group_name
}

data "azurerm_api_management" "apim" {
  name                = "${var.prefix}-${var.env_short}-apim"
  resource_group_name = "${var.prefix}-${var.env_short}-api-rg"
}

data "azurerm_api_management_user" "pagoapa_core_user" {
  user_id             = "pagopa-core-usr"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
}

data "azurerm_api_management_product" "apim_nodo_monitoring_product" {
  product_id          = "nodo-monitoring"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
}

data "azurerm_api_management_product" "apim_apiconfig_auth_product" {
  product_id          = "product-api-config-auth"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
}