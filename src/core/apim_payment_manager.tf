##############
## Products ##
##############

module "apim_payment_manager_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "payment-manager"
  display_name = "Payment Manager pagoPA"
  description  = "Product for Payment Manager pagoPA"

  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/payment_manager_api/_base_policy.xml")
}


data "azurerm_key_vault_secret" "pm_restapi_ip" {
  name         = "pm-restapi-ip"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}


locals {
  apim_pm_restapicd_internal_api = {
    # params for all api versions
    display_name          = "Payment Manager internal restapi CD API"
    description           = "API to support internal api exposed for payment transacions gateway"
    path                  = "payment-manager/internal/pp-restapi-cd"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "pm_restapicd_internal_api" {

  name                = "${local.project}-pm-restapicd-internal-api"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_pm_restapicd_internal_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_restapicd_internal_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = "${local.project}-pm-restapicd-internal-api"
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_restapicd_internal_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pm_restapicd_internal_api.id
  api_version           = "v1"
  service_url           = local.apim_pm_restapicd_internal_api.service_url

  description  = local.apim_pm_restapicd_internal_api.description
  display_name = local.apim_pm_restapicd_internal_api.display_name
  path         = local.apim_pm_restapicd_internal_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/restapi-cd-internal/v1/_swagger.json.tpl", {
    host = local.api_domain
  })

  xml_content = file("./api/payment_manager_api/restapi-cd-internal/v1/_base_policy.xml.tpl")
}

module "apim_pm_restapicd_internal_api_v2" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = "${local.project}-pm-restapicd-internal-api"
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_restapicd_internal_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pm_restapicd_internal_api.id
  api_version           = "v2"
  service_url           = local.apim_pm_restapicd_internal_api.service_url

  description  = local.apim_pm_restapicd_internal_api.description
  display_name = local.apim_pm_restapicd_internal_api.display_name
  path         = local.apim_pm_restapicd_internal_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/restapi-cd-internal/v2/_swagger.json.tpl", {
    host = local.api_domain
  })

  xml_content = file("./api/payment_manager_api/restapi-cd-internal/v2/_base_policy.xml.tpl")
}


######################
## API PM per Nodo  ##
######################
locals {
  apim_pm_per_nodo_api = {
    # params for all api versions
    display_name             = "Payment Manager - PM per Nodo API"
    description              = "API PM for Nodo"
    path                     = "payment-manager/pm-per-nodo"
    subscription_required_v1 = true
    subscription_required_v2 = true
    service_url              = null
  }
}

resource "azurerm_api_management_api_version_set" "pm_per_nodo_api" {

  name                = "${local.project}-pm-per-nodo-api"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_pm_per_nodo_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_per_nodo_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = "${local.project}-pm-per-nodo-api"
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id, local.apim_x_node_product_id]
  subscription_required = local.apim_pm_per_nodo_api.subscription_required_v1
  version_set_id        = azurerm_api_management_api_version_set.pm_per_nodo_api.id
  api_version           = "v1"
  service_url           = local.apim_pm_per_nodo_api.service_url

  description  = local.apim_pm_per_nodo_api.description
  display_name = local.apim_pm_per_nodo_api.display_name
  path         = local.apim_pm_per_nodo_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/pm-per-nodo/v1/_swagger.json.tpl", {
    host = local.api_domain
  })

  xml_content = file("./api/payment_manager_api/pm-per-nodo/v1/_base_policy.xml.tpl")
}

module "apim_pm_per_nodo_v2" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = "${local.project}-pm-per-nodo-api"
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id, local.apim_x_node_product_id]
  subscription_required = local.apim_pm_per_nodo_api.subscription_required_v2
  version_set_id        = azurerm_api_management_api_version_set.pm_per_nodo_api.id
  api_version           = "v2"
  service_url           = local.apim_pm_per_nodo_api.service_url

  description  = local.apim_pm_per_nodo_api.description
  display_name = local.apim_pm_per_nodo_api.display_name
  path         = local.apim_pm_per_nodo_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/payment_manager_api/pm-per-nodo/v2/_openapi.json.tpl", {
    host = local.api_domain
  })

  xml_content = file("./api/payment_manager_api/pm-per-nodo/v2/_base_policy.xml")
}

# Payment Manager - PM per Nodo API
#
# v1 -> src/core/api/payment_manager_api/pm-per-nodo/v1/_swagger.json.tpl - NOT used into WISP dismantling
#   "/payments/send-payment-result" - "operationId": "sendPaymentResult"
#
# v2 -> src/core/api/payment_manager_api/pm-per-nodo/v2/_openapi.json.tpl
#   "/transactions/{transactionId}/user-receipts" - "operationId": "addUserReceipt"
#
# WISP sendPaymentResultV2
resource "azurerm_api_management_api_operation_policy" "send_payment_result_api_v2_wisp_policy" { # aka addUserReceipt
  count               = var.create_wisp_converter ? 1 : 0
  api_name            = "${local.project}-pm-per-nodo-api-v2"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  operation_id        = "addUserReceipt"
  xml_content = templatefile(var.env_short == "u" ? "./api/payment_manager_api/pm-per-nodo/v2/wisp-sendpaymentresult-uat.xml.tpl" : "./api/payment_manager_api/pm-per-nodo/v2/wisp-sendpaymentresult.xml.tpl", {
    host                       = local.api_domain,
    ecommerce_ingress_hostname = var.ecommerce_ingress_hostname
  })
}

resource "terraform_data" "sha256_send_payment_result_api_v2_wisp_policy" {
  input = sha256(file("./api/payment_manager_api/pm-per-nodo/v2/wisp-sendpaymentresult.xml.tpl"))
}


############################
## API COBAdGE            ##
############################
locals {
  apim_pm_cobadge_api = {
    display_name          = "Payment Manager cobadge API"
    description           = "API to support cobadge payments"
    path                  = "payment-manager/clients/cobadge"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "apim_pm_cobadge_api" {

  name                = format("%s-pm-cobadge-api", local.project)
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_pm_cobadge_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_cobadge_api_v4" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-pm-cobadge-api", local.project)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_cobadge_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_pm_cobadge_api.id
  api_version           = "v4"
  service_url           = local.apim_pm_cobadge_api.service_url

  description  = local.apim_pm_cobadge_api.description
  display_name = local.apim_pm_cobadge_api.display_name
  path         = local.apim_pm_cobadge_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/clients/cobadge/v4/_swagger.json.tpl", {
    host = local.api_domain
  })

  xml_content = templatefile("./api/payment_manager_api/clients/cobadge/v4/_base_policy.xml.tpl", {
    endpoint = format("https://%s/cobadge/api/pagopa/banking/v4.0", var.cobadge_hostname)
  })
}
