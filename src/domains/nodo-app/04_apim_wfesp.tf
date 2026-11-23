# ##############
# ## Products ##
# ##############
#
# module "apim_wfesp_product" {
#   source = "./.terraform/modules/__v3__/api_management_product"
#
#   product_id   = "wfesp"
#   display_name = "WFESP for NDP"
#   description  = "WFESP for NDP"
#
#   api_management_name = local.pagopa_apim_name
#   resource_group_name = local.pagopa_apim_rg
#
#   published             = true
#   subscription_required = false
#   approval_required     = false
#   subscriptions_limit   = 0
#
#   policy_xml = file("./api_product/wfesp-service/_base_policy.xml")
# }
#
# ########################
# ##    WFESP  NDP    ##
# ########################
# locals {
#   apim_wfesp_service_api = {
#     display_name          = "WFESP for NDP"
#     description           = "API WFESP for NDP"
#     path                  = "wfesp-ndp/service"
#     subscription_required = false
#     service_url           = null
#   }
# }
#
# resource "azurerm_api_management_api_version_set" "api_wfesp_api" {
#
#   name                = format("%s-wfesp-service-api", var.env_short)
#   resource_group_name = local.pagopa_apim_rg
#   api_management_name = local.pagopa_apim_name
#   display_name        = local.apim_wfesp_service_api.display_name
#   versioning_scheme   = "Segment"
# }
#
#
# module "apim_api_wfesp_api_v1" {
#   source = "./.terraform/modules/__v3__/api_management_api"
#
#   name                  = format("%s-wfesp-service-api", local.project)
#   api_management_name   = local.pagopa_apim_name
#   resource_group_name   = local.pagopa_apim_rg
#   product_ids           = [module.apim_wfesp_product.product_id]
#   subscription_required = local.apim_wfesp_service_api.subscription_required
#   version_set_id        = azurerm_api_management_api_version_set.api_wfesp_api.id
#   api_version           = "v1"
#
#   description  = local.apim_wfesp_service_api.description
#   display_name = local.apim_wfesp_service_api.display_name
#   path         = local.apim_wfesp_service_api.path
#   protocols    = ["https"]
#   service_url  = local.apim_wfesp_service_api.service_url
#
#   content_format = "openapi"
#   content_value = templatefile("./api/wfesp-service/v1/_WFESP.openapi.json.tpl", {
#     host = local.apim_hostname
#   })
#
#   xml_content = templatefile("./api/wfesp-service/v1/_base_policy.xml", {
#     hostname = local.nodo_hostname
#   })
# }
