##############
## Products ##
##############

module "apim_fdr_xml_to_json_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.3.0"

  product_id   = "fdr_xml_to_json"
  display_name = "FDR - XML to JSON API REST"
  description  = "Manage FDR ( aka \"StService\" )"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/fdr-xml-to-json/_base_policy.xml")
}

#################
##    API fdr  ##
#################
locals {
  apim_fdr_xml_to_json_service_api = {
    display_name          = "FDR - XML to JSON API REST"
    description           = "FDR - XML to JSON API REST"
    path                  = "fdr-xml-to-json/service"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_fdr_xml_to_json_api" {

  name                = "${var.env_short}-fdr-xml-to-json-service-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_fdr_xml_to_json_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_fdr_xml_to_json_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.3.0"

  name                  = "${local.project}-fdr-xml-to-json-service-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_fdr_xml_to_json_product.product_id]
  subscription_required = local.apim_fdr_xml_to_json_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_fdr_xml_to_json_api.id
  api_version           = "v1"

  description  = local.apim_fdr_xml_to_json_service_api.description
  display_name = local.apim_fdr_xml_to_json_service_api.display_name
  path         = local.apim_fdr_xml_to_json_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_fdr_xml_to_json_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/fdr-xml-to-json/v1/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = module.apim_fdr_xml_to_json_product.product_id
  })

  xml_content = templatefile("./api/fdr-xml-to-json/v1/_base_policy.xml.tpl", {
    hostname = local.hostnameAzFunctionXmlToJson
  })
}
