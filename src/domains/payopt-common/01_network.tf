resource "azurerm_private_dns_a_record" "ingress" {
  name                = local.ingress_hostname
  zone_name           = data.azurerm_private_dns_zone.internal.name
  resource_group_name = local.internal_dns_zone_resource_group_name
  ttl                 = 3600
  records             = [var.ingress_load_balancer_ip]
}

resource "azurerm_subnet" "eventhub_italy" {
  name                              = "${local.project}-eventhub-snet"
  resource_group_name               = data.azurerm_resource_group.rg_vnet_italy.name
  virtual_network_name              = data.azurerm_virtual_network.vnet_italy.name
  address_prefixes                  = var.cidr_paymentoptions_eventhub_italy
  private_endpoint_network_policies = "Enabled"
}
