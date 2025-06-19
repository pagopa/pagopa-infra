# resource "azurerm_dns_zone" "selc_public" {
#   count               = (var.dns_zone_selc == null || var.external_domain == null) ? 0 : 1
#   name                = join(".", [var.dns_zone_selc, var.external_domain])
#   resource_group_name = data.azurerm_resource_group.rg_vnet.name

#   tags = module.tag_config.tags
# }

# //Prod ONLY record to DEV public DNS delegation
# resource "azurerm_dns_ns_record" "dev_selc" {
#   count               = var.env_short == "p" ? 1 : 0
#   name                = "dev"
#   zone_name           = azurerm_dns_zone.selc_public[0].name
#   resource_group_name = data.azurerm_resource_group.rg_vnet.name
#   records = [
#     "ns1-07.azure-dns.com.",
#     "ns2-07.azure-dns.net.",
#     "ns3-07.azure-dns.org.",
#     "ns4-07.azure-dns.info."
#   ]
#   ttl  = var.dns_default_ttl_sec
#   tags = module.tag_config.tags
# }

# # //Prod ONLY record to UAT public DNS delegation
# # resource "azurerm_dns_ns_record" "uat_selc" {
# #   count               = var.env_short == "p" ? 1 : 0
# #   name                = "uat"
# #   zone_name           = azurerm_dns_zone.selc_public[0].name
# #   resource_group_name = data.azurerm_resource_group.rg_vnet.name
# #   records = [
# #     "ns1-01.azure-dns.com.",
# #     "ns2-01.azure-dns.net.",
# #     "ns3-01.azure-dns.org.",
# #     "ns4-01.azure-dns.info."
# #   ]
# #   ttl  = var.dns_default_ttl_sec
# #   tags = module.tag_config.tags
# # }

# resource "azurerm_dns_caa_record" "selc_pagopa_it" {
#   name                = "@"
#   zone_name           = azurerm_dns_zone.selc_public[0].name
#   resource_group_name = data.azurerm_resource_group.rg_vnet.name
#   ttl                 = var.dns_default_ttl_sec

#   record {
#     flags = 0
#     tag   = "issue"
#     value = "letsencrypt.org"
#   }

#   record {
#     flags = 0
#     tag   = "iodef"
#     value = "mailto:security+caa@pagopa.it"
#   }

#   tags = module.tag_config.tags
# }

# # application gateway records
# resource "azurerm_dns_a_record" "dns_a_selc_at" {
#   name                = "@"
#   zone_name           = azurerm_dns_zone.selc_public[0].name
#   resource_group_name = data.azurerm_resource_group.rg_vnet.name
#   ttl                 = var.dns_default_ttl_sec
#   records             = [azurerm_public_ip.appgateway_public_ip.ip_address]
#   tags                = module.tag_config.tags
# }
