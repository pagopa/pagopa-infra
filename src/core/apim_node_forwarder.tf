##############
## Products ##
##############

module "apim_node_forwarder_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "product-node-forwarder"
  display_name = "pagoPA Node Forwarder API"
  description  = "Product pagoPA Node Forwarder API"

  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/node_forwarder_api/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "node_forwarder_api" {

  name                = "${var.env_short}-node-forwarder-api"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = "pagoPA Node Forwarder API"
  versioning_scheme   = "Segment"
}

module "apim_node_forwarder_api" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = "${var.env_short}-node-forwarder-api"
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_node_forwarder_product.product_id, local.apim_x_node_product_id]
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
    host = local.api_domain
  })

  xml_content = templatefile("./api/node_forwarder_api/v1/_base_policy.xml", {
    node_forwarder_host_path = var.enabled_features.node_forwarder_ha ? "https://${data.azurerm_app_service.node_forwarder_ha[0].default_site_hostname}" : "https://${data.azurerm_app_service.node_forwarder[0].default_site_hostname}"
  })



}
