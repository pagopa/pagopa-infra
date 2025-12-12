resource "azurerm_portal_dashboard" "pay_wallet_api_monitoring_dashboard" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "pay-wallet-api-monitoring-dashboard"
  resource_group_name = var.monitor_italy_resource_group_name
  location            = var.location
  tags = {
    source = "terraform"
  }
  #convert json dashboard output from Azure export function to the one handled by azurerm portal dashboard provider
  #see https://github.com/hashicorp/terraform-provider-azurerm/issues/27117 issue for more info
  dashboard_properties = jsonencode(
    merge(
      jsondecode(file("./dashboards/pay-wallet-api-monitoring-dashboard.json")).properties,
      {
        "lenses" = {
          for lens_index, lens in jsondecode(file("./dashboards/pay-wallet-api-monitoring-dashboard.json")).properties.lenses :
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
