##############
## Products ##
##############

module "apim_tkm_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.16"

  product_id   = "tkm"
  display_name = "Token Manager pagoPA"
  description  = "Product for Token Manager pagoPA"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = true

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
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_tkm_consent_manager_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_tkm_consent_manager_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-tkm-consent-manager-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
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
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/tkm_api/tkm-ms-consent-manager/v1/_base_policy.xml.tpl", {
    cstar_ip_1 = var.cstar_ip_1
    cstar_ip_2 = var.cstar_ip_2
  })
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
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_tkm_card_manager_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_tkm_card_manager_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-tkm-card-manager-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
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
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
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
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "tkm_acquirer_manager_api" {

  name                = format("%s-tkm-acquirer-manager-api", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_tkm_acquirer_manager_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_tkm_acquirer_manager_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-tkm-acquirer-manager-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
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
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/tkm_api/tkm-ms-acquirer-manager/v1/_base_policy.xml.tpl")
}