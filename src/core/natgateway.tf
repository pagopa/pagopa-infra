locals {
  subnet_in_nat_gw_ids = [
    module.node_forwarder_snet.id # pagopa-node-forwarder ( aka GAD replacemnet )
  ]
}

module "nat_gw" {
  count  = var.nat_gateway_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//nat_gateway?ref=v1.0.90"

  name                = format("%s-natgw", local.project)
  resource_group_name = azurerm_resource_group.rg_vnet.name
  location            = azurerm_resource_group.rg_vnet.location
  public_ips_count    = var.nat_gateway_public_ips
  zone                = "1"
  subnet_ids          = local.subnet_in_nat_gw_ids

  tags = var.tags
}


# https://learn.microsoft.com/en-us/azure/nat-gateway/nat-gateway-resource#snat-ports
resource "azurerm_monitor_metric_alert" "snat_connection_over_10K" {
  count = (var.env_short == "p" && var.nat_gateway_enabled) ? 1 : 0

  name                = "${local.project}-natgw-connetion-over-30k"
  resource_group_name = azurerm_resource_group.monitor_rg.name
  scopes              = [module.nat_gw[0].id]
  description         = "Total SNAT connections over 30K"
  severity            = 3
  frequency           = "PT5M"
  window_size         = "PT5M"

  target_resource_type     = "Microsoft.Network/natGateways"
  target_resource_location = var.location

  # https://learn.microsoft.com/it-it/azure/load-balancer/load-balancer-outbound-connections#what-are-snat-ports
  criteria {
    metric_namespace       = "Microsoft.Network/natGateways"
    metric_name            = "SNATConnectionCount"
    aggregation            = "Total"
    operator               = "GreaterThan"
    threshold              = "30000" # Each NAT gateway public IP address provides 64,512 SNAT ports to make outbound connections
    skip_metric_validation = false
  }

  action {
    action_group_id = azurerm_monitor_action_group.slack.id
  }
  action {
    action_group_id = azurerm_monitor_action_group.email.id
  }
  action {
    action_group_id = azurerm_monitor_action_group.new_conn_srv_opsgenie[0].id
  }

  tags = var.tags
}