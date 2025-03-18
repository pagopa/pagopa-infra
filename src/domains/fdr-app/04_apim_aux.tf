// Switch to pagoPA FdR SOAP request for Orgs (creditor institutions)
// https://pagopa.atlassian.net/wiki/spaces/IQCGJ/pages/1071153182/FdR-1+Flussi+di+Rendicontazione
resource "azurerm_api_management_named_value" "enable_fdr_ci_soap_request" {
  name                = "enable-fdr-ci-soap-request-switch"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  display_name        = "enable-fdr-ci-soap-request-switch"
  value               = var.enable_fdr_ci_soap_request
}

// Switch to pagoPA FdR SOAP request for PSP
// https://pagopa.atlassian.net/wiki/spaces/IQCGJ/pages/1071153182/FdR-1+Flussi+di+Rendicontazione
resource "azurerm_api_management_named_value" "enable_fdr_psp_soap_request" {
  name                = "enable-fdr-psp-soap-request-switch"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  display_name        = "enable-fdr-psp-soap-request-switch"
  value               = var.enable_fdr_psp_soap_request
}

// PSP list to switch traffic towards pagoPA FdR
resource "azurerm_api_management_named_value" "fdr_psp_soap_request_psp_list" {
  name                = "fdr-soap-request-psp-whitelist"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  display_name        = "fdr-soap-request-psp-whitelist"
  value               = var.fdr_soap_request_psp_whitelist
}

// CI list to switch traffic towards pagoPA FdR
resource "azurerm_api_management_named_value" "fdr_ci_soap_request_ci_list" {
  name                = "fdr-soap-request-ci-whitelist"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  display_name        = "fdr-soap-request-ci-whitelist"
  value               = var.fdr_soap_request_ci_whitelist
}

########################
##  Info for FdR Rend ##
########################
resource "azurerm_api_management_named_value" "fdrcontainername" {
  name                = "fdrcontainername"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "fdrcontainername"
  value               = data.azurerm_storage_container.fdr_rend_flow.name
}

resource "azurerm_api_management_named_value" "fdrsaname" {
  name                = "fdrsaname"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "fdrsaname"
  value               = data.azurerm_storage_account.fdr_flows_sa.name
}
