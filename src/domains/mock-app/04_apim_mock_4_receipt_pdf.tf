##############
## Products ##
##############

module "apim_mock_receipt_pdf" {
  count  = var.env_short != "p" ? 1 : 0
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "product-mock-receipt-pdf"
  display_name = "Mock 4 Receipt PDF"
  description  = "Mock 4 Receipt PDF"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 10

  policy_xml = file("./api_product/mock_4_receipt_pdf/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "mock_receipt_pdf" {
  count = var.env_short != "p" ? 1 : 0

  name                = format("%s-mock-receipt-pdf", var.env_short)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "Mock 4 Receipt PDF"
  versioning_scheme   = "Segment"
}

module "apim_receipt_pdf_api" {
  count  = var.env_short != "p" ? 1 : 0
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-mock-receipt-pdf", var.env_short)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_mock_receipt_pdf[0].product_id]
  subscription_required = true

  version_set_id = azurerm_api_management_api_version_set.mock_receipt_pdf[0].id
  api_version    = "v1"

  description  = "Mock 4 Receipt PDF"
  display_name = "Mock 4 Receipt PDF"
  path         = "mock-io/api" # https://api.<dev|uat>.platform.pagopa.it/mock-io/api + /v1/ + "<API(s) IO 2 mock>"
  protocols    = ["https"]

  service_url = null

  content_value = templatefile("./api/mock_4_receipt_pdf/v1/_swagger.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/mock_4_receipt_pdf/v1/_base_policy.xml", {})

}
