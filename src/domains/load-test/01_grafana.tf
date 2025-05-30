resource "azurerm_resource_group" "load_test" {

  name     = "${local.product}-load-test-rg"
  location = var.location

}

module "grafana_managed" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//grafana?ref=v3.4.3"

  name = "${local.product}-grafana"

  resource_group_name = azurerm_resource_group.load_test.name

  api_key_enabled = true

  tags = module.tag_config.tags

}

resource "azurerm_dns_cname_record" "grafana" {

  name                = "grafana"
  zone_name           = var.dns_zone_prefix
  resource_group_name = local.vnet_resource_group_name
  ttl                 = 3600
  record              = module.grafana_managed.hostname

  tags = module.tag_config.tags
}
