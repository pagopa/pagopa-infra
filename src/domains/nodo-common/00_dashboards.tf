resource "azurerm_portal_dashboard" "opex_pagopa_nodo_auth" {
  count               = var.env_short != "d" ? 1 : 0
  name                = "opex_pagopa-nodo-auth"
  resource_group_name = var.monitor_resource_group_name
  location            = var.location
  tags = {
    source = "terraform"
  }
  #convert json dashboard output from Azure export function to the one handled by azurerm portal dashboard provider
  #see https://github.com/hashicorp/terraform-provider-azurerm/issues/27117 issue for more info
  dashboard_properties = jsonencode(
    merge(
      jsondecode(file("./dashboards/opex_pagopa-nodo-auth.json")).properties,
      {
        "lenses" = {
          for lens_index, lens in jsondecode(file("./dashboards/opex_pagopa-nodo-auth.json")).properties.lenses :
          tostring(lens_index) => merge(lens, {
            "parts" = {
              for part_index, part in lens.parts :
              tostring(part_index) => part
            }
          })
        }
      }
    )
  )
}
