# ndphost header
resource "terraform_data" "sha256_ndphost_header" {
  input = sha256(templatefile("./api_product/nodo_pagamenti_api/ndphost_header.xml.tpl", {
    content = file("./api_product/nodo_pagamenti_api/env/${var.env}/ndphost_header.xml")
  }))
}
resource "azapi_resource" "ndphost_header" {
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "ndphost-header"
  parent_id = data.azurerm_api_management.apim.id

  body = jsonencode({
    properties = {
      description = "Setting header about ndphost"
      format      = "rawxml"
      value       = templatefile("./api_product/nodo_pagamenti_api/ndphost_header.xml.tpl", {
        content = file("./api_product/nodo_pagamenti_api/env/${var.env}/ndphost_header.xml")
      })
    }
  })

  lifecycle {
    ignore_changes = [output]
  }
}
