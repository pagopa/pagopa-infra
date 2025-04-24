# Example 👇
#
# resource "azurerm_api_management_subscription" "nodo_subkey" {
#   api_management_name = data.azurerm_api_management.apim.name
#   resource_group_name = data.azurerm_api_management.apim.resource_group_name
#   product_id          = data.azurerm_api_management_product.apim_node_for_psp_product.id
#   display_name        = "Subscription MBD Node for PSP APIM"
#   allow_tracing       = false
#   state               = "active"
# }