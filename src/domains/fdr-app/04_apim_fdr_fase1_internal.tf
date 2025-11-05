locals {
  apim_fdr_nodo_service_api_internal = {
    display_name          = "FDR Fase1- (INTERNAL) Flussi di rendicontazione"
    description           = "FDR Fase1- (INTERNAL) Flussi di rendicontazione"
    path                  = "fdr-nodo/service-internal"
    subscription_required = true
    subscriptions_limit   = 1000
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_fdr_nodo_api_internal" {

  name                = "${var.env_short}-fdr-nodo-service-api-internal"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_fdr_nodo_service_api_internal.display_name
  versioning_scheme   = "Segment"
}

module "apim_api_fdr_nodo_api_v1_internal" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.project}-fdr-nodo-service-api-internal"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_fdr_product_internal.product_id]
  subscription_required = local.apim_fdr_nodo_service_api_internal.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_fdr_nodo_api_internal.id
  api_version           = "v1"

  description  = local.apim_fdr_nodo_service_api_internal.description
  display_name = local.apim_fdr_nodo_service_api_internal.display_name
  path         = local.apim_fdr_nodo_service_api_internal.path
  protocols    = ["https"]
  service_url  = local.apim_fdr_nodo_service_api_internal.service_url

  content_format = "openapi"
  content_value = templatefile("./api/fdr-fase1-internal/v1/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = module.apim_fdr_product_internal.product_id
  })

  xml_content = templatefile("./api/fdr-fase1-internal/v1/_base_policy.xml.tpl", {
    hostname = local.hostname
  })
}
