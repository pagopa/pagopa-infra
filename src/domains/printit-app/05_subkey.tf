# PDF engine nodejs for PDF engine Java
resource "azurerm_api_management_subscription" "pdf_engine_node_subkey" {
  count = var.is_feature_enabled.pdf_engine ? 1 : 0

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = module.apim_pdf_engine_product[0].id
  display_name        = "PDF Engine NodeJS for Java"
  allow_tracing       = false
  state               = "active"
}

resource "azurerm_api_management_subscription" "generator_for_service_subkey" {
  count = var.is_feature_enabled.pdf_engine ? 1 : 0

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = module.apim_notices_generator_product[0].id
  display_name        = "Notice Generator for Notice Service"
  allow_tracing       = false
  state               = "active"
}

resource "azurerm_api_management_subscription" "pdf_engine_subkey" {
  count = var.is_feature_enabled.pdf_engine ? 1 : 0

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = module.apim_pdf_engine_product[0].id
  display_name        = "PDF Engine for Notice"
  allow_tracing       = false
  state               = "active"
}


resource "azurerm_api_management_subscription" "api_config_subkey" {
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = data.azurerm_api_management_product.apim_api_config_product.id
  display_name        = "Subscription for Api Config APIM"
  allow_tracing       = false
  state               = "active"
}

// Subkey for CIE PDF Engine
resource "azurerm_api_management_subscription" "receipt_service_helpdesk_subkey" {
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  api_id              = replace(module.apim_api_pdf_engine_cie_api_v1.id, ";rev=1", "")
  display_name        = "Subscription for PDF Engine for CIE Notice"
  allow_tracing       = false
  state               = "active"
}
