resource "azurerm_private_dns_a_record" "ingress_haproxy" {
  name                = local.ingress_haproxy_hostname
  zone_name           = data.azurerm_private_dns_zone.internal.name
  resource_group_name = local.internal_dns_zone_resource_group_name
  ttl                 = 3600
  records             = [var.ingress_haproxy_load_balancer_ip]
}
