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

resource "azurerm_api_management_api_operation_policy" "nodo_per_pm_check_position_policy" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_nodo_per_pm_mock[0].name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "checkPosition"

  xml_content = file("./api/ecommerce-mock/nodoPerPM/v1/check_position_mock.xml.tpl")
}

resource "azurerm_api_management_api_operation_policy" "nodo_per_pm_close_payment_policy" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_nodo_per_pm_mock[0].name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "closePayment"

  xml_content = file("./api/ecommerce-mock/nodoPerPM/v1/close_payment_mock.xml.tpl")
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
    subscription_required = true
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
## API Mock NPG             ##
##############################
locals {
  apim_ecommerce_npg_mock_api = {
    display_name          = "eCommerce pagoPA - NPG mock"
    description           = "API to support integration testing"
    path                  = "ecommerce/mock/npg"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "apim_ecommerce_npg_mock_api" {
  count               = var.env_short == "u" ? 1 : 0
  name                = "${local.project}-npg-mock"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_npg_mock_api.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_ecommerce_npg_mock" {
  count = var.env_short == "u" ? 1 : 0

  name                  = "${local.project}-npg-mock"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  subscription_required = local.apim_ecommerce_npg_mock_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_ecommerce_npg_mock_api[0].id
  version               = "v1"
  revision              = "1"

  description  = local.apim_ecommerce_npg_mock_api.description
  display_name = local.apim_ecommerce_npg_mock_api.display_name
  path         = local.apim_ecommerce_npg_mock_api.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_npg_mock_api.service_url

  import {
    content_format = "openapi"
    content_value = templatefile("./api/ecommerce-mock/npg/v1/_openapi.json.tpl", {
      host = local.apim_hostname
    })
  }
}

resource "azurerm_api_management_product_api" "apim_ecommerce_npg_mock_product_api" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_npg_mock[0].name
  product_id          = module.apim_ecommerce_product.product_id
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
}

resource "azurerm_api_management_api_policy" "apim_ecommerce_npg_mock_policy" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_npg_mock[0].name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  xml_content = file("./api/ecommerce-mock/npg/v1/_base_policy.xml.tpl")
}

resource "azurerm_api_management_api_operation_policy" "post_orders_build" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_npg_mock[0].name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "postOrdersBuild"

  xml_content = file("./api/ecommerce-mock/npg/v1/post_orders_build.xml.tpl")
}

resource "azurerm_api_management_api_operation_policy" "confirm_payment" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_npg_mock[0].name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "confirmPayment"

  xml_content = file("./api/ecommerce-mock/npg/v1/confirm_payment.xml.tpl")
}

resource "azurerm_api_management_api_operation_policy" "get_state" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_npg_mock[0].name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "getState"

  xml_content = file("./api/ecommerce-mock/npg/v1/get_state.xml.tpl")
}

resource "azurerm_api_management_api_operation_policy" "get_card_data" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_npg_mock[0].name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "getCardData"

  xml_content = file("./api/ecommerce-mock/npg/v1/get_card_data.xml.tpl")
}

resource "azurerm_api_management_api_operation_policy" "refund_payment" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_npg_mock[0].name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "refundPayment"

  xml_content = file("./api/ecommerce-mock/npg/v1/refund_payment.xml.tpl")
}

resource "azurerm_api_management_api_operation_policy" "get_order" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_npg_mock[0].name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "getOrder"

  xml_content = file("./api/ecommerce-mock/npg/v1/get_order.xml.tpl")
}

####################################
## API Mock for Node Forwarder    ##
####################################
locals {
  apim_ecommerce_node_forwarder_mock_api = {
    display_name          = "ecommerce pagoPA - Node Forwarder mock"
    description           = "API to support integration testing"
    path                  = "ecommerce/mock/node-forwader"
    subscription_required = true
    service_url           = null
    enabled               = var.env_short == "u" ? 1 : 0
  }
}

resource "azurerm_api_management_api_version_set" "apim_ecommerce_node_forwarder_mock_api" {
  count               = local.apim_ecommerce_node_forwarder_mock_api.enabled
  name                = "${local.project}-node-forwarder-mock"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_node_forwarder_mock_api.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_ecommerce_node_forwarder_mock" {
  count = local.apim_ecommerce_node_forwarder_mock_api.enabled

  name                  = "${local.project}-node-forwarder-mock"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  subscription_required = local.apim_ecommerce_node_forwarder_mock_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_ecommerce_node_forwarder_mock_api[0].id
  version               = "v1"
  revision              = "1"

  description  = local.apim_ecommerce_node_forwarder_mock_api.description
  display_name = local.apim_ecommerce_node_forwarder_mock_api.display_name
  path         = local.apim_ecommerce_node_forwarder_mock_api.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_node_forwarder_mock_api.service_url

  import {
    content_format = "openapi"
    content_value = templatefile("./api/ecommerce-mock/node-forwarder/v1/_openapi.json.tpl", {
      host = local.apim_hostname
    })
  }
}

resource "azurerm_api_management_product_api" "apim_ecommerce_node_forwarder_mock_product_api" {
  count               = local.apim_ecommerce_node_forwarder_mock_api.enabled
  api_name            = azurerm_api_management_api.apim_ecommerce_node_forwarder_mock[0].name
  product_id          = module.apim_ecommerce_product.product_id
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
}

resource "azurerm_api_management_api_policy" "apim_ecommerce_node_forwarder_mock_policy" {
  count               = local.apim_ecommerce_node_forwarder_mock_api.enabled
  api_name            = azurerm_api_management_api.apim_ecommerce_node_forwarder_mock[0].name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  xml_content = file("./api/ecommerce-mock/node-forwarder/v1/_base_policy.xml.tpl")
}

#############################
## API GMP NPG             ##
#############################
locals {
  apim_ecommerce_gmp_mock_api = {
    display_name          = "eCommerce pagoPA - GMP mock"
    description           = "API to support integration testing"
    path                  = "ecommerce/mock/gmp"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "apim_ecommerce_gmp_mock_api" {
  count               = var.env_short == "u" ? 1 : 0
  name                = "${local.project}-gmp-mock"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_gmp_mock_api.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_ecommerce_gmp_mock" {
  count                 = var.env_short == "u" ? 1 : 0
  name                  = "${local.project}-gmp-mock"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  subscription_required = local.apim_ecommerce_gmp_mock_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_ecommerce_gmp_mock_api[0].id
  version               = "v1"
  revision              = "1"

  description  = local.apim_ecommerce_gmp_mock_api.description
  display_name = local.apim_ecommerce_gmp_mock_api.display_name
  path         = local.apim_ecommerce_gmp_mock_api.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_gmp_mock_api.service_url

  import {
    content_format = "openapi"
    content_value = templatefile("./api/ecommerce-mock/gmp/v1/_openapi.json.tpl", {
      host = local.apim_hostname
    })
  }
}

resource "azurerm_api_management_product_api" "apim_ecommerce_gmp_mock_product_api" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_gmp_mock[0].name
  product_id          = module.apim_ecommerce_product.product_id
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
}

resource "azurerm_api_management_api_policy" "apim_ecommerce_gmp_mock_policy" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_gmp_mock[0].name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  xml_content = file("./api/ecommerce-mock/gmp/v1/_base_policy.xml.tpl")
}

resource "azurerm_api_management_api_operation_policy" "post_payment_methods_search" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_gmp_mock[0].name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "searchPaymentMethods"

  xml_content = file("./api/ecommerce-mock/gmp/v1/post_payment_methods_search.xml")
}

resource "azurerm_api_management_api_operation_policy" "get_payment_method" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_gmp_mock[0].name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "getPaymentMethod"

  xml_content = file("./api/ecommerce-mock/gmp/v1/get_payment_method.xml")
}