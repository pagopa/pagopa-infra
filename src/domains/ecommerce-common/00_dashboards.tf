resource "azurerm_portal_dashboard" "ecommerce_mongodb_dashboard" {
  count               = var.env_short == "d" ? 1 : 0
  name                = "ecommerce-mongodb-dashboard"
  resource_group_name = var.monitor_resource_group_name
  location            = var.location
  tags = {
    source = "terraform"
  }
  #convert json dashboard output from Azure export function to the one handled by azurerm portal dashboard provider
  #see https://github.com/hashicorp/terraform-provider-azurerm/issues/27117 issue for more info
  dashboard_properties = jsonencode(
      {
        "lenses" = {
          for lens_index, lens in jsondecode(file("./dashboards/eCommerce CDC Mongo DB monitoring.json")).properties.lenses :
          tostring(lens_index) => merge(lens, {
            "parts" = {
              for part_index, part in lens.parts :
              tostring(part_index) => part
            }
          })
        }
      }
    )
  
}