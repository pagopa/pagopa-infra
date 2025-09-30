
data "azurerm_private_link_service" "vmss_pls" {
  name                = "${local.product_network}-privatelink"
  resource_group_name = "${local.product_network}-vmss-rg"
}

data "azurerm_key_vault_secret" "database_proxy_fqdn" {
  name         = "${var.prefix}-${var.env_short}-${var.location_short}-network-database-map"
  key_vault_id = data.azurerm_key_vault.network_kv.id
}

###
### FQDN:  Changing this forces a new resource to be created.
resource "azurerm_data_factory_managed_private_endpoint" "private_endpoint" {
  name               = "AzureDataFactoryToVMSSProxy"
  data_factory_id    = data.azurerm_data_factory.obeserv_data_factory.id
  target_resource_id = data.azurerm_private_link_service.vmss_pls.id
  fqdns              = split(",", data.azurerm_key_vault_secret.database_proxy_fqdn.value)
}


data "azapi_resource" "privatelink_private_endpoint_connection" {
  type                   = "Microsoft.Network/privateLinkServices@2022-09-01"
  resource_id            = data.azurerm_private_link_service.vmss_pls.id
  response_export_values = ["properties.privateEndpointConnections."]

  depends_on = [
    azurerm_data_factory_managed_private_endpoint.private_endpoint
  ]
}

locals {

  ## Extract private endpoint connection names
  ## PrivateLink

  privatelink_private_endpoint_connection_name = data.azapi_resource.privatelink_private_endpoint_connection.output.properties.privateEndpointConnections[0].name
}


resource "azapi_resource_action" "approve_privatelink_private_endpoint_connection" {
  type        = "Microsoft.Network/privateLinkServices/privateEndpointConnections@2022-09-01"
  resource_id = "${data.azurerm_private_link_service.vmss_pls.id}/privateEndpointConnections/${local.privatelink_private_endpoint_connection_name}"
  method      = "PUT"

  body = {
    properties = {
      privateLinkServiceConnectionState = {
        description = "Approved via Terraform - ${azurerm_data_factory_managed_private_endpoint.private_endpoint.name}" # To identify which managed private endpoint this connection belongs to we add the managed private endpoint name to the description
        status      = "Approved"
      }
    }
  }
}

# resource "azapi_resource_action" "delete_privatelink_private_endpoint_connection" {
#   type        = "Microsoft.Network/privateLinkServices/privateEndpointConnections@2022-09-01"
#   resource_id = "${data.azurerm_private_link_service.vmss_pls.id}/privateEndpointConnections/${local.privatelink_private_endpoint_connection_name}"
#   method      = "DELETE"
#   when        = "destroy"
# }