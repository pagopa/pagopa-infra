# This product groups each API called by node
module "apim_wisp_soap_converter_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v5.1.0"

  product_id   = local.wisp_soap_converter.product_id
  display_name = local.wisp_soap_converter.display_name
  description  = local.wisp_soap_converter.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = local.wisp_soap_converter.subscription_required
  approval_required     = local.wisp_soap_converter.approval_required
  subscriptions_limit   = local.wisp_soap_converter.subscription_limit

  policy_xml = file("./api_product/wisp_soap_converter/_base_policy.xml")
}

