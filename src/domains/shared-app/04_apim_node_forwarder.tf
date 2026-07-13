##############
## Products ##
##############

module "apim_node_forwarder_product" {
  source = "./.terraform/modules/__v3__/api_management_product"


  product_id   = "product-node-forwarder"
  display_name = "pagoPA Node Forwarder API"
  description  = "Product pagoPA Node Forwarder API"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/node_forwarder_api/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "node_forwarder_api" {

  name                = "${var.env_short}-node-forwarder-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "pagoPA Node Forwarder API"
  versioning_scheme   = "Segment"
}

module "apim_node_forwarder_api" {
  source = "./.terraform/modules/__v3__/api_management_api"


  name                  = "${var.env_short}-node-forwarder-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_node_forwarder_product.product_id, "apim_for_node"]
  subscription_required = true

  version_set_id = azurerm_api_management_api_version_set.node_forwarder_api.id
  api_version    = "v1"

  description  = "API pagoPA Node Forwarder"
  display_name = "pagoPA Node Forwarder API"
  path         = "pagopa-node-forwarder/api"
  protocols    = ["https"]

  service_url = var.enabled_features.node_forwarder_ha ? "https://${data.azurerm_app_service.node_forwarder_ha[0].default_site_hostname}" : "https://${data.azurerm_app_service.node_forwarder[0].default_site_hostname}"

  content_format = "openapi"
  content_value = templatefile("./api/node_forwarder_api/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/node_forwarder_api/v1/_base_policy.xml", {
    node_forwarder_host_path = var.enabled_features.node_forwarder_ha ? "https://${data.azurerm_app_service.node_forwarder_ha[0].default_site_hostname}" : "https://${data.azurerm_app_service.node_forwarder[0].default_site_hostname}"
  })



}

