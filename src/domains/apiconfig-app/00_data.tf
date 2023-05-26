data "azuread_application" "apiconfig-fe" {
  display_name = format("pagopa-%s-apiconfig-fe", var.env_short)
}

data "azuread_application" "apiconfig-be" {
  display_name = format("pagopa-%s-apiconfig-be", var.env_short)
}

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

data "azurerm_api_management" "apim" {
  name                = "${local.product}-apim"
  resource_group_name = "${local.product}-api-rg"
}

locals {
  global_project = format("%s-%s", var.prefix, var.env_short)
}


data "azurerm_container_registry" "container_registry" {
  name                = replace(format("%s-common-acr", local.global_project), "-", "")
  resource_group_name = format("%s-container-registry-rg", local.global_project)
}

data "azurerm_subnet" "apim_snet" {
  name                 = format("%s-apim-snet", local.global_project)
  resource_group_name  = format("%s-vnet-rg", local.global_project)
  virtual_network_name = format("%s-vnet-integration", local.global_project)
}


data "azurerm_private_dns_a_record" "private_dns_a_record_db_nodo" {
  name                = "db-nodo-pagamenti"
  zone_name           = var.private_dns_zone_db_nodo_pagamenti
  resource_group_name = "pagopa-d-data-rg"
}

data "azurerm_private_dns_zone" "db_nodo_dns_zone" {
  name                = var.private_dns_zone_db_nodo_pagamenti
  resource_group_name = "pagopa-d-data-rg"
}
