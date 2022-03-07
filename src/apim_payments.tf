##############
## Products ##
##############

module "apim_gpd_payments_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.84"

  product_id   = "product-gpd-payments"
  display_name = "GPD Payments pagoPA"
  description  = "Prodotto Payments gestione posizioni debitorie"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/gpd/payments/_base_policy.xml")
}

##############
##    API   ##
##############

resource "azurerm_api_management_api_version_set" "api_gpd_payments_api" {
  name                = format("%s-api-gpd-payments-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "Payments"
  versioning_scheme   = "Segment"
}


resource "azurerm_api_management_api" "apim_api_gpd_payments_api" {
  name                  = format("%s-api-gpd-payments-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  subscription_required = false
  service_url           = format("https://%s/gpd-payments/api/v1", module.payments_app_service.default_site_hostname)
  version_set_id        = azurerm_api_management_api_version_set.api_gpd_payments_api.id
  version               = "v1"
  revision              = "1"

  description  = "Api Payments per Gestione Posizione Debitorie"
  display_name = "GPD Payments pagoPA"
  path         = "gpd-payments/api"
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/gpd_api/payments/v1/paForNode.wsdl")
    wsdl_selector {
      service_name  = "paForNode_Service"
      endpoint_name = "paForNode_Port"
    }
  }
}
