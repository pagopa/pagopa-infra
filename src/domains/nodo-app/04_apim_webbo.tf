# ##############
# ## Products ##
# ##############
#
# module "apim_web_bo_product" {
#   source = "./.terraform/modules/__v3__/api_management_product"
#
#   product_id   = "web_bo"
#   display_name = "Web BO (BackOffice) for NDP"
#   description  = "Web BO (BackOffice) for NDP"
#
#   api_management_name = local.pagopa_apim_name
#   resource_group_name = local.pagopa_apim_rg
#
#   published             = true
#   subscription_required = false
#   approval_required     = false
#   subscriptions_limit   = 0
#
#   policy_xml = file("./api_product/web-bo-service/_base_policy.xml")
# }
#
# ####################################
# ##    Web BO (BackOffice)  NDP    ##
# ####################################
# locals {
#   apim_web_bo_service_api = {
#     display_name          = "Web BO (BackOffice) for NDP"
#     description           = "API Web BO (BackOffice) for NDP"
#     path                  = "web-bo-ndp"
#     subscription_required = false
#     service_url           = null
#   }
# }
#
# /*
# resource "azurerm_api_management_api_version_set" "api_web_bo_api" {
#   name                = format("%s-web-bo-service-api", var.env_short)
#   resource_group_name = local.pagopa_apim_rg
#   api_management_name = local.pagopa_apim_name
#   display_name        = local.apim_web_bo_service_api.display_name
#   versioning_scheme   = "Segment"
# }
# */
#
# module "apim_api_web_bo_api_v1" {
#   source = "./.terraform/modules/__v3__/api_management_api"
#
#   name                  = format("%s-web-bo-service-api", local.project)
#   api_management_name   = local.pagopa_apim_name
#   resource_group_name   = local.pagopa_apim_rg
#   product_ids           = [module.apim_web_bo_product.product_id]
#   subscription_required = local.apim_web_bo_service_api.subscription_required
#   #version_set_id        = azurerm_api_management_api_version_set.api_web_bo_api.id
#   #api_version           = "v1"
#
#   description  = local.apim_web_bo_service_api.description
#   display_name = local.apim_web_bo_service_api.display_name
#   path         = local.apim_web_bo_service_api.path
#   protocols    = ["https"]
#   service_url  = local.apim_web_bo_service_api.service_url
#
#   content_format = "openapi"
#   content_value = templatefile("./api/web-bo-service/v1/_web-bo.openapi.json.tpl", {
#     host = local.apim_hostname
#   })
#
#   xml_content = templatefile("./api/web-bo-service/v1/_base_policy.xml", {
#     hostname            = local.nodo_hostname
#     dns_pagopa_platform = format("api.%s.%s", var.apim_dns_zone_prefix, var.external_domain)
#     apim_base_path      = "/web-bo-ndp"
#   })
#
# }
