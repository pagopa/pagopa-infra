locals {
  apim_gpd_payments_helpdesk_api = {
    display_name          = "GPD Payments pagoPA - Helpdesk"
    description           = "Helpdesk APIs for GPD Payments"
    path                  = "gpd-payments-helpdesk"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_gpd_payments_helpdesk" {
  name                = "${var.env_short}-gpd-payments-helpdesk-api"
  resource_group_name = local.apim.rg
  api_management_name = local.apim.name
  display_name        = local.apim_gpd_payments_helpdesk_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_api_gpd_payments_helpdesk_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v4.git//api_management_api?ref=v10.22.0"

  name                  = "${local.project}-gpd-payments-helpdesk-api"
  api_management_name   = local.apim.name
  resource_group_name   = local.apim.rg
  product_ids           = [data.azurerm_api_management_product.gpd_payments_helpdesk_product.product_id]
  subscription_required = local.apim_gpd_payments_helpdesk_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_gpd_payments_helpdesk.id
  api_version           = "v1"

  description  = local.apim_gpd_payments_helpdesk_api.description
  display_name = local.apim_gpd_payments_helpdesk_api.display_name
  path         = local.apim_gpd_payments_helpdesk_api.path
  protocols    = ["https"]
  service_url  = local.apim_gpd_payments_helpdesk_api.service_url

  content_format = "openapi"
  content_value = jsonencode(merge(
    jsondecode(file("../openapi/helpdesk/openapi.json")),
    {
      servers = [
        {
          url = "https://${local.apim_hostname}/gpd-payments-helpdesk/v1"
        }
      ]
    }
  ))

  xml_content = templatefile("./policy/_base_policy.xml", {
    hostname = local.hostname
  })
}