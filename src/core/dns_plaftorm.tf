## AWS SES Service ##

resource "azurerm_dns_txt_record" "dns-txt-platform-pagopa-it-aws-ses" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "_amazonses" # "_amazonses.platform"
  zone_name           = data.azurerm_dns_zone.public[0].name
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  record {
    value = "SW221oAKrdhBtFHNARTTx6FBfDqQZpR/kIg++6+fjYs="
  }
  tags = module.tag_config.tags
}

locals {
  dkim_aws_ses_platform_pagopa_it = var.env_short == "p" ? [
    {
      "name"  = "jmfm2mrrlx6mnd55yu2relcen4ayokxc._domainkey"
      "value" = "jmfm2mrrlx6mnd55yu2relcen4ayokxc.dkim.eu-central-1.amazonses.com"
    },
    {
      "name"  = "onorgsltykh6sthfh2xuzsenfwvg4zyl._domainkey"
      "value" = "onorgsltykh6sthfh2xuzsenfwvg4zyl.dkim.eu-central-1.amazonses.com"
    },
    {
      "name"  = "h6fd4o7i2h7fa5vfjsxbqy67ktn553cp._domainkey"
      "value" = "h6fd4o7i2h7fa5vfjsxbqy67ktn553cp.dkim.eu-central-1.amazonses.com"
    },
  ] : []
}

resource "azurerm_dns_cname_record" "dkim-aws-ses-platform-pagopa-it" {
  for_each            = { for d in local.dkim_aws_ses_platform_pagopa_it : d.name => d }
  name                = join(".", [each.value.name, "platform"])
  zone_name           = data.azurerm_dns_zone.public[0].name
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  record              = each.value.value
  tags                = module.tag_config.tags
}

# MX record for sub domain email

resource "azurerm_dns_mx_record" "dns-mx-email-platform-pagopa-it" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "email"
  zone_name           = data.azurerm_dns_zone.public[0].name
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec

  record {
    preference = 10
    exchange   = "feedback-smtp.eu-central-1.amazonses.com"
  }

  tags = module.tag_config.tags
}

# spf record
resource "azurerm_dns_txt_record" "dns-txt-email-platform-pagopa-it-aws-ses" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "email"
  zone_name           = data.azurerm_dns_zone.public[0].name
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  record {
    value = "v=spf1 include:amazonses.com -all"
  }
  tags = module.tag_config.tags
}
