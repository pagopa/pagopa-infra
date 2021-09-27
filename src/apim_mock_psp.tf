##############
## Products ##
##############

module "apim_mock_psp_product" {
  count  = var.mock_psp_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.16"

  product_id   = "product-mock-psp"
  display_name = "product-mock-psp"
  description  = "product-mock-psp"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/mockpsp_api/_base_policy.xml")
}

##############
##    API   ##
##############

module "apim_mock_psp_api" {
  count  = var.mock_psp_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-mock-psp-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_mock_psp_product[0].product_id]
  subscription_required = true

  description  = "mock psp api"
  display_name = "mock psp api"
  path         = "mock-psp/api"
  protocols    = ["https"]

  service_url = format("https://%s/mockPspService", module.mock_psp[0].default_site_hostname)

  content_format = "openapi"
  content_value = templatefile("./api/mockpsp_api/v1/_openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/mockpsp_api/v1/_base_policy.xml")
}


##############
## WEB VIEW ##
##############

module "apim_mock_psp_webview" {
  count  = var.mock_psp_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-mock-psp-webview", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_mock_psp_product[0].product_id]
  subscription_required = false

  description  = "mock psp webview"
  display_name = "mock psp webview"
  path         = "mock-psp/webview"
  protocols    = ["https"]

  service_url = format("https://%s/mockPspWebview", module.mock_psp[0].default_site_hostname)
  
  content_format = "openapi"
  content_value = templatefile("./api/mockpsp_webview/v1/_openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/mockpsp_webview/v1/_base_policy.xml")
}