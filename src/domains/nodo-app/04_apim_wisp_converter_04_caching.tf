##################################
## WISP Converter - Caching API ##
##################################

resource "azurerm_api_management_api_version_set" "api_version_set_wisp_converter_caching" {
  count = var.create_wisp_converter ? 1 : 0

  name                = "${var.prefix}-${var.env_short}-${var.location_short}-wisp-converter-caching"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "WISP Converter - Caching"
  versioning_scheme   = "Segment"
}

module "wisp_converter_caching_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"
  count  = var.create_wisp_converter ? 1 : 0

  name                  = format("%s-wisp-converter-caching-api", var.env_short)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_wisp_converter_product[0].product_id]
  subscription_required = true

  version_set_id = azurerm_api_management_api_version_set.api_version_set_wisp_converter_caching[0].id
  api_version    = "v1"

  description  = "API for caching data for decoupler in WISP Converter"
  display_name = "WISP Converter - Caching"
  path         = "wisp-converter/caching/api"
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/wisp-converter/caching/v1/openapi.json", {
    host = "api.${var.apim_dns_zone_prefix}.${var.external_domain}"
  })

  xml_content = templatefile("./api/wisp-converter/caching/v1/_base_policy.xml", {})
}

resource "azurerm_api_management_api_operation_policy" "save_mapping_api_v1" {
  api_name            = format("%s-wisp-converter-caching-api-v1", var.env_short)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  operation_id        = "saveMapping"

  xml_content = file("./api/wisp-converter/caching/v1/save_mapping_policy.xml")
}

resource "terraform_data" "sha256_save_mapping_api_v1" {
  input = sha256(file("./api/wisp-converter/caching/v1/save_mapping_policy.xml"))
}

resource "azurerm_api_management_api_operation_policy" "save_cart_mapping_api_v1" {
  api_name            = format("%s-wisp-converter-caching-api-v1", var.env_short)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  operation_id        = "saveCartMapping"

  xml_content = file("./api/wisp-converter/caching/v1/save_cart_mapping_policy.xml")
}

resource "terraform_data" "sha256_save_cart_mapping_api_v1" {
  input = sha256(file("./api/wisp-converter/caching/v1/save_cart_mapping_policy.xml"))
}


# fragment for loading configuration inside policy
# https://github.com/hashicorp/terraform-provider-azurerm/issues/17016#issuecomment-1314991599
# https://learn.microsoft.com/en-us/azure/templates/microsoft.apimanagement/2022-04-01-preview/service/policyfragments?pivots=deployment-language-terraform
resource "terraform_data" "sha256_wisp_cache_4_decoupler" {
  input = sha256(file("./api/wisp-converter/caching/v1/wisp-cache-for-decoupler.xml"))
}
resource "azapi_resource" "wisp_cache_4_decoupler" {

  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "wisp-cache-for-decoupler"
  parent_id = data.azurerm_api_management.apim.id

  body = jsonencode({
    properties = {
      description = "Cache info for decoupler about fiscalCode and noticeNumber"
      format      = "rawxml"
      value       = file("./api/wisp-converter/caching/v1/wisp-cache-for-decoupler.xml")
    }
  })

  lifecycle {
    ignore_changes = [output]
  }
}

# fragment for loading configuration inside policy
# https://github.com/hashicorp/terraform-provider-azurerm/issues/17016#issuecomment-1314991599
# https://learn.microsoft.com/en-us/azure/templates/microsoft.apimanagement/2022-04-01-preview/service/policyfragments?pivots=deployment-language-terraform
resource "terraform_data" "sha256_wisp_cache_4_decoupler_cart" {
  input = sha256(file("./api/wisp-converter/caching/v1/wisp-cache-for-decoupler-cart.xml"))
}
resource "azapi_resource" "wisp_cache_4_decoupler_cart" {

  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "wisp-cache-for-decoupler-cart"
  parent_id = data.azurerm_api_management.apim.id

  body = jsonencode({
    properties = {
      description = "Save cart mapping for decoupler"
      format      = "rawxml"
      value       = file("./api/wisp-converter/caching/v1/wisp-cache-for-decoupler-cart.xml")
    }
  })

  lifecycle {
    ignore_changes = [output]
  }
}

resource "azurerm_api_management_api_operation_policy" "delete_sessionId_api_v1" {
  api_name            = format("%s-wisp-converter-caching-api-v1", var.env_short)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  operation_id        = "deleteSessionId"

  xml_content = file("./api/wisp-converter/caching/v1/delete_sessionId_policy.xml")
}

resource "terraform_data" "sha256_delete_sessionId_api_v1" {
  input = sha256(file("./api/wisp-converter/caching/v1/delete_sessionId_policy.xml"))
}
