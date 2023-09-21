##############
## Products ##
##############

module "apim_fdr_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.3.0"

  product_id   = "fdr"
  display_name = "FDR - Flussi di rendicontazione"
  description  = "Manage FDR ( aka \"Flussi di Rendicontazione\" ) exchanged between PSP and EC"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/fdr-service/_base_policy.xml")
}

module "apim_fdr_product_internal" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.3.0"

  product_id   = "fdr_internal"
  display_name = "FDR - (INTERNAL) Flussi di rendicontazione"
  description  = "Manage FDR (INTERNAL) ( aka \"Flussi di Rendicontazione\" ) exchanged between PSP and EC"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/fdr-service-internal/_base_policy.xml")
}

#################
##    API fdr  ##
#################
locals {
  apim_fdr_service_api = {
    display_name          = "FDR - Flussi di rendicontazione"
    description           = "FDR - Flussi di rendicontazione"
    path                  = "fdr/service"
    subscription_required = true
    service_url           = null
  }
  apim_fdr_service_api_internal = {
    display_name          = "FDR - (INTERNAL) Flussi di rendicontazione"
    description           = "FDR - (INTERNAL) Flussi di rendicontazione"
    path                  = "fdr/service-internal"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_fdr_api" {
  name                = "${var.env_short}-fdr-service-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_fdr_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_fdr_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.3.0"

  name                  = "${local.project}-fdr-service-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_fdr_product.product_id]
  subscription_required = local.apim_fdr_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_fdr_api.id
  api_version           = "v1"

  description  = local.apim_fdr_service_api.description
  display_name = local.apim_fdr_service_api.display_name
  path         = local.apim_fdr_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_fdr_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/fdr-service/v1/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = module.apim_fdr_product.product_id
  })

  xml_content = templatefile("./api/fdr-service/v1/_base_policy.xml.tpl", {
    hostname = local.hostname
  })
}

resource "azurerm_api_management_api_version_set" "api_fdr_api_internal" {

  name                = "${var.env_short}-fdr-service-api-internal"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_fdr_service_api_internal.display_name
  versioning_scheme   = "Segment"
}

module "apim_api_fdr_api_v1_internal" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.3.0"

  name                  = "${local.project}-fdr-service-api-internal"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_fdr_product_internal.product_id]
  subscription_required = local.apim_fdr_service_api_internal.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_fdr_api_internal.id
  api_version           = "v1"

  description  = local.apim_fdr_service_api_internal.description
  display_name = local.apim_fdr_service_api_internal.display_name
  path         = local.apim_fdr_service_api_internal.path
  protocols    = ["https"]
  service_url  = local.apim_fdr_service_api_internal.service_url

  content_format = "openapi"
  content_value = templatefile("./api/fdr-service-internal/v1/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = module.apim_fdr_product.product_id
  })

  xml_content = templatefile("./api/fdr-service-internal/v1/_base_policy.xml.tpl", {
    hostname = local.hostname
  })
}

resource "azurerm_api_management_named_value" "fdrcontainername" {
  name                = "fdrcontainername"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "fdrcontainername"
  value               = data.azurerm_storage_container.fdr_rend_flow.name
}

resource "azurerm_api_management_named_value" "fdrsaname" {
  name                = "fdrsaname"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "fdrsaname"
  value               = data.azurerm_storage_account.fdr_flows_sa.name
}
