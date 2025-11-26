##############
## Products ##
##############

module "apim_qi_observability_bdi_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "qi-observability_bdi"
  display_name = "KPI OBSERVABILTY FOR BDI"
  description  = "API Product for Banca d'Italia surveillance"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

#######################################
## API qi performance kpi monitoring ##
#######################################
locals {
  apim_pagopa_qi_observability_perf_kpi_api = {
    display_name          = "pagoPA QI - Performance kpi for BDI"
    description           = "API for collecting and monitoring performance KPIs fro BDI"
    path                  = "qi/perf-kpi-bdi"
    subscription_required = true
    service_url           = null
  }
}

# qi performance kpi monitoring APIs
resource "azurerm_api_management_api_version_set" "pagopa_qi_performnace_kpi_moitoring_service_api" {
  name                = "${local.project}-performance-kpi-monitoring-service-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_pagopa_qi_observability_perf_kpi_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pagopa_qi_observability_perf_kpi_api" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.project}-performance-kpi-monitoring-service-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_qi_observability_bdi_product.product_id]
  subscription_required = local.apim_pagopa_qi_observability_perf_kpi_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pagopa_qi_performnace_kpi_moitoring_service_api.id
  api_version           = "v1"

  description  = local.apim_pagopa_qi_observability_perf_kpi_api.description
  display_name = local.apim_pagopa_qi_observability_perf_kpi_api.display_name
  path         = local.apim_pagopa_qi_observability_perf_kpi_api.path
  protocols    = ["https"]
  service_url  = local.apim_pagopa_qi_observability_perf_kpi_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/qi-observability-perf-kpi/v1/_openapi.yaml.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/qi-observability-perf-kpi/v1/_base_policy.xml.tpl", {
    hostname = local.qi_hostname
  })
}
