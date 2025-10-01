###################################
##      ACA UPLOAD POLICY      ####
###################################

resource "azurerm_api_management_api_version_set" "apim_aca_upload_api" {
  name                = "${var.env_short}-aca-upload-api"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = local.apim_aca_upload_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_aca_upload_api_v2" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.product}-aca-upload-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_aca_product.product_id]
  subscription_required = local.apim_aca_upload_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_aca_upload_api.id
  api_version           = "v2"

  description  = local.apim_aca_upload_api.description
  display_name = local.apim_aca_upload_api.display_name
  path         = local.apim_aca_upload_api.path
  protocols    = ["https"]
  service_url  = "${local.apim_aca_upload_api.service_url}/v2"

  content_format = "openapi"
  content_value  = file("./../gps-app/api/gpd-upload-service/v2/_openapi_v2.json")

  xml_content = templatefile("./../gps-app/api/gpd-upload-service/v2/_base_policy.xml", {
    service_type_value = "ACA"
  })
}
