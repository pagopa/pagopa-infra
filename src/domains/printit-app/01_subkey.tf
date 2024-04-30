# PDF engine nodejs for PDF engine Java
resource "azurerm_api_management_subscription" "pdf_engine_node_subkey" {
  count = var.is_feature_enabled.pdf_engine ? 1 : 0

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = data.azurerm_api_management_product.pdf_engine_product.product_id
  display_name        = "PDF Engine NodeJS for Java"
  allow_tracing       = false

}
