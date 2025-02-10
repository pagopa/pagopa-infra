##############
## Products ##
##############

#########
## PSP ##
#########

module "apim_fdr_product_psp" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "fdr-psp"
  display_name = "FDR - Flussi di rendicontazione (PSP)"
  description  = "Manage FDR (PSP) ( aka \"Flussi di Rendicontazione\" ) exchanged between PSP and EC"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = false
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/fdr-service/psp/_base_policy.xml")
}

#########
## ORG ##
#########

module "apim_fdr_product_org" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "fdr-org"
  display_name = "FDR - Flussi di rendicontazione (ORGS)"
  description  = "Manage FDR (ORGS) ( aka \"Flussi di Rendicontazione\" ) exchanged between PSP and EC"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = false
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/fdr-service/org/_base_policy.xml")
}

###############
##  INTERNAL  ##
###############

module "apim_fdr_product_internal" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "fdr_internal"
  display_name = "FDR - Flussi di rendicontazione (INTERNAL)"
  description  = "Manage FDR (INTERNAL) ( aka \"Flussi di Rendicontazione\" ) exchanged between PSP and EC"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/fdr-service-internal/_base_policy.xml")
}



###############
##  API FdR  ##
###############
locals {
  apim_fdr_psp_service_api = {
    display_name          = "FDR - Flussi di rendicontazione (PSP)"
    description           = "FDR - Flussi di rendicontazione (PSP)"
    path                  = "fdr-psp/service"
    subscription_required = true
    service_url           = null
  }

  apim_fdr_org_service_api = {
    display_name          = "FDR - Flussi di rendicontazione (ORGS)"
    description           = "FDR - Flussi di rendicontazione (ORGS)"
    path                  = "fdr-org/service"
    subscription_required = true
    service_url           = null
  }

  apim_fdr_service_api_internal = {
    display_name          = "FDR Fase 3 - Flussi di rendicontazione (INTERNAL)"
    description           = "FDR - Flussi di rendicontazione (INTERNAL)"
    path                  = "fdr-internal/service"
    subscription_required = true
    service_url           = null
  }
}

##################
##  API FdR PSP ##
##################

resource "azurerm_api_management_api_version_set" "api_fdr_api_psp" {
  count               = var.enable_fdr3_features == true ? 1 : 0
  name                = "${var.env_short}-fdr-service-api-psp"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_fdr_psp_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_fdr_api_v1_psp" {
  count  = var.enable_fdr3_features == true ? 1 : 0
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.project}-fdr-service-api-psp"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_fdr_product_psp.product_id]
  subscription_required = local.apim_fdr_psp_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_fdr_api_psp[0].id
  api_version           = "v1"

  description  = local.apim_fdr_psp_service_api.description
  display_name = local.apim_fdr_psp_service_api.display_name
  path         = local.apim_fdr_psp_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_fdr_psp_service_api.service_url

  content_format = "openapi"

  content_value = templatefile("./api/fdr-service/psp/v1/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = module.apim_fdr_product_psp.product_id
  })

  xml_content = templatefile("./api/fdr-service/psp/v1/_base_policy.xml.tpl", {
    hostname = local.hostname
  })
}

##################
##  API FdR ORG ##
##################

resource "azurerm_api_management_api_version_set" "api_fdr_api_org" {
  count               = var.enable_fdr3_features == true ? 1 : 0
  name                = "${var.env_short}-fdr-service-api-org"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_fdr_org_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_fdr_api_v1_org" {
  count  = var.enable_fdr3_features == true ? 1 : 0
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.project}-fdr-service-api-org"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_fdr_product_org.product_id]
  subscription_required = local.apim_fdr_org_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_fdr_api_org[0].id
  api_version           = "v1"

  description  = local.apim_fdr_org_service_api.description
  display_name = local.apim_fdr_org_service_api.display_name
  path         = local.apim_fdr_org_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_fdr_org_service_api.service_url

  content_format = "openapi"

  content_value = templatefile("./api/fdr-service/org/v1/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = module.apim_fdr_product_org.product_id
  })

  xml_content = templatefile("./api/fdr-service/org/v1/_base_policy.xml.tpl", {
    hostname = local.hostname
  })
}

#######################
##  API FdR INTERNAL ##
#######################
resource "azurerm_api_management_api_version_set" "api_fdr_api_internal" {
  count               = var.enable_fdr3_features == true ? 1 : 0
  name                = "${var.env_short}-fdr-service-api-internal"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_fdr_service_api_internal.display_name
  versioning_scheme   = "Segment"
}

module "apim_api_fdr_api_v1_internal" {
  count  = var.enable_fdr3_features == true ? 1 : 0
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.project}-fdr-service-api-internal"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_fdr_product_internal.product_id]
  subscription_required = local.apim_fdr_service_api_internal.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_fdr_api_internal[0].id
  api_version           = "v1"

  description  = local.apim_fdr_service_api_internal.description
  display_name = local.apim_fdr_service_api_internal.display_name
  path         = local.apim_fdr_service_api_internal.path
  protocols    = ["https"]
  service_url  = local.apim_fdr_service_api_internal.service_url

  content_format = "openapi"
  content_value = templatefile("./api/fdr-service-internal/v1/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = module.apim_fdr_product_internal.product_id
  })

  xml_content = templatefile("./api/fdr-service-internal/v1/_base_policy.xml.tpl", {
    hostname = local.hostname
  })
}

