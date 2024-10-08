locals {
  subnet_in_nat_gw_ids = var.is_feature_enabled.node_forwarder_ha_enabled ? [] : [
    module.node_forwarder_snet[0].id #pagopa-node-forwarder ( aka GAD replacemnet )
  ]

  zones = ["1"]
}

resource "azurerm_public_ip" "nat_ip_2" {
  name                = "${local.product}-natgw-pip-2"
  location            = azurerm_resource_group.rg_vnet.location
  resource_group_name = azurerm_resource_group.rg_vnet.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = local.zones

  tags = var.tags
}

resource "azurerm_public_ip" "nat_ip_3" {
  name                = "${local.product}-natgw-pip-3"
  location            = azurerm_resource_group.rg_vnet.location
  resource_group_name = azurerm_resource_group.rg_vnet.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = local.zones

  tags = var.tags
}

module "nat_gw" {
  count  = var.nat_gateway_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//nat_gateway?ref=75056c7"

  name                = format("%s-natgw", local.product)
  resource_group_name = azurerm_resource_group.rg_vnet.name
  location            = azurerm_resource_group.rg_vnet.location
  public_ips_count    = var.nat_gateway_public_ips
  zones               = local.zones
  subnet_ids          = local.subnet_in_nat_gw_ids
  additional_public_ip_ids = [azurerm_public_ip.nat_ip_2.id, azurerm_public_ip.nat_ip_3.id]

  tags = var.tags
}


# https://learn.microsoft.com/en-us/azure/nat-gateway/nat-gateway-resource#snat-ports
resource "azurerm_monitor_metric_alert" "snat_connection_over_10K" {
  count = (var.env_short == "p" && var.nat_gateway_enabled) ? 1 : 0

  name                = "${local.product}-natgw-connetion-over-45k"
  resource_group_name = azurerm_resource_group.monitor_rg.name
  scopes              = [module.nat_gw[0].id]
  description         = "Total SNAT connections over 45K"
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
    threshold              = "45000" # Each NAT gateway public IP address provides 64,512 SNAT ports to make outbound connections
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
