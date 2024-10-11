# decoupler named values

# named value containing primitive names for routing algorithm
resource "azurerm_api_management_named_value" "node_decoupler_primitives" {
  name                = "node-decoupler-primitives"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "node-decoupler-primitives"
  value               = var.node_decoupler_primitives
}


resource "azurerm_api_management_named_value" "nexi_nodo_address" {
  name                = "nexi-nodo-address"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "nexi-nodo-address"
  value               = var.nexi_nodo_address
}

resource "azurerm_api_management_named_value" "nexi_nodo_pg_address" {
  name                = "nexi-nodo-pg-address"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "nexi-nodo-pg-address"
  value               = var.nexi_nodo_pg_address
}

resource "azurerm_api_management_named_value" "pagopa_nodo_address" {
  name                = "pagopa-nodo-address"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "pagopa-nodo-address"
  value               = var.nexi_nodo_pg_address
}

resource "azurerm_api_management_named_value" "nexi_nodo_weight" {
  name                = "nexi-nodo-weight"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "nexi-nodo-weight"
  value               = var.nexi_nodo_weight
}

resource "azurerm_api_management_named_value" "pagopa_nodo_weight" {
  name                = "pagopa-nodo-weight"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "pagopa-nodo-weight"
  value               = var.pagopa_nodo_weight
}
resource "azurerm_api_management_named_value" "nexi_pg_nodo_weight" {
  name                = "nexi-pg-nodo-weight"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "nexi-pg-nodo-weight"
  value               = var.nexi_pg_nodo_weight
}

resource "azurerm_api_management_named_value" "nexi_nodo_priority" {
  name                = "nexi-nodo-priority"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "nexi-nodo-priority"
  value               = var.nexi_nodo_priority
}

resource "azurerm_api_management_named_value" "pagopa_nodo_priority" {
  name                = "pagopa-nodo-priority"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "pagopa-nodo-priority"
  value               = var.pagopa_nodo_priority
}
resource "azurerm_api_management_named_value" "nexi_pg_nodo_priority" {
  name                = "nexi-pg-nodo-priority"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "nexi-pg-nodo-priority"
  value               = var.nexi_pg_nodo_priority
}
