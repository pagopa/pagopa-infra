resource "azurerm_resource_group" "load_test" {

  name     = "${var.prefix}-${var.env_short}-load-test-rg"
  location = var.location

}

module "grafana_managed" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//grafana?ref=feature/grafana"

  name = "${var.env_short}-grafana"

  resource_group_name = azurerm_resource_group.load_test.name

  tags = var.tags

}

resource "azurerm_dns_cname_record" "grafana" {

  name                = "grafana.${var.dns_zone_prefix}.${var.external_domain}"
  zone_name           = var.dns_zone_prefix
  resource_group_name = local.vnet_resource_group_name
  ttl                 = 3600
  record              = module.grafana_managed.endpoint

  tags = var.tags
}
