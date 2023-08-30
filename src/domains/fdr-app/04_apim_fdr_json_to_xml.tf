##############
## Products ##
##############

module "apim_fdr_json_to_xml_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.3.0"

  product_id   = "fdr_json_to_xml"
  display_name = "FDR - JSON to XML API REST"
  description  = "Manage FDR ( aka \"StService\" )"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/fdr-json-to-xml/_base_policy.xml")
}

#################
##    API fdr  ##
#################
locals {
  apim_fdr_json_to_xml_service_api = {
    display_name          = "FDR - JSON to XML API REST"
    description           = "FDR - JSON to XML API REST"
    path                  = "fdr-json-to-xml/service"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_fdr_json_to_xml_api" {

  name                = "${var.env_short}-fdr-json-to-xml-service-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_fdr_json_to_xml_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_fdr_json_to_xml_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.3.0"

  name                  = "${local.project}-fdr-json-to-xml-service-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_fdr_json_to_xml_product.product_id]
  subscription_required = local.apim_fdr_json_to_xml_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_fdr_json_to_xml_api.id
  api_version           = "v1"

  description  = local.apim_fdr_json_to_xml_service_api.description
  display_name = local.apim_fdr_json_to_xml_service_api.display_name
  path         = local.apim_fdr_json_to_xml_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_fdr_json_to_xml_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/fdr-json-to-xml/v1/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = module.apim_fdr_json_to_xml_product.product_id
  })

  xml_content = templatefile("./api/fdr-json-to-xml/v1/_base_policy.xml.tpl", {
    hostname = local.hostnameAzFunctionJsonToXml
  })
}
