##############
## Products ##
##############
module "apim_wisp_converter_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v5.1.0"

  product_id   = "pagopa-wisp-converter"
  display_name = "WISP Converter"
  description  = "API set for WISP dismantling"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = false
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

resource "azurerm_api_management_product_group" "access_control_developers_for_wisp_converter" {
  product_id          = module.apim_wisp_converter_product.product_id
  group_name          = data.azurerm_api_management_group.group_developers.name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}


############################################
## WISP Converter - Decoupler caching API ##
############################################

resource "azurerm_api_management_api_version_set" "api_version_set_wisp_converter_decoupler_caching" {
  name                = "${var.prefix}-${var.env_short}-${var.location_short}-wisp-converter-decoupler-caching"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "WISP Converter - Decoupler caching"
  versioning_scheme   = "Segment"
}

module "wisp_converter_decoupler_caching_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.7.0"

  name                  = format("%s-wisp-converter-decoupler-caching-api", var.env_short)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_wisp_converter_product.product_id]
  subscription_required = true

  version_set_id = azurerm_api_management_api_version_set.api_version_set_wisp_converter_decoupler_caching.id
  api_version    = "v1"

  description  = "API for caching data for decoupler in WISP Converter"
  display_name = "WISP Converter - Decoupler caching"
  path         = "wisp-converter-decoupler/api"
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/wisp-converter-decoupler-caching/v1/openapi.json", {
    host = "api.${var.apim_dns_zone_prefix}.${var.external_domain}"
  })

  xml_content = templatefile("./api/wisp-converter-decoupler-caching/v1/_base_policy.xml", {})
}

