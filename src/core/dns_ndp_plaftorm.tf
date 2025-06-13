## AWS SES Service ##

resource "azurerm_dns_txt_record" "dns-txt-ndp-platform-pagopa-it-aws-ses" { # To access your legacy TXT records
  count               = var.env_short == "p" ? 1 : 0
  name                = "_amazonses.platform.pagopa.it"
  zone_name           = data.azurerm_dns_zone.public[0].name
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  record {
    value = "DfSNFJT1w6TrNS1ldh4x8eESozPslq1Mfpqj9WtT09s="
  }
  tags = module.tag_config.tags
}

locals {
  dkim_aws_ses_ndp_platform_pagopa_it = var.env_short == "p" ? [
    {
      "name"  = "nlutc2tsxrnjzhsop5p55ggoxujaqvvs._domainkey"
      "value" = "nlutc2tsxrnjzhsop5p55ggoxujaqvvs.dkim.eu-south-1.amazonses.com"
    },
    {
      "name"  = "konyajm5tymegvd2hmfpdnnadckymout._domainkey"
      "value" = "konyajm5tymegvd2hmfpdnnadckymout.dkim.eu-south-1.amazonses.com"
    },
    {
      "name"  = "rddqdxcgnerj2lvzqumvsgttwwllvwic._domainkey"
      "value" = "rddqdxcgnerj2lvzqumvsgttwwllvwic.dkim.eu-south-1.amazonses.com"
    },
  ] : []
}

resource "azurerm_dns_cname_record" "dkim-aws-ses-ndp-platform-pagopa-it" {
  for_each = { for d in local.dkim_aws_ses_ndp_platform_pagopa_it : d.name => d }

  name                = each.value.name
  zone_name           = data.azurerm_dns_zone.public[0].name # platform.pagopa.it
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  record              = each.value.value
  tags                = module.tag_config.tags
}

# MX record for sub domain ndp
resource "azurerm_dns_mx_record" "dns-mx-ndp-platform-pagopa-it" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "ndp"                                # ndp.platform.pagopa.it
  zone_name           = data.azurerm_dns_zone.public[0].name # platform.pagopa.it
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec

  record {
    preference = 10
    exchange   = "feedback-smtp.eu-south-1.amazonses.com"
  }

  tags = module.tag_config.tags
}

# TXT record
resource "azurerm_dns_txt_record" "dns-txt-ndp-platform-pagopa-it-aws-ses-txt" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "ndp"                                # ndp.platform.pagopa.it
  zone_name           = data.azurerm_dns_zone.public[0].name # platform.pagopa.it
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  record {
    value = "v=spf1 include:amazonses.com ~all"
  }
  tags = module.tag_config.tags
}
