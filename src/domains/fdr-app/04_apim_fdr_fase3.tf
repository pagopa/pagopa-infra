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

########################
##  Info for FdR Rend ##
########################
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
