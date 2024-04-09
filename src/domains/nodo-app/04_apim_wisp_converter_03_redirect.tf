############################################
## WISP Converter - Decoupler caching API ##
############################################

resource "azurerm_api_management_api_version_set" "api_version_set_wisp_converter_decoupler_caching" {
  count = var.enable_wisp_converter ? 1 : 0

  name                = "${var.prefix}-${var.env_short}-${var.location_short}-wisp-converter-decoupler-caching"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "WISP Converter - Decoupler caching"
  versioning_scheme   = "Segment"
}

module "wisp_converter_decoupler_caching_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.7.0"
  count  = var.enable_wisp_converter ? 1 : 0

  name                  = format("%s-wisp-converter-decoupler-caching-api", var.env_short)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_wisp_converter_product[0].product_id]
  subscription_required = true

  version_set_id = azurerm_api_management_api_version_set.api_version_set_wisp_converter_decoupler_caching[0].id
  api_version    = "v1"

  description  = "API for caching data for decoupler in WISP Converter"
  display_name = "WISP Converter - Decoupler caching"
  path         = "wisp-converter/decoupler/api"
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/wisp-converter/decoupler/v1/openapi.json", {
    host = "api.${var.apim_dns_zone_prefix}.${var.external_domain}"
  })

  xml_content = templatefile("./api/wisp-converter/decoupler/v1/_base_policy.xml", {})
}

