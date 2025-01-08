##############
## Products ##
##############

module "apim_pdf_engine_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "pdf-engine"
  display_name = "PDF Engine pagoPA"
  description  = "PDF Engine pagoPA"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

#########################
##  API PDF ENGINE  ##
#########################
locals {
  apim_pdf_engine_service_api = { # java
    display_name          = "PDF Engine Service pagoPA - API"
    description           = "PDF Engine Service pagoPA - API"
    path                  = "shared/pdf-engine"
    subscription_required = true
    service_url           = module.shared_pdf_engine_app_service_java[0].default_site_hostname
  }
  apim_pdf_engine_node_service_api = { # node
    display_name          = "PDF Engine Node Service pagoPA - API"
    description           = "PDF Engine Node Service pagoPA - API"
    path                  = "shared/pdf-engine-node"
    subscription_required = true
    service_url           = module.shared_pdf_engine_app_service[0].default_site_hostname
  }
}

###################
# java
###################

resource "azurerm_api_management_api_version_set" "api_pdf_engine_api" {

  name                = format("%s-pdf-engine-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_pdf_engine_service_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_api_pdf_engine_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-pdf-engine-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_pdf_engine_product.product_id]
  subscription_required = local.apim_pdf_engine_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_pdf_engine_api.id
  api_version           = "v1"

  description  = local.apim_pdf_engine_service_api.description
  display_name = local.apim_pdf_engine_service_api.display_name
  path         = local.apim_pdf_engine_service_api.path
  protocols    = ["https"]
  service_url  = null

  content_format = "openapi"
  content_value = templatefile("./api/pdf-engine/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/pdf-engine/v1/_base_policy.xml", {
    hostname = local.apim_pdf_engine_service_api.service_url
  })
}

###################
# node
###################

resource "azurerm_api_management_api_version_set" "api_pdf_engine_node_api" {

  name                = format("%s-pdf-engine-node-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_pdf_engine_node_service_api.display_name
  versioning_scheme   = "Segment"
}
module "apim_api_pdf_engine_node_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-pdf-engine-node-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_pdf_engine_product.product_id]
  subscription_required = local.apim_pdf_engine_node_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_pdf_engine_node_api.id
  api_version           = "v1"

  description  = local.apim_pdf_engine_node_service_api.description
  display_name = local.apim_pdf_engine_node_service_api.display_name
  path         = local.apim_pdf_engine_node_service_api.path
  protocols    = ["https"]
  service_url  = null


  content_format = "openapi"
  content_value = templatefile("./api/pdf-engine-node/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/pdf-engine-node/v1/_base_policy.xml", {
    hostname = local.apim_pdf_engine_node_service_api.service_url
  })
}

