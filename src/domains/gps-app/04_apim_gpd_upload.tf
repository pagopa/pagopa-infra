##############
# GPD UPLOAD #
##############

locals {

  ## GPD-UPLOAD API ##
  apim_gpd_upload_api = {
    display_name          = "GPD Upload pagoPA - Massive Upload"
    description           = "API to support Debt Positions massive upload for organizations"
    path                  = "upload/gpd/debt-positions-service"
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
  content_value = templatefile("./api/gpd-upload-service/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/gpd-upload-service/v1/_base_policy.xml", {
    service_type_value = "GPD"
  })
}