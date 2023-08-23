## AWS SES Service ##

resource "azurerm_dns_txt_record" "dns-txt-backoffice-platform-pagopa-it-aws-ses" { # To access your legacy TXT records
  count               = var.env_short == "p" ? 1 : 0
  name                = "_amazonses.backoffice"
  zone_name           = azurerm_dns_zone.public[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  record {
    value = "SW221oAKrdhBtFHNARTTx6FBfDqQZpR/kIg++6+fjYs=" # TODO JCPS change after AWS apply
  }
  tags = var.tags
}

locals {
  dkim_aws_ses_platform_pagopa_it = var.env_short == "p" ? [
    {
      "name"  = "jmfm2mrrlx6mnd55yu2relcen4ayokxc._domainkey"                      # TODO JCPS change after AWS apply
      "value" = "jmfm2mrrlx6mnd55yu2relcen4ayokxc.dkim.eu-central-1.amazonses.com" # TODO JCPS change after AWS apply
    },
    {
      "name"  = "onorgsltykh6sthfh2xuzsenfwvg4zyl._domainkey"                      # TODO JCPS change after AWS apply
      "value" = "onorgsltykh6sthfh2xuzsenfwvg4zyl.dkim.eu-central-1.amazonses.com" # TODO JCPS change after AWS apply
    },
    {
      "name"  = "h6fd4o7i2h7fa5vfjsxbqy67ktn553cp._domainkey"                      # TODO JCPS change after AWS apply
      "value" = "h6fd4o7i2h7fa5vfjsxbqy67ktn553cp.dkim.eu-central-1.amazonses.com" # TODO JCPS change after AWS apply
    },
  ] : []
}

resource "azurerm_dns_cname_record" "dkim-aws-ses-backoffice-platform-pagopa-it" {
  for_each            = { for d in local.dkim_aws_ses_platform_pagopa_it : d.name => d }
  name                = join(".", [each.value.name, "backoffice"])
  zone_name           = azurerm_dns_zone.public[0].name # platform.pagopa.it
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  record              = each.value.value
  tags                = var.tags
}


# MX record for sub domain backoffice
resource "azurerm_dns_mx_record" "dns-mx-backoffice-platform-pagopa-it" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "backoffice"
  zone_name           = azurerm_dns_zone.public[0].name # platform.pagopa.it
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec

  record {
    preference = 10
    exchange   = "feedback-smtp.eu-central-1.amazonses.com" # TODO JCPS change after AWS apply
  }

  tags = var.tags
}

# TXT record 
resource "azurerm_dns_txt_record" "dns-txt-backoffice-platform-pagopa-it-aws-ses" {
  count               = var.env_short == "p" ? 1 : 0
  name                = "backoffice"
  zone_name           = azurerm_dns_zone.public[0].name # platform.pagopa.it
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  record {
    value = "v=spf1 include:amazonses.com -all" # TODO JCPS change after AWS apply
  }
  tags = var.tags
}
