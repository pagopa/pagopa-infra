resource "azurerm_portal_dashboard" "checkout_authenticated_payment_flow_dashboard" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "checkout-authenticated-payment-flow-dashboard"
  resource_group_name = var.monitor_resource_group_name
  location            = var.location
  tags = {
    source = "terraform"
  }
  #convert json dashboard output from Azure export function to the one handled by azurerm portal dashboard provider
  #see https://github.com/hashicorp/terraform-provider-azurerm/issues/27117 issue for more info
  dashboard_properties = jsonencode(
    merge(
      jsondecode(file("./dashboards/checkout-authenticated-payment-flow-dashboard.json")).properties,
      {
        "lenses" = {
          for lens_index, lens in jsondecode(file("./dashboards/checkout-authenticated-payment-flow-dashboard.json")).properties.lenses :
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

resource "azurerm_portal_dashboard" "checkout_cart_integration_dashboard" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "checkout-cart-integration-dashboard"
  resource_group_name = var.monitor_resource_group_name
  location            = var.location
  tags = {
    source = "terraform"
  }
  #convert json dashboard output from Azure export function to the one handled by azurerm portal dashboard provider
  #see https://github.com/hashicorp/terraform-provider-azurerm/issues/27117 issue for more info
  dashboard_properties = jsonencode(
    merge(
      jsondecode(file("./dashboards/checkout-cart-integration-dashboard.json")).properties,
      {
        "lenses" = {
          for lens_index, lens in jsondecode(file("./dashboards/checkout-cart-integration-dashboard.json")).properties.lenses :
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

