##############
## Products ##
##############

module "apim_mock_ec_product" {
  count  = var.mock_ec_enabled ? 1 : 0
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "product-mock-ec"
  display_name = "product-mock-ec"
  description  = "product-mock-ec"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/mockec_api/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "mock_ec_api" {
  count = var.mock_ec_enabled ? 1 : 0

  name                = format("%s-mock-ec-api", var.env_short)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "Mock EC API"
  versioning_scheme   = "Segment"
}

module "apim_mock_ec_api" {
  count  = var.mock_ec_enabled ? 1 : 0
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-mock-ec-api", var.env_short)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_mock_ec_product[0].product_id, local.apim_x_node_product_id]
  subscription_required = false

  version_set_id = azurerm_api_management_api_version_set.mock_ec_api[0].id
  api_version    = "v1"

  description  = "API of Mock EC"
  display_name = "Mock EC API"
  path         = "mock-ec/api"
  protocols    = ["https"]

  # UAT pagoPA - DEV nexi
  service_url = var.env_short == "u" ? format("https://%s/mock-ec", local.mock_ec_default_site_hostname) : var.env_short == "d" ? "http://${var.lb_aks}/mock-ec-sit/servizi/PagamentiTelematiciRPT" : null

  content_value = templatefile("./api/mockec_api/v1/_swagger.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/mockec_api/v1/_base_policy.xml", {
    mock_ec_host_path = var.env_short == "u" ? format("https://%s/mock-ec", local.mock_ec_default_site_hostname) : var.env_short == "d" ? "http://${var.lb_aks}/mock-ec-sit/servizi/PagamentiTelematiciRPT" : ""
  })

}


resource "azurerm_api_management_api_operation_policy" "apim_mock_ec_api_policy" {

  api_name            = module.apim_mock_ec_api[0].name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  operation_id        = "mock-ec"

  xml_content = file("./api/mockec_api/v1/_base_policy_rewrite.xml")
}

#############################
## Mock EC Nexi secondary  ##
#############################
module "apim_secondary_mock_ec_product" {
  count  = var.mock_ec_secondary_enabled ? 1 : 0
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "product-secondary-mock-ec"
  display_name = "product-secondary-mock-ec"
  description  = "product-secondary-mock-ec"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/mockec_api/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "secondary_mock_ec_api" {
  count = var.mock_ec_secondary_enabled ? 1 : 0

  name                = format("%s-secondary-mock-ec-api", var.env_short)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "Secondary Mock EC API"
  versioning_scheme   = "Segment"
}

module "apim_secondary_mock_ec_api" {
  count  = var.mock_ec_secondary_enabled ? 1 : 0
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-secondary-mock-ec-api", var.env_short)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_secondary_mock_ec_product[0].product_id, local.apim_x_node_product_id]
  subscription_required = false

  version_set_id = azurerm_api_management_api_version_set.secondary_mock_ec_api[0].id
  api_version    = "v1"

  description  = "API of Secondary Mock EC"
  display_name = "Secondary Mock EC API"
  path         = "secondary-mock-ec/api"
  protocols    = ["https"]

  # service_url = format("https://%s", local.mock_ec_default_site_hostname)
  service_url = "http://${var.lb_aks}/secondary-mock-ec-sit/secondary-mock-ec"

  content_value = templatefile("./api/mockec_api/secondary_v1/_swagger.json.tpl", {
    host = local.apim_hostname
  })

  # xml_content = file("./api/mockec_api/v1/_base_policy.xml")
  xml_content = templatefile("./api/mockec_api/secondary_v1/_base_policy.xml", {
    mock_ec_host_path = "http://${var.lb_aks}/secondary-mock-ec-sit/secondary-mock-ec"
  })

}


// forwarder


resource "azurerm_api_management_api_version_set" "secondary_mock_ec_forwarder_api" {
  count = var.env_short != "p" ? 1 : 0

  name                = format("%s-mock-ec-forwarder-api", var.env_short)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "Mock EC Forwarder API"
  versioning_scheme   = "Segment"
}

module "apim_mock_ec_forwarder_api" {
  count  = var.env_short != "p" ? 1 : 0
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-mock-ec-forwarder-api", var.env_short)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  subscription_required = false

  version_set_id = azurerm_api_management_api_version_set.secondary_mock_ec_forwarder_api[0].id
  api_version    = "v1"

  description  = "API of Mock EC for Node Forwarder"
  display_name = "Temp Mock EC API"
  path         = "mockecforwarder"
  protocols    = ["https"]

  service_url = ""

  content_value = templatefile("./api/mockec_api/forwarder/_swagger.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = file("./api/mockec_api/forwarder/_base_policy.xml")

}
