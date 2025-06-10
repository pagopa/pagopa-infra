
############################
## Mock Nexi cfg in PRF   ##
############################

# for Nexi *CLOUD* env default-backend-prf must be
# EC
# default-backend-url-prf = http://10.70.74.200/ec-mockprf  + /servizio
# PM
# default-backend-url-prf = http://10.70.74.200/mock-pm-prf  + /PerfPMMock/RestAPI
# PSP
# default-backend-url-prf = http://10.70.74.200/psp-mockprf  + /simulatorePSP

# for Nexi *ON PREM* env default-backend-prf must be
# EC PRF
# default-backend-url-prf = https://10.79.20.63  + /servizio
# header ndphost = mock-ec-prf.nexigroup.com
# PSP
# default-backend-url-prf = https://10.79.20.63  + /simulatorePSP
# header ndphost = mock-psp-prf.nexigroup.com
# PM SIT
# default-backend-url-prf = https://10.70.66.200  + /PerfPMMock/RestAPI
# header ndphost = mock-pm-sit.nexigroup.com
# PM PRF
# default-backend-url-prf = https://10.79.20.63  + /PerfPMMock/RestAPI
# header ndphost = mock-pm-prf.nexigroup.com

############################
## Mock EC Nexi           ##
############################

module "apim_mock_ec_nexi_product" {
  count  = var.env_short == "u" ? 1 : 0 # only UAT pointing out to NEXI PRF environment
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "product-mock-ec-nexi"
  display_name = "product-mock-ec-nexi"
  description  = "product-mock-ec-nexi"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/mock_nexi/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "mock_ec_nexi_api" {
  count = var.env_short == "u" ? 1 : 0 # only UAT pointing out to NEXI PRF environment

  name                = format("%s-mock-ec-nexi-api", var.env_short)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "Mock Ec Nexi"
  versioning_scheme   = "Segment"
}

module "apim_mock_ec_nexi_api" {
  count  = var.env_short == "u" ? 1 : 0 # only UAT pointing out to NEXI PRF environment
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-mock-ec-nexi-api", var.env_short)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_mock_ec_nexi_product[0].product_id, local.apim_x_node_product_id]
  subscription_required = false

  version_set_id = azurerm_api_management_api_version_set.mock_ec_nexi_api[0].id
  api_version    = "v1"

  description  = "Mock Ec Nexi PRF"
  display_name = "Mock Ec Nexi PRF "
  path         = "ec-mockprf"
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/mock_nexi/ec/v1/mock.openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = file("./api/mock_nexi/ec/v1/_base_policy.xml")
}


############################
## Mock PSP Nexi         ##
############################

module "apim_mock_psp_nexi_product" {
  count  = var.env_short == "u" ? 1 : 0 # only UAT pointing out to NEXI PRF environment
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "product-mock-psp-nexi"
  display_name = "product-mock-psp-nexi"
  description  = "product-mock-psp-nexi"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/mock_nexi/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "mock_psp_nexi_api" {
  count = var.env_short == "u" ? 1 : 0 # only UAT pointing out to NEXI PRF environment

  name                = format("%s-mock-psp-nexi-api", var.env_short)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "Mock Psp Nexi"
  versioning_scheme   = "Segment"
}

module "apim_mock_psp_nexi_api" {
  count  = var.env_short == "u" ? 1 : 0 # only UAT pointing out to NEXI PRF environment
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-mock-psp-nexi-api", var.env_short)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_mock_psp_nexi_product[0].product_id]
  subscription_required = false

  version_set_id = azurerm_api_management_api_version_set.mock_psp_nexi_api[0].id
  api_version    = "v1"

  description  = "Mock Psp Nexi PRF"
  display_name = "Mock Psp Nexi PRF"
  path         = "psp-mockprf"
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/mock_nexi/psp/v1/mock.openapi.json.tpl", {
    host    = local.apim_hostname
    service = module.apim_mock_psp_nexi_product[0].product_id
  })

  xml_content = file("./api/mock_nexi/psp/v1/_base_policy.xml")

}

############################
## Mock PM Nexi           ##
############################

module "apim_mock_pm_nexi_product" {
  count  = var.env_short != "p" ? 1 : 0 # only UAT pointing out to NEXI PRF environment + Esposizione apim SIT mock PM
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "product-mock-pm-nexi"
  display_name = "product-mock-pm-nexi"
  description  = "product-mock-pm-nexi"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/mock_nexi/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "mock_pm_nexi_api" {
  count = var.env_short != "p" ? 1 : 0 # only UAT pointing out to NEXI PRF environment Esposizione apim SIT mock PM

  name                = format("%s-mock-pm-nexi-api", var.env_short)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "Mock PM Nexi"
  versioning_scheme   = "Segment"
}

module "apim_mock_pm_nexi_api" {
  count  = var.env_short != "p" ? 1 : 0 # only UAT pointing out to NEXI PRF environment + Esposizione apim SIT mock PM
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-mock-pm-nexi-api", var.env_short)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_mock_pm_nexi_product[0].product_id, local.apim_x_node_product_id]
  subscription_required = false

  version_set_id = azurerm_api_management_api_version_set.mock_pm_nexi_api[0].id
  api_version    = "v1"

  description  = "Mock PM Nexi"
  display_name = "Mock PM Nexi"
  path         = var.env_short == "u" ? "mock-pm-prf" : "mock-pm-sit"
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/mock_nexi/psp/v1/mock.openapi.json.tpl", {
    host    = local.apim_hostname
    service = module.apim_mock_pm_nexi_product[0].product_id
  })

  xml_content = templatefile("./api/mock_nexi/pm/v1/_base_policy.xml", {
    ndphost = var.env_short == "u" ? "mock-pm-prf.nexigroup.com" : "mock-pm-sit.nexigroup.com"
    backend = var.env_short == "u" ? "{{default-nodo-backend-prf}}/PerfPMMock/RestAPI" : "{{schema-ip-nexi}}/sit-mock-pm"
  })

}
