
############################
## Mock Nexi cfg in PRF   ##
############################

# PM  -> lb aks uat 10.70.74.200+ /mock-pm-prf  +   /PerfPMMock/RestAPI
# EC  -> lb aks uat 10.70.74.200+ /ec-mockprf   +   /servizio
# PSP -> lb aks uat 10.70.74.200+ /psp-mockprf  +   /simulatorePSP

############################
## Mock EC Nexi           ##
############################

module "apim_mock_ec_nexi_product" {
  count  = var.env_short == "u" ? 1 : 0 # only UAT pointing out to NEXI PRF environment 
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "product-mock-ec-nexi"
  display_name = "product-mock-ec-nexi"
  description  = "product-mock-ec-nexi"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/mock_nexi/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "mock_ec_nexi_api" {
  count = var.env_short == "u" ? 1 : 0 # only UAT pointing out to NEXI PRF environment 

  name                = format("%s-mock-ec-nexi-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "Mock Ec Nexi"
  versioning_scheme   = "Segment"
}

module "apim_mock_ec_nexi_api" {
  count  = var.env_short == "u" ? 1 : 0 # only UAT pointing out to NEXI PRF environment 
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-mock-ec-nexi-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_mock_ec_nexi_product[0].product_id]
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
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/mock_nexi/ec/v1/_base_policy.xml", {
    mock_base_path = "/ec-mockprf/servizio"
  })

}


############################
## Mock PSP Nexi         ##
############################

module "apim_mock_psp_nexi_product" {
  count  = var.env_short == "u" ? 1 : 0 # only UAT pointing out to NEXI PRF environment 
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "product-mock-psp-nexi"
  display_name = "product-mock-psp-nexi"
  description  = "product-mock-psp-nexi"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/mock_nexi/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "mock_psp_nexi_api" {
  count = var.env_short == "u" ? 1 : 0 # only UAT pointing out to NEXI PRF environment 

  name                = format("%s-mock-psp-nexi-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "Mock Psp Nexi"
  versioning_scheme   = "Segment"
}

module "apim_mock_psp_nexi_api" {
  count  = var.env_short == "u" ? 1 : 0 # only UAT pointing out to NEXI PRF environment 
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-mock-psp-nexi-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_mock_psp_nexi_product[0].product_id]
  subscription_required = false

  version_set_id = azurerm_api_management_api_version_set.mock_psp_nexi_api[0].id
  api_version    = "v1"

  description  = "Mock Psp Nexi PRF"
  display_name = "Mock Psp Nexi PRF "
  path         = "psp-mockprf"
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/mock_nexi/psp/v1/mock.openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/mock_nexi/psp/v1/_base_policy.xml", {
    mock_base_path = "/psp-mockprf/simulatorePSP"
  })

}

############################
## Mock PM Nexi           ##
############################

module "apim_mock_pm_nexi_product" {
  count  = var.env_short == "u" ? 1 : 0 # only UAT pointing out to NEXI PRF environment 
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "product-mock-pm-nexi"
  display_name = "product-mock-pm-nexi"
  description  = "product-mock-pm-nexi"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/mock_nexi/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "mock_pm_nexi_api" {
  count = var.env_short == "u" ? 1 : 0 # only UAT pointing out to NEXI PRF environment 

  name                = format("%s-mock-pm-nexi-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "Mock PM Nexi"
  versioning_scheme   = "Segment"
}

module "apim_mock_pm_nexi_api" {
  count  = var.env_short == "u" ? 1 : 0 # only UAT pointing out to NEXI PRF environment 
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-mock-pm-nexi-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_mock_pm_nexi_product[0].product_id]
  subscription_required = false

  version_set_id = azurerm_api_management_api_version_set.mock_pm_nexi_api[0].id
  api_version    = "v1"

  description  = "Mock PM Nexi PRF"
  display_name = "Mock PM Nexi PRF "
  path         = "mock-pm-prf"
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/mock_nexi/psp/v1/mock.openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/mock_nexi/psp/v1/_base_policy.xml", {
    mock_base_path = "/mock-pm-prf/PerfPMMock/RestAPI"
  })

}
