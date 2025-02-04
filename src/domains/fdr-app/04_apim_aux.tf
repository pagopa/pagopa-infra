// Switch to pagoPA FdR SOAP request for Orgs
resource "azurerm_api_management_named_value" "enable_fdr_org_soap_request" {
  name                = "enable-fdr-org-soap-request-switch"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  display_name        = "enable-fdr-org-soap-request-switch"
  value               = var.enable_fdr_org_soap_request
}

// Switch to pagoPA FdR SOAP request for PSP
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
