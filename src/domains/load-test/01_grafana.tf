module "grafana_managed" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//grafana?ref=feature/grafana"

  name = format("%s-grafana", var.env_short)

  resource_group_name = var.terraform_remote_state_core.resource_group_name

  tags = var.tags

}

resource "azurerm_dns_cname_record" "grafana" {

  name                = format("%s.%s.%s", "grafana", var.dns_zone_prefix, var.external_domain)
  zone_name           = var.dns_zone_prefix
  resource_group_name = var.terraform_remote_state_core.resource_group_name
  ttl                 = 3600
  record              = module.grafana_managed.endpoint

  tags = var.tags
}
