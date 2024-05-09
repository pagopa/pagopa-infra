##############################
## API Mock nodo for EC     ##
##############################
locals {
  apim_ecommerce_nodo_mock_api = {
    display_name          = "ecommerce pagoPA - nodo mock API"
    description           = "API to support integration testing"
    path                  = "ecommerce/mock/nodo"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "apim_ecommerce_nodo_mock_api" {
  count               = var.env_short == "u" ? 1 : 0
  name                = "${local.project}-nodo_mock"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_nodo_mock_api.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_ecommerce_nodo_mock" {
  count = var.env_short == "u" ? 1 : 0

  name                  = "${local.project}-nodo_mock"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  subscription_required = local.apim_ecommerce_nodo_mock_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_ecommerce_nodo_mock_api[0].id
  version               = "v1"
  revision              = "1"

  description  = local.apim_ecommerce_nodo_mock_api.description
  display_name = local.apim_ecommerce_nodo_mock_api.display_name
  path         = local.apim_ecommerce_nodo_mock_api.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_nodo_mock_api.service_url

  import {
    content_format = "wsdl"
    content_value  = file("./api/ecommerce-mock/nodeForPsp/v1/nodeForPsp.wsdl")
    wsdl_selector {
      service_name  = "nodeForPsp_Service"
      endpoint_name = "nodeForPsp_Port"
    }
  }
}

resource "azurerm_api_management_product_api" "apim_ecommerce_nodo_mock_product_api" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_nodo_mock[0].name
  product_id          = module.apim_ecommerce_product.product_id
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
}

resource "azurerm_api_management_api_policy" "apim_ecommerce_nodo_mock_policy" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_nodo_mock[0].name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  xml_content = file("./api/ecommerce-mock/nodeForPsp/v1/_base_policy.xml.tpl")
}


##############################
## API Mock nodo for PM     ##
##############################
locals {
  apim_ecommerce_nodo_per_pm_mock_api = {
    display_name          = "ecommerce pagoPA - nodo mock per PM API"
    description           = "API to support integration testing"
    path                  = "ecommerce/mock/nodoPerPM"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "apim_ecommerce_nodo_per_pm_mock_api" {
  count               = var.env_short == "u" ? 1 : 0
  name                = "${local.project}-nodo_per_pm_mock"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_nodo_per_pm_mock_api.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_ecommerce_nodo_per_pm_mock" {
  count = var.env_short == "u" ? 1 : 0

  name                  = "${local.project}-nodo_per_pm_mock"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  subscription_required = local.apim_ecommerce_nodo_per_pm_mock_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_ecommerce_nodo_per_pm_mock_api[0].id
  version               = "v1"
  revision              = "1"

  description  = local.apim_ecommerce_nodo_per_pm_mock_api.description
  display_name = local.apim_ecommerce_nodo_per_pm_mock_api.display_name
  path         = local.apim_ecommerce_nodo_per_pm_mock_api.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_nodo_per_pm_mock_api.service_url

  import {
    content_format = "swagger-json"
    content_value = templatefile("./api/ecommerce-mock/nodoPerPM/v1/_swagger.json.tpl", {
      host = local.apim_hostname
    })
  }
}

resource "azurerm_api_management_product_api" "apim_ecommerce_nodo_per_pm_mock_product_api" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_nodo_per_pm_mock[0].name
  product_id          = module.apim_ecommerce_product.product_id
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
}

resource "azurerm_api_management_api_policy" "apim_ecommerce_nodo_per_pm_mock_policy" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_nodo_per_pm_mock[0].name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  xml_content = file("./api/ecommerce-mock/nodoPerPM/v1/_base_policy.xml.tpl")
}


##############################
## API Mock PDV             ##
##############################
locals {
  apim_ecommerce_pdv_mock_api = {
    display_name          = "ecommerce pagoPA - PDV mock"
    description           = "API to support integration testing"
    path                  = "ecommerce/mock/pdv"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "apim_ecommerce_pdv_mock_api" {
  count               = var.env_short == "u" ? 1 : 0
  name                = "${local.project}-pdv-mock"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_pdv_mock_api.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_ecommerce_pdv_mock" {
  count = var.env_short == "u" ? 1 : 0

  name                  = "${local.project}-pdv-mock"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  subscription_required = local.apim_ecommerce_pdv_mock_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_ecommerce_pdv_mock_api[0].id
  version               = "v1"
  revision              = "1"

  description  = local.apim_ecommerce_pdv_mock_api.description
  display_name = local.apim_ecommerce_pdv_mock_api.display_name
  path         = local.apim_ecommerce_pdv_mock_api.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_pdv_mock_api.service_url

  import {
    content_format = "openapi"
    content_value = templatefile("./api/ecommerce-mock/pdv/v1/_openapi.json.tpl", {
      host = local.apim_hostname
    })
  }
}

resource "azurerm_api_management_product_api" "apim_ecommerce_pdv_mock_product_api" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_pdv_mock[0].name
  product_id          = module.apim_ecommerce_product.product_id
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
}

resource "azurerm_api_management_api_policy" "apim_ecommerce_pdv_mock_policy" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_pdv_mock[0].name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  xml_content = file("./api/ecommerce-mock/pdv/v1/_base_policy.xml.tpl")
}


##############################
## API Mock GEC V1          ##
##############################
locals {
  apim_ecommerce_gec_mock_api = {
    display_name          = "ecommerce pagoPA - GEC mock"
    description           = "API to support integration testing"
    path                  = "ecommerce/mock/gec"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "apim_ecommerce_gec_mock_api_v1" {
  count               = var.env_short == "u" ? 1 : 0
  name                = "${local.project}-gec-mock-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_gec_mock_api.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_ecommerce_gec_mock_v1" {
  count = var.env_short == "u" ? 1 : 0

  name                  = "${local.project}-gec-mock"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  subscription_required = local.apim_ecommerce_gec_mock_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_ecommerce_gec_mock_api_v1[0].id
  version               = "v1"
  revision              = "1"

  description  = local.apim_ecommerce_gec_mock_api.description
  display_name = local.apim_ecommerce_gec_mock_api.display_name
  path         = local.apim_ecommerce_gec_mock_api.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_gec_mock_api.service_url

  import {
    content_format = "openapi"
    content_value = templatefile("./api/ecommerce-mock/gec/v1/_openapi.json.tpl", {
      host = local.apim_hostname
    })
  }
}

resource "azurerm_api_management_product_api" "apim_ecommerce_gec_mock_product_api_v1" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_gec_mock_v1[0].name
  product_id          = module.apim_ecommerce_product.product_id
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
}

resource "azurerm_api_management_api_policy" "apim_ecommerce_gec_mock_policy_v1" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_gec_mock_v1[0].name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  xml_content = file("./api/ecommerce-mock/gec/v1/_base_policy.xml.tpl")
}


##############################
## API Mock GEC V2          ##
##############################

resource "azurerm_api_management_api" "apim_ecommerce_gec_mock_v2" {
  count = var.env_short == "u" ? 1 : 0

  name                  = "${local.project}-gec-mock-v2"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  subscription_required = local.apim_ecommerce_gec_mock_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_ecommerce_gec_mock_api_v1[0].id
  version               = "v2"
  revision              = "1"

  description  = local.apim_ecommerce_gec_mock_api.description
  display_name = local.apim_ecommerce_gec_mock_api.display_name
  path         = local.apim_ecommerce_gec_mock_api.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_gec_mock_api.service_url

  import {
    content_format = "openapi"
    content_value = templatefile("./api/ecommerce-mock/gec/v2/_openapi.json.tpl", {
      host    = local.apim_hostname,
      service = local.apim_ecommerce_gec_mock_api.display_name
    })
  }
}

resource "azurerm_api_management_product_api" "apim_ecommerce_gec_mock_product_api_v2" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_gec_mock_v2[0].name
  product_id          = module.apim_ecommerce_product.product_id
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
}

resource "azurerm_api_management_api_policy" "apim_ecommerce_gec_mock_policy_v2" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_gec_mock_v2[0].name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  xml_content = file("./api/ecommerce-mock/gec/v2/_base_policy.xml.tpl")
}

##############################
## API Mock for Redirect    ##
##############################
locals {
  apim_ecommerce_redirect_mock_api = {
    display_name          = "ecommerce pagoPA - Redirect mock"
    description           = "API to support integration testing"
    path                  = "ecommerce/mock/redirect"
    subscription_required = false
    service_url           = null
    enabled               = var.env_short == "u" ? 1 : 0
  }
}

resource "azurerm_api_management_api_version_set" "apim_ecommerce_redirect_mock_api" {
  count               = local.apim_ecommerce_redirect_mock_api.enabled
  name                = "${local.project}-redirect-mock"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_redirect_mock_api.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_ecommerce_redirect_mock" {
  count = local.apim_ecommerce_redirect_mock_api.enabled

  name                  = "${local.project}-redirect-mock"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  subscription_required = local.apim_ecommerce_redirect_mock_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_ecommerce_redirect_mock_api[0].id
  version               = "v1"
  revision              = "1"

  description  = local.apim_ecommerce_redirect_mock_api.description
  display_name = local.apim_ecommerce_redirect_mock_api.display_name
  path         = local.apim_ecommerce_redirect_mock_api.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_redirect_mock_api.service_url

  import {
    content_format = "openapi"
    content_value = templatefile("./api/ecommerce-mock/redirect/v1/_openapi.json.tpl", {
      host = local.apim_hostname
    })
  }
}

resource "azurerm_api_management_product_api" "apim_ecommerce_redirect_mock_product_api" {
  count               = local.apim_ecommerce_redirect_mock_api.enabled
  api_name            = azurerm_api_management_api.apim_ecommerce_redirect_mock[0].name
  product_id          = module.apim_ecommerce_product.product_id
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
}

resource "azurerm_api_management_api_policy" "apim_ecommerce_redirect_mock_policy" {
  count               = local.apim_ecommerce_redirect_mock_api.enabled
  api_name            = azurerm_api_management_api.apim_ecommerce_redirect_mock[0].name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  xml_content = file("./api/ecommerce-mock/redirect/v1/_base_policy.xml.tpl")
}
