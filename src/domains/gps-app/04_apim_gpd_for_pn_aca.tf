resource "azurerm_api_management_subscription" "afm_pn_subkey_test" {
  count = var.env_short != "p" ? 1 : 0

  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  product_id          = module.apim_pn_integration_product.id
  display_name        = "Subscription for PN GDP notifcation fee test"
  allow_tracing       = false
  state               = "active"
}

resource "azurerm_api_management_named_value" "afm_pn_sub_key_test_apim_nv" {
  count = var.env_short != "p" ? 1 : 0

  name                = "afm-pn-sub-key-test"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "afm-pn-sub-key-test"
  value               = azurerm_api_management_subscription.afm_pn_subkey_test[0].primary_key
}

####################
## Local variables #
####################

locals {
  apim_pn_integration_rest_api = {
    display_name          = "GPD PN Integration"
    description           = "GPD REST API for PN for retrieve payment options and update payment option fee"
    published             = false
    subscription_required = true
    approval_required     = true
    subscriptions_limit   = 1000
    service_url           = local.gpd_core_service_url
    gpd_service = {
      display_name = "GPD PN Integration"
      description  = "GPD API per Piattaforma Notifiche"
      path         = "pn-integration-gpd/api"
    }
  }
}

############################
## Product pn-integration ##
############################

module "apim_pn_integration_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "pn-integration"
  display_name = "PN Integration"
  description  = "Integrazione piattaforma notifiche"

  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name

  published             = false
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/pn-integration/_base_policy.xml")
}

#############################
## Product aca-integration ##
#############################

module "apim_aca_integration_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "aca-integration"
  display_name = "ACA Integration"
  description  = "Integrazione archivio centralizzato avvisi"

  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name

  published             = false
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/aca-integration/_base_policy.xml")
}


##############
## REST API ##
##############

resource "azurerm_api_management_api_version_set" "api_pn_integration_api" {
  name                = format("%s-pn-integration-rest-api", var.env_short)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = local.apim_pn_integration_rest_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_api_pn_integration_gpd_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-pn-integration-gpd-api-aks", var.env_short)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_pn_integration_product.product_id]
  subscription_required = local.apim_pn_integration_rest_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_pn_integration_api.id
  api_version           = "v1"

  description  = local.apim_pn_integration_rest_api.gpd_service.description
  display_name = local.apim_pn_integration_rest_api.gpd_service.display_name
  path         = local.apim_pn_integration_rest_api.gpd_service.path
  protocols    = ["https"]
  service_url  = local.apim_pn_integration_rest_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/pn-integration/_openapi.json.tpl", {
    service = local.apim_pn_integration_rest_api.gpd_service.path
  })

  xml_content = templatefile("./api/pn-integration/_base_policy${var.env_short != "p" ? "_mock" : ""}.xml", {
  })
}
