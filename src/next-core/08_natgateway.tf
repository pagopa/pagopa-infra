locals {
  subnet_in_nat_gw_ids = var.is_feature_enabled.node_forwarder_ha_enabled ? [] : [
    module.node_forwarder_snet[0].id #pagopa-node-forwarder ( aka GAD replacemnet )
  ]

  zones = ["1"]
}

resource "azurerm_public_ip" "nat_ip_03" {
  count               = var.env == "p" ? 1 : 0
  name                = "${local.product}-natgw-pip-03"
  location            = azurerm_resource_group.rg_vnet.location
  resource_group_name = azurerm_resource_group.rg_vnet.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = local.zones

  tags = module.tag_config.tags
}

resource "azurerm_public_ip" "nat_ip_04" {
  count               = var.env == "p" ? 1 : 0
  name                = "${local.product}-natgw-pip-04"
  location            = azurerm_resource_group.rg_vnet.location
  resource_group_name = azurerm_resource_group.rg_vnet.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = local.zones

  tags = module.tag_config.tags
}

module "nat_gw" {
  count  = var.nat_gateway_enabled ? 1 : 0
  source = "./.terraform/modules/__v4__/nat_gateway"

  name                = format("%s-natgw", local.product)
  resource_group_name = azurerm_resource_group.rg_vnet.name
  location            = azurerm_resource_group.rg_vnet.location
  public_ips_count    = var.nat_gateway_public_ips
  zones               = local.zones
  subnet_ids          = local.subnet_in_nat_gw_ids
  # commented out, waiting for EC to allow the new ips
  #   additional_public_ip_ids = var.env == "p" ? [azurerm_public_ip.nat_ip_03[0].id, azurerm_public_ip.nat_ip_04[0].id] : []

  tags = module.tag_config.tags
}


# https://learn.microsoft.com/en-us/azure/nat-gateway/nat-gateway-resource#snat-ports
resource "azurerm_monitor_metric_alert" "snat_connection_over_10K" {
  count = (var.env_short == "p" && var.nat_gateway_enabled) ? 1 : 0

  name                = "${local.product}-natgw-connetion-over-45k"
  resource_group_name = azurerm_resource_group.monitor_rg.name
  scopes              = [module.nat_gw[0].id]
  description         = "${local.product}-natgw Total SNAT connections over 45K"
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
  action {
    action_group_id = azurerm_monitor_action_group.infra_opsgenie.0.id
  }

  tags = module.tag_config.tags
}
