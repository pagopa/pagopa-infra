##############
## Products ##
##############

module "apim_advanced_fees_management_product" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.84"

  product_id   = "product-afm"
  display_name = "Advanced Fees Management - Marketplace"
  description  = "Prodotto Gestione Evoluta delle Commissioni - Marketplace"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/afm_api/_base_policy.xml")
}

##############
##    API   ##
##############

resource "azurerm_api_management_api_version_set" "api_afm_marketplace_api" {
  count  = var.env_short == "d" ? 1 : 0

  name                = format("%s-api-afm-marketplace-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "Gestione Evoluta delle Commissioni - Marketplace"
  versioning_scheme   = "Segment"
}

module "apim_api_afm_marketplace_api" {
  count  = var.env_short == "d" ? 1 : 0

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.1.13"

  name                  = format("%s-api-afm-marketplace-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_advanced_fees_management_product[0].product_id]
  subscription_required = false
  api_version           = "v1"
  version_set_id        = azurerm_api_management_api_version_set.api_afm_marketplace_api[0].id
  service_url           = format("https://%s", module.advanced_fees_management_app_service[0].default_site_hostname)

  description  = "API marketplace Gestione Evoluta delle Commissioni"
  display_name = "AFM-Marketplace"
  path         = "afm-marketplace/api"
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/afm_api/marketplace/v1/_openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/afm_api/marketplace/v1/_base_policy.xml.tpl", {})
}
