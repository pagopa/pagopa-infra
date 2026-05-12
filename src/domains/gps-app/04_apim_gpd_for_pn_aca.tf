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



