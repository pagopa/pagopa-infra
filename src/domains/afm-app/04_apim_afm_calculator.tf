# named-values

resource "azurerm_api_management_named_value" "afm_secondary_sub_key" {
  name                = "afm-secondary-sub-key"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "afm-secondary-sub-key"
  value               = "<TO_UPDATE_MANUALLY_BY_PORTAL>"

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "azurerm_api_management_named_value" "afm_ndp_test_sub_key" {
  name                = "afm-ndp-test-sub-key"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "afm-ndp-test-sub-key"
  value               = "<TO_UPDATE_MANUALLY_BY_PORTAL>"

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

#############################
## Product AFM Calculator ##
#############################

locals {
  apim_afm_calculator_service_api = {
    display_name          = "AFM Calculator pagoPA - calculator of advanced fees management service API"
    description           = "Calculator API to support advanced fees management service"
    path                  = "afm/calculator-service"
    subscription_required = true
    service_url           = null
  }

  apim_afm_calculator_service_node_api = {
    display_name          = "AFM Calculator pagoPA for Node - calculator of advanced fees management service API"
    description           = "Calculator API to support advanced fees management service"
    path                  = "afm/node/calculator-service"
    subscription_required = true
    service_url           = null
  }
}

module "apim_afm_calculator_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "afm-calculator"
  display_name = local.apim_afm_calculator_service_api.display_name
  description  = local.apim_afm_calculator_service_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = local.apim_afm_calculator_service_api.subscription_required
  approval_required     = false

  policy_xml = file("./api_product/calculator/_base_policy.xml")
}

module "apim_afm_calculator_node_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "afm-node-calculator"
  display_name = local.apim_afm_calculator_service_node_api.display_name
  description  = local.apim_afm_calculator_service_node_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = local.apim_afm_calculator_service_node_api.subscription_required
  approval_required     = true
  subscriptions_limit   = 1

  policy_xml = file("./api_product/calculator/_base_policy.xml")
}

resource "azurerm_api_management_group" "api_afm_calculator_node_group" {
  name                = "afm-calculator"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "AFM Calculator for Node"
  description         = "API management group of AFM Calculator for Node"
}

data "azurerm_api_management_group" "api_afm_calculator_node_group" {
  name                = azurerm_api_management_group.api_afm_calculator_node_group.name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name

  depends_on = [azurerm_api_management_group.api_afm_calculator_node_group]
}

resource "azurerm_api_management_product_group" "api_afm_calculator_node_product_group" {
  # for_each is avoided in order to not delete the relationship and re-create it

  product_id          = module.apim_afm_calculator_node_product.product_id
  api_management_name = local.pagopa_apim_name
  group_name          = data.azurerm_api_management_group.api_afm_calculator_node_group.name

  resource_group_name = local.pagopa_apim_rg
}


###########################
##  API AFM Calculator  ##
###########################

resource "azurerm_api_management_api_version_set" "api_afm_calculator_api" {

  name                = format("%s-afm-calculator-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_afm_calculator_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_afm_calculator_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-afm-calculator-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_afm_calculator_product.product_id]
  subscription_required = local.apim_afm_calculator_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_afm_calculator_api.id
  api_version           = "v1"

  description  = local.apim_afm_calculator_service_api.description
  display_name = local.apim_afm_calculator_service_api.display_name
  path         = local.apim_afm_calculator_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_afm_calculator_service_api.service_url

  content_format = "openapi"
  content_value = templatefile(var.env_short != "p" ? "./api/calculator-service/v1/_openapi.json.tpl" : "./api/calculator-service/v1/prod/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/calculator-service/v1/_base_policy.xml", {
    hostname = local.afm_hostname
  })
}

module "apim_api_afm_calculator_api_v2" {
  source = "./.terraform/modules/__v3__/api_management_api"


  name                  = format("%s-afm-calculator-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_afm_calculator_product.product_id]
  subscription_required = local.apim_afm_calculator_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_afm_calculator_api.id
  api_version           = "v2"

  description  = local.apim_afm_calculator_service_api.description
  display_name = local.apim_afm_calculator_service_api.display_name
  path         = local.apim_afm_calculator_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_afm_calculator_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/calculator-service/v2/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = module.apim_afm_calculator_product.product_id
  })

  xml_content = templatefile("./api/calculator-service/v2/_base_policy.xml", {
    hostname = local.afm_hostname
  })
}


##################################
##  API AFM Calculator for Node ##
##################################

resource "azurerm_api_management_api_version_set" "api_afm_calculator_node_api" {
  name                = format("%s-afm-calculator-service-node-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_afm_calculator_service_node_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_api_afm_calculator_api_node_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-afm-calculator-service-node-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_afm_calculator_node_product.product_id, local.apim_x_node_product_id]
  subscription_required = local.apim_afm_calculator_service_node_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_afm_calculator_node_api.id
  api_version           = "v1"

  description  = local.apim_afm_calculator_service_node_api.description
  display_name = local.apim_afm_calculator_service_node_api.display_name
  path         = local.apim_afm_calculator_service_node_api.path
  protocols    = ["https"]
  service_url  = local.apim_afm_calculator_service_node_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/calculator-service/node/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile(var.env_short == "p" ? "./api/calculator-service/node/v1/_base_policy.xml" : "./api/calculator-service/node/v1/_base_policy_test.xml", {
    hostname = local.afm_hostname
  })
}

module "apim_api_afm_calculator_api_node_v2" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-afm-calculator-service-node-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_afm_calculator_node_product.product_id, local.apim_x_node_product_id]
  subscription_required = local.apim_afm_calculator_service_node_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_afm_calculator_node_api.id
  api_version           = "v2"

  description  = local.apim_afm_calculator_service_node_api.description
  display_name = local.apim_afm_calculator_service_node_api.display_name
  path         = local.apim_afm_calculator_service_node_api.path
  protocols    = ["https"]
  service_url  = local.apim_afm_calculator_service_node_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/calculator-service/node/v2/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = module.apim_afm_calculator_node_product.product_id
  })

  xml_content = templatefile("./api/calculator-service/node/v2/_base_policy.xml", {
    hostname = local.afm_hostname
  })
}
