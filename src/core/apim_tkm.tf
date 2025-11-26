##############
## Products ##
##############

module "apim_tkm_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "tkm"
  display_name = "Token Manager pagoPA"
  description  = "Product for Token Manager pagoPA"

  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/tkm_api/_base_policy.xml")
}

#################################
## API tkm-ms-consent-manager  ##
#################################
locals {
  apim_tkm_consent_manager_api = {
    # params for all api versions
    display_name          = "Token Manager - tkm-ms-consent-manager"
    description           = "RESTful APIs provided for consent management exposed to the issuers"
    path                  = "tkm/tkmconsentmanager"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "tkm_consent_manager_api" {

  name                = format("%s-tkm-consent-manager-api", local.project)
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_tkm_consent_manager_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_tkm_consent_manager_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-tkm-consent-manager-api", local.project)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_tkm_product.product_id]
  subscription_required = local.apim_tkm_consent_manager_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.tkm_consent_manager_api.id
  api_version           = "v1"
  service_url           = local.apim_tkm_consent_manager_api.service_url

  description  = local.apim_tkm_consent_manager_api.description
  display_name = local.apim_tkm_consent_manager_api.display_name
  path         = local.apim_tkm_consent_manager_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/tkm_api/tkm-ms-consent-manager/v1/_openapi.json.tpl", {
    host = local.api_domain
  })

  xml_content = templatefile("./api/tkm_api/tkm-ms-consent-manager/v1/_base_policy.xml.tpl", {
    cstar_outbound_ip_1 = var.cstar_outbound_ip_1
    cstar_outbound_ip_2 = var.cstar_outbound_ip_2
  })
}

##########################################
## API tkm-ms-consent-manager internal  ##
##########################################
locals {
  apim_tkm_consent_manager_internal_api = {
    # params for all api versions
    display_name          = "Token Manager- tkm-ms-consent-manager-internal"
    description           = "RESTful APIs provided for consent management exposed to the issuers"
    path                  = "tkm/internal/tkmconsentmanager"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "tkm_consent_manager_internal_api" {

  name                = format("%s-tkm-consent-manager-internal-api", local.project)
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_tkm_consent_manager_internal_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_tkm_consent_manager_internal_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-tkm-consent-manager-internal-api", local.project)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_tkm_product.product_id]
  subscription_required = local.apim_tkm_consent_manager_internal_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.tkm_consent_manager_internal_api.id
  api_version           = "v1"
  service_url           = local.apim_tkm_consent_manager_internal_api.service_url

  description  = local.apim_tkm_consent_manager_internal_api.description
  display_name = local.apim_tkm_consent_manager_internal_api.display_name
  path         = local.apim_tkm_consent_manager_internal_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/tkm_api/tkm-ms-consent-manager-internal/v1/_openapi.json.tpl", {
    host = local.api_domain
  })

  xml_content = file("./api/tkm_api/tkm-ms-consent-manager-internal/v1/_base_policy.xml.tpl")
}

#################################
## API tkm-ms-card-manager  ##
#################################
locals {
  apim_tkm_card_manager_api = {
    # params for all api versions
    display_name          = "Token Manager - tkm-ms-card-manager"
    description           = "RESTful API provided for parless cards retrieval"
    path                  = "tkm/tkmcardmanager"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "tkm_card_manager_api" {

  name                = format("%s-tkm-card-manager-api", local.project)
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_tkm_card_manager_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_tkm_card_manager_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-tkm-card-manager-api", local.project)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_tkm_product.product_id]
  subscription_required = local.apim_tkm_card_manager_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.tkm_card_manager_api.id
  api_version           = "v1"
  service_url           = local.apim_tkm_card_manager_api.service_url

  description  = local.apim_tkm_card_manager_api.description
  display_name = local.apim_tkm_card_manager_api.display_name
  path         = local.apim_tkm_card_manager_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/tkm_api/tkm-ms-card-manager/v1/_openapi.json.tpl", {
    host = local.api_domain
  })

  xml_content = file("./api/tkm_api/tkm-ms-card-manager/v1/_base_policy.xml.tpl")
}

#################################
## API tkm-ms-acquirer-manager  ##
#################################
locals {
  apim_tkm_acquirer_manager_api = {
    # params for all api versions
    display_name          = "Token Manager - tkm-ms-acquirer-manager"
    description           = "RESTful APIs provided to acquirers"
    path                  = "tkm/tkmacquirermanager"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "tkm_acquirer_manager_api" {

  name                = format("%s-tkm-acquirer-manager-api", local.project)
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_tkm_acquirer_manager_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_tkm_acquirer_manager_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-tkm-acquirer-manager-api", local.project)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_tkm_product.product_id]
  subscription_required = local.apim_tkm_acquirer_manager_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.tkm_acquirer_manager_api.id
  api_version           = "v1"
  service_url           = local.apim_tkm_acquirer_manager_api.service_url

  description  = local.apim_tkm_acquirer_manager_api.description
  display_name = local.apim_tkm_acquirer_manager_api.display_name
  path         = local.apim_tkm_acquirer_manager_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/tkm_api/tkm-ms-acquirer-manager/v1/_openapi.json.tpl", {
    host = local.api_domain
  })

  xml_content = templatefile("./api/tkm_api/tkm-ms-acquirer-manager/v1/_base_policy.xml.tpl", {
    allowed_ip_1 = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[2] # CSTAR
  })
}

#################################
## API tkm-ms-test-utility     ##
#################################
locals {
  apim_tkm_test_utility_api = {
    # params for all api versions
    display_name          = "Token Manager - tkm-ms-test-utility"
    description           = "RESTful APIs for tkm testing"
    path                  = "tkm/tkm-ms-test-utility"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "tkm_test_utility_api" {
  count               = var.env_short == "d" ? 1 : 0
  name                = format("%s-tkm-ms-test-utility-api", local.project)
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_tkm_test_utility_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_tkm_test_utility_api_v1" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-tkm-ms-test-utility-api", local.project)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_tkm_product.product_id]
  subscription_required = local.apim_tkm_test_utility_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.tkm_test_utility_api[0].id
  api_version           = "v1"
  service_url           = local.apim_tkm_test_utility_api.service_url

  description  = local.apim_tkm_test_utility_api.description
  display_name = local.apim_tkm_test_utility_api.display_name
  path         = local.apim_tkm_test_utility_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/tkm_api/tkm-ms-test-utility/v1/_openapi.json.tpl", {
    host = local.api_domain
  })

  xml_content = file("./api/tkm_api/tkm-ms-test-utility/v1/_base_policy.xml.tpl")
}

#################################
## API tkm-mock-circuit-api    ##
#################################
locals {
  apim_tkm_mock_circuit_api = {
    # params for all api versions
    display_name          = "TKM - mock circuit"
    description           = "RESTful APIs provided for TKM mock circuit"
    path                  = "tkm/internal/tkmmockcircuits"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "tkm_mock_circuit_api" {
  count = var.env_short == "u" || var.env_short == "d" ? 1 : 0

  name                = "${local.project}-tkm-mock-circuit-api"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_tkm_mock_circuit_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_tkm_mock_circuit_api_v1" {
  count = var.env_short == "u" || var.env_short == "d" ? 1 : 0

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = "${local.project}-tkm-mock-circuit-api"
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_tkm_product.product_id]
  subscription_required = local.apim_tkm_mock_circuit_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.tkm_mock_circuit_api[0].id
  api_version           = "v1"
  service_url           = local.apim_tkm_mock_circuit_api.service_url

  description  = local.apim_tkm_mock_circuit_api.description
  display_name = local.apim_tkm_mock_circuit_api.display_name
  path         = local.apim_tkm_mock_circuit_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/tkm_api/tkm-mock-circuit-api/v1/_openapi.json.tpl", {
    host = local.api_domain
  })

  xml_content = templatefile("./api/tkm_api/tkm-mock-circuit-api/v1/_base_policy.xml.tpl", {
    hostname = var.env_short == "u" ? "https://weuuat.shared.internal.uat.platform.pagopa.it" : "http://{{aks-lb-nexi}}/tkmcircuitmock"
  })
}
