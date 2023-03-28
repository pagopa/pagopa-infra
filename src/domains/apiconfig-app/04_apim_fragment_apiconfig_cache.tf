resource "azapi_resource" "generate_cache_fragment" {
  # provider  = azapi.apim
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "cache-generation"
  parent_id = data.azurerm_api_management.apim.id

  body = jsonencode({
    properties = {
      description = "Logic about cache generation"
      format      = "rawxml"
      value       = file("./api/apiconfig-cache/node/generate_cache_fragment.xml")
    }
  })

  lifecycle {
    ignore_changes = [output]
  }
}
