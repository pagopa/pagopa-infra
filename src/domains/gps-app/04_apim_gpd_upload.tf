##############
# GPD UPLOAD #
##############

locals {

  ## GPD-UPLOAD API ##
  apim_gpd_upload_api = {
    display_name          = "GPD Upload pagoPA - Massive Upload"
    description           = "API to support Debt Positions massive upload for organizations"
    path                  = "gpd/upload/debt-positions-service"
    subscription_required = true
    service_url           = var.env == "prod" ? "https://weu${var.env}.gps.internal.platform.pagopa.it/pagopa-gpd-upload" : "https://weu${var.env}.gps.internal.${var.env}.platform.pagopa.it/pagopa-gpd-upload"
  }
}


## API ##
resource "azurerm_api_management_api_version_set" "apim_gpd_upload_api" {
  name                = "${var.env_short}-gpd-upload-api"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = local.apim_gpd_upload_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_gpd_upload_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.product}-gpd-upload-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_debt_positions_product.product_id, module.apim_gpd_integration_product.product_id]
  subscription_required = local.apim_gpd_upload_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_gpd_upload_api.id
  api_version           = "v1"

  description  = local.apim_gpd_upload_api.description
  display_name = local.apim_gpd_upload_api.display_name
  path         = local.apim_gpd_upload_api.path
  protocols    = ["https"]
  service_url  = local.apim_gpd_upload_api.service_url

  content_format = "openapi"
  content_value = file("./api/gpd-upload-service/v1/_openapi_v1.json")

  xml_content = templatefile("./api/gpd-upload-service/v1/_base_policy.xml", {
    service_type_value = "GPD"
  })
}

module "apim_gpd_upload_api_v2" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.product}-gpd-upload-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_debt_positions_product.product_id, module.apim_gpd_integration_product.product_id]
  subscription_required = local.apim_gpd_upload_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_gpd_upload_api.id
  api_version           = "v2"

  description  = local.apim_gpd_upload_api.description
  display_name = local.apim_gpd_upload_api.display_name
  path         = local.apim_gpd_upload_api.path
  protocols    = ["https"]
  service_url  = "${local.apim_gpd_upload_api.service_url}/v2"

  content_format = "openapi"
  content_value = file("./api/gpd-upload-service/v2/_openapi_v2.json")

  xml_content = templatefile("./api/gpd-upload-service/v2/_base_policy.xml", {
    service_type_value = "GPD"
  })
}
