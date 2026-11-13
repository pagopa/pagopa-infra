locals {
  node_forwarder_suffix = var.enabled_features.node_forwarder_ha ? "-ha" : ""

  node_forwarder_dashboard_json = jsondecode(templatefile("./dashboards/node-forwarder-dashboard.json.tpl", {
    subscription_id     = data.azurerm_subscription.current.subscription_id
    env_short           = var.env_short
    product             = local.product
    monitor_rg          = var.monitor_resource_group_name
    appinsights_name    = local.monitor_appinsights_name
    apim_name           = local.pagopa_apim_name
    apim_rg             = local.pagopa_apim_rg
    forwarder_rg        = "${local.product}-node-forwarder-rg"
    forwarder_app_name  = "${local.product}-${var.location_short}-core-app-node-forwarder${local.node_forwarder_suffix}"
    forwarder_plan_name = "${local.product}-${var.location_short}-core-plan-node-forwarder${local.node_forwarder_suffix}"
  }))
}

resource "azurerm_portal_dashboard" "node_forwarder_dashboard" {
  count               = var.env_short != "d" ? 1 : 0
  name                = "${var.env_short}_node-forwarder-dashboard"
  resource_group_name = var.monitor_resource_group_name
  location            = var.location
  tags = {
    source = "terraform"
  }
  #convert json dashboard output from Azure export function to the one handled by azurerm portal dashboard provider
  #see https://github.com/hashicorp/terraform-provider-azurerm/issues/27117 issue for more info
  dashboard_properties = jsonencode(
    merge(
      local.node_forwarder_dashboard_json.properties,
      {
        "lenses" = {
          for lens_index, lens in local.node_forwarder_dashboard_json.properties.lenses :
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
