##############
## Products ##
##############

module "apim_printit_cie_product" {
  source = "./.terraform/modules/__v4__/api_management_product"

  product_id   = "printit-cie"
  display_name = "Stampa Avvisi for CIE"
  description  = "All API required for CIE Stampa Avvisi"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

locals {
  apim_pdf_engine_service_cie_api = {
    # java
    display_name          = "PDF Engine Service for CIE Stampa Avvisi"
    description           = "PDF Engine Service for CIE Stampa Avvisi - API"
    path                  = "printit/cie/pdf-engine"
    subscription_required = true
    service_url           = can(module.printit_pdf_engine_app_service_java[0].default_site_hostname) ? module.printit_pdf_engine_app_service_java[0].default_site_hostname : ""
  }
  apim_api_config_cie_api = {
    # java
    display_name          = "Api Config for CIE Stampa Avvisi"
    description           = "Api Config for CIE Stampa Avvisi - API"
    path                  = "printit/cie/api-config"
    subscription_required = true
    service_url           = null
  }
}

###################
# PDF Engine java - CIE
###################

resource "azurerm_api_management_api_version_set" "api_pdf_engine_cie_api" {
  name                = "${var.env_short}-pdf-engine-service-api-for-cie-notice"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_pdf_engine_service_cie_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_api_pdf_engine_cie_api_v1" {
  source = "./.terraform/modules/__v4__/api_management_api"

  name                  = "${local.project}-pdf-engine-service-cie-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_printit_cie_product.product_id]
  subscription_required = local.apim_pdf_engine_service_cie_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_pdf_engine_cie_api.id
  api_version           = "v1"

  description  = local.apim_pdf_engine_service_cie_api.description
  display_name = local.apim_pdf_engine_service_cie_api.display_name
  path         = local.apim_pdf_engine_service_cie_api.path
  protocols    = ["https"]
  service_url  = null

  content_format = "openapi"
  content_value = templatefile("./api/pdf-engine/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/pdf-engine/v1/_base_policy.xml", {
    hostname = local.apim_pdf_engine_service_cie_api.service_url
  })
}

###################
# Api Config - CIE
###################

resource "azurerm_api_management_api_version_set" "api_config_cie_api" {
  name                = "${var.env_short}-api-config-api-for-cie-notice"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_api_config_cie_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_api_config_cie_api_v1" {
  source = "./.terraform/modules/__v4__/api_management_api"

  name                  = "${local.project}-api_config-cie-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_printit_cie_product.product_id]
  subscription_required = local.apim_api_config_cie_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_config_cie_api.id
  api_version           = "v1"

  description  = local.apim_api_config_cie_api.description
  display_name = local.apim_api_config_cie_api.display_name
  path         = local.apim_api_config_cie_api.path
  protocols    = ["https"]
  service_url  = null

  content_format = "openapi"
  content_value = templatefile("./api/api-config-cie/v1/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = module.apim_printit_cie_product.product_id
  })

  xml_content = templatefile("./api/api-config-cie/v1/_base_policy.xml.tpl", {
    hostname = var.env == "prod" ? "weuprod.apiconfig.internal.platform.pagopa.it" : "weu${var.env}.apiconfig.internal.${var.env}.platform.pagopa.it"
  })
}
