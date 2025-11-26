##############
## Products ##
##############

module "apim_qi_fdr_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "qi-fdr-kpi"
  display_name = "QI FDR KPI pagoPA"
  description  = "Product for Quality Improvement FDR KPI pagoPA"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

############################
## API qi fdr kpi service ##
############################
locals {
  apim_pagopa_qi_fdr_kpi_service_api = {
    display_name          = "pagoPA QI - FDR KPI service API"
    description           = "API for retrieving FdR (Flusso di Rendicontazione) KPI metrics for both PSPs and PSP Brokers."
    path                  = "qi/fdr-kpi-service"
    subscription_required = true
    service_url           = null
  }
}

# qi fdr kpi service APIs
resource "azurerm_api_management_api_version_set" "pagopa_qi_fdr_kpi_service_api" {
  name                = "${local.project}-fdr-kpi-service-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_pagopa_qi_fdr_kpi_service_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pagopa_qi_fdr_kpi_service_api" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.project}-fdr-kpi-service-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_qi_fdr_product.product_id]
  subscription_required = local.apim_pagopa_qi_fdr_kpi_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pagopa_qi_fdr_kpi_service_api.id
  api_version           = "v1"

  description  = local.apim_pagopa_qi_fdr_kpi_service_api.description
  display_name = local.apim_pagopa_qi_fdr_kpi_service_api.display_name
  path         = local.apim_pagopa_qi_fdr_kpi_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_pagopa_qi_fdr_kpi_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/qi-fdr-kpi-api/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/qi-fdr-kpi-api/v1/_base_policy.xml.tpl", {
    hostname = local.qi_hostname
  })
}
