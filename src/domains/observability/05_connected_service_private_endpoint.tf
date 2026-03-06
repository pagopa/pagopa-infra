resource "azurerm_data_factory_managed_private_endpoint" "df_connection_managed_private_endpoint" {
  for_each           = local.data_factory_managed_private_endpoint
  name               = "AzureDataFactoryTo${each.key}"
  data_factory_id    = data.azurerm_data_factory.obeserv_data_factory.id
  target_resource_id = each.value.target_resource_id
  fqdns              = each.value.fqdns
  subresource_name   = each.value.subresource_name

  lifecycle {

    precondition {
      condition     = length([for k, v in local.data_factory_managed_private_endpoint : k if v.type == "postgres"]) <= 1
      error_message = "Only one element in local.data_factory_managed_private_endpoint can have type 'postgres'. Multiple linked services must share the same private endpoint"
    }

    precondition {
      condition     = alltrue([for k, v in local.data_factory_managed_private_endpoint : contains(keys(local.az_api_type_mappings), v.type)])
      error_message = "All elements in local.data_factory_managed_private_endpoint must have a 'type' that is a valid key in local.az_api_type_mappings."
    }
  }
}

data "azapi_resource" "df_connection_privatelink_private_endpoint_connection" {
  # only those who require a private endpoint
  for_each               = local.data_factory_managed_private_endpoint
  type                   = local.az_api_type_mappings[each.value.type].data_az_api_type
  resource_id            = each.value.target_resource_id
  response_export_values = ["properties.privateEndpointConnections."]

  depends_on = [
    azurerm_data_factory_managed_private_endpoint.df_connection_managed_private_endpoint
  ]
}


locals {
  # conn.id if conn.properties.privateLinkServiceConnectionState.status == "Pending" &&
  connection_to_approve = {
    for key, value in local.data_factory_managed_private_endpoint :
    key => [
      for conn in data.azapi_resource.df_connection_privatelink_private_endpoint_connection[key].output.properties.privateEndpointConnections :
      conn.id if strcontains(conn.properties.privateEndpoint.id, azurerm_data_factory_managed_private_endpoint.df_connection_managed_private_endpoint[key].name)
    ]
  }
}

resource "azapi_resource_action" "df_connection_approve_private_endpoint_connection" {
  # only those who require a private endpoint approval
  for_each    = local.data_factory_managed_private_endpoint
  type        = local.az_api_type_mappings[each.value.type].approve_az_api_type
  resource_id = try(local.connection_to_approve[each.key][0], null)
  method      = "PUT"

  body = {
    properties = {
      privateLinkServiceConnectionState = {
        description = "Approved via Terraform - ${azurerm_data_factory_managed_private_endpoint.df_connection_managed_private_endpoint[each.key].name} df connection" # To identify which managed private endpoint this connection belongs to we add the managed private endpoint name to the description
        status      = "Approved"
      }
    }
  }


  lifecycle {
    precondition {
      condition     = length(local.connection_to_approve[each.key]) > 0
      error_message = "No private endpoint connection found to approve for managed private endpoint '${azurerm_data_factory_managed_private_endpoint.df_connection_managed_private_endpoint[each.key].name}'. This can happen if the connection is already approved or if the name-matching heuristic does not match any connection."
    }
  }
}






