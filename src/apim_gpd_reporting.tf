##############
## Products ##
##############

module "apim_gpd_reporting_analysis_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.84"

  product_id   = "product-gpd-reporting"
  display_name = "GPD Reporting Analysis pagoPA"
  description  = "Prodotto GPD Reporting Analysis"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/gpd/reporting_analysis/_base_policy.xml")
}

##############
##    API   ##
##############

resource "azurerm_api_management_api_version_set" "api_gpd_reporting_analysis_api" {

  name                = format("%s-api-gpd-reporting-analysis-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "GPD Reporting Analysis"
  versioning_scheme   = "Segment"
}


module "apim_api_gpd_reporting_analysis_api" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.1.13"

  name                  = format("%s-api-gpd-reporting-analysis-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_gpd_reporting_analysis_product.product_id]
  subscription_required = false
  api_version           = "v1"
  version_set_id        = azurerm_api_management_api_version_set.api_gpd_reporting_analysis_api.id
  service_url           = format("https://%s", module.reporting_analysis_function.default_hostname)

  description  = "Api GPD Reporting Analysis"
  display_name = "GPD Reporting Analysis pagoPA"
  path         = "gpd-reporting/api"
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/gpd_api/reporting_analysis/v1/_openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/gpd_api/reporting_analysis/v1/_base_policy.xml", {
    origin = format("https://%s.%s.%s", var.cname_record_name, var.dns_zone_prefix, var.external_domain)
  })
}
