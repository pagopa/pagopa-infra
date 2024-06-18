###################################
## WISP Converter - Redirect API ##
###################################

resource "azurerm_api_management_api_version_set" "api_version_set_wisp_converter_redirect" {
  count = var.enable_wisp_converter ? 1 : 0

  name                = "${var.prefix}-${var.env_short}-${var.location_short}-wisp-converter-redirect"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "WISP Converter - Redirect"
  versioning_scheme   = "Segment"
}

module "wisp_converter_redirect_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.7.0"
  count  = var.enable_wisp_converter ? 1 : 0

  name                  = format("%s-wisp-converter-redirect-api", var.env_short)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_wisp_converter_product[0].product_id]
  subscription_required = false # TODO da verificare

  version_set_id = azurerm_api_management_api_version_set.api_version_set_wisp_converter_redirect[0].id
  api_version    = "v1"

  description  = "API for redirect payments handled by WISP to eCommerce"
  display_name = "WISP Converter - Redirect"
  path         = "wisp-converter/redirect/api"
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/wisp-converter/redirect/v1/openapi.json", {
    host = "api.${var.apim_dns_zone_prefix}.${var.external_domain}/wisp-converter/redirect/api/v1"
  })

  xml_content = templatefile("./api/wisp-converter/redirect/v1/_base_policy.xml", {
    hostname = "https://${local.nodo_hostname}/pagopa-wisp-converter"
  })
}
