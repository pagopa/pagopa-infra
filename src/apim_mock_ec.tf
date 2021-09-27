##############
## Products ##
##############

module "mock_ec_product" {
  count  = var.mock_ec_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.16"

  product_id   = "product-mock-ec"
  display_name = "product-mock-ec"
  description  = "product-mock-ec"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/mockec_api/_base_policy.xml")
}

module "mock_ec_api" {
  count  = var.mock_ec_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-api-mock-ec", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.mock_ec_product[0].product_id]
  subscription_required = false

  description  = "mock ec api"
  display_name = "mock ec api"
  path         = "mock-ec/api"
  protocols    = ["https"]

  service_url = format("https://%s/mockEcService", module.mock_ec[0].default_site_hostname)

  content_value = templatefile("./api/mockec_api/v1/_swagger.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/mockec_api/v1/_base_policy.xml")
}
