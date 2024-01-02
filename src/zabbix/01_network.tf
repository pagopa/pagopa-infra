# data "azurerm_private_dns_zone" "internal" {
#   name                = local.internal_dns_zone_name
#   resource_group_name = local.internal_dns_zone_resource_group_name
# }

# resource "azurerm_private_dns_a_record" "ingress" {
#   name                = local.ingress_hostname_prefix
#   zone_name           = data.azurerm_private_dns_zone.internal.name
#   resource_group_name = local.internal_dns_zone_resource_group_name
#   ttl                 = 3600
#   records             = ["10.11.100.250"]
# }
