####################
## Local variables #
####################

locals {
  apim_gpd_reporting_analysis_api = {
    published             = true
    subscription_required = true
    approval_required     = false
    subscriptions_limit   = 1000
  }
}

##############
## Products ##
##############

module "apim_gpd_reporting_analysis_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "product-gpd-reporting"
  display_name = "GPD Reporting Analysis pagoPA"
  description  = "Prodotto GPD Reporting Analysis"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = local.apim_gpd_reporting_analysis_api.published
  subscription_required = local.apim_gpd_reporting_analysis_api.subscription_required
  approval_required     = local.apim_gpd_reporting_analysis_api.approval_required
  subscriptions_limit   = local.apim_gpd_reporting_analysis_api.subscriptions_limit

  policy_xml = file("./api_product/reporting-analysis/_base_policy.xml")
}

##############
##    API   ##
##############

resource "azurerm_api_management_api_version_set" "api_gpd_reporting_analysis_api" {

  name                = format("%s-api-gpd-reporting-analysis-api", var.env_short)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "GPD Reporting Analysis"
  versioning_scheme   = "Segment"
}


module "apim_api_gpd_reporting_analysis_api" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-api-gpd-reporting-analysis-api", var.env_short)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_gpd_reporting_analysis_product.product_id, module.apim_gpd_integration_product.product_id]
  subscription_required = local.apim_gpd_reporting_analysis_api.subscription_required
  api_version           = "v1"
  version_set_id        = azurerm_api_management_api_version_set.api_gpd_reporting_analysis_api.id
  service_url           = format("https://%s", module.reporting_analysis_function.default_hostname)

  description  = "Api GPD Reporting Analysis"
  display_name = "GPD Reporting Analysis pagoPA"
  path         = "gpd-reporting/api"
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/reporting-analysis/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/reporting-analysis/v1/_base_policy.xml", {
    origin = format("https://%s.%s.%s", var.cname_record_name, var.apim_dns_zone_prefix, var.external_domain)
  })
}
