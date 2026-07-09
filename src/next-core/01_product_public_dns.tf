/*
 * Product Public DNS Zones Configuration
 *
 * This module manages public DNS zones for PagoPA products.
 *
 * How to add a zone to org infra: https://pagopa.atlassian.net/wiki/spaces/DEVOPS/pages/426214700/Azure+-+DNS+deleghe+sotto+domini+per+prodotto
 *
 * HOW TO ADD A NEW PRODUCT DNS ZONE:
 *
 * 1. Add a new entry in the 'products_dns_zones' map with the product name as key:
 *    "product-name" = {
 *      dev_delegation_records = []
 *      uat_delegation_records = []
 *      aws_ses_settings = {}
 *    }
 *
 * 2. DNS Zone naming convention:
 *    - DEV: dev.product-name.pagopa.it
 *    - UAT: uat.product-name.pagopa.it
 *    - PROD: product-name.pagopa.it
 *
 * 3. Configure delegation records (PROD environment ONLY):
 *    After creating DNS zones in DEV and UAT, add their nameservers to enable delegation:
 *    dev_delegation_records = [
 *      "ns1-01.azure-dns.com.",
 *      "ns2-01.azure-dns.net.",
 *      "ns3-01.azure-dns.org.",
 *      "ns4-01.azure-dns.info."
 *    ]
 *    uat_delegation_records = [
 *      "ns1-02.azure-dns.com.",
 *      ...
 *    ]
 *
 * 4. Configure AWS SES email settings (PROD environment ONLY):
 *    Add AWS SES configuration if the product needs to send emails:
 *    aws_ses_settings = {
 *      amazonses_record = "token-from-aws-ses-verification"     # Amazon SES domain verification token
 *      mx_record        = "feedback-smtp.eu-south-1.amazonses.com"  # Amazon SES SMTP endpoint
 *      spf_record       = "v=spf1 include:amazonses.com -all"   # SPF record for email authentication
 *      bimi_record      = "v=BIMI1; l=https://...; a=https://..." # BIMI record for brand indicators
 *      dmarc_record     = "v=DMARC1; p=reject; rua=mailto:..."  # DMARC policy
 *      dkim_records = [                                          # DKIM records for email signing
 *        {
 *          "name"  = "selector1._domainkey"
 *          "value" = "selector1.dkim.eu-south-1.amazonses.com"
 *        },
 *        {
 *          "name"  = "selector2._domainkey"
 *          "value" = "selector2.dkim.eu-south-1.amazonses.com"
 *        },
 *        ...
 *      ]
 *    }
 *
 *    This creates:
 *    - TXT record at: _amazonses.product-name.pagopa.it (for SES verification)
 *    - CNAME records for DKIM: selector._domainkey.product-name.pagopa.it
 *    - MX record at: email.product-name.pagopa.it
 *    - SPF TXT record at: email.product-name.pagopa.it
 *    - BIMI TXT record at: default._bimi.product-name.pagopa.it
 *    - DMARC TXT record at: _dmarc.product-name.pagopa.it
 *
 * 5. Leave arrays/maps empty if not needed:
 *    - Empty dev_delegation_records = [] → no DEV delegation created
 *    - Empty uat_delegation_records = [] → no UAT delegation created
 *    - Empty aws_ses_settings = {} → no email records created
 *
 * RESOURCES CREATED:
 * - azurerm_dns_zone: DNS zone for each product (all environments)
 * - azurerm_dns_ns_record: NS delegation records for DEV and UAT (PROD only)
 * - azurerm_dns_txt_record: Amazon SES verification, SPF, BIMI, and DMARC records (PROD only)
 * - azurerm_dns_cname_record: DKIM records for AWS SES (PROD only)
 * - azurerm_dns_mx_record: MX record for email (PROD only)
 */

locals {
  products_dns_zones = {
    "ricevute" = {
      # todo delegation records after create DNS zone in DEV env
      dev_delegation_records = [
        "ns1-05.azure-dns.com.",
        "ns2-05.azure-dns.net.",
        "ns3-05.azure-dns.org.",
        "ns4-05.azure-dns.info."
      ]
      # todo delegation records after create DNS zone in UAT env
      uat_delegation_records = [
        "ns1-09.azure-dns.com.",
        "ns2-09.azure-dns.net.",
        "ns3-09.azure-dns.org.",
        "ns4-09.azure-dns.info."
      ]
      aws_ses_settings = {
        amazonses_record = "ktEBl7wiK/gHr+30DkyhCC9EyLo4ANeHM2P9o/Og/eo="
        mx_record        = "feedback-smtp.eu-south-1.amazonses.com"
        spf_record       = "v=spf1 include:amazonses.com -all"
        bimi_record      = "v=BIMI1; l=https://bimi.ssl.com/mc-dc1kuvp8h8c.svg; a=https://assets.cdn.platform.pagopa.it/pagoPA-VMC-full-bundle.pem;"
        dmarc_record     = "v=DMARC1; p=reject; pct=100; rua=mailto:dmarc@0f1qy7b5.uriports.com; aspf=s; adkim=s"
        dkim_records = [
          {
            "r_name"  = "s4gfmqvqljfuychrhvz63mvt3lndb72b._domainkey"
            "r_value" = "s4gfmqvqljfuychrhvz63mvt3lndb72b.dkim.eu-south-1.amazonses.com"
          },
          {
            "r_name"  = "k5oplutx2zfzgojbbirymyzn5eqiiuef._domainkey"
            "r_value" = "k5oplutx2zfzgojbbirymyzn5eqiiuef.dkim.eu-south-1.amazonses.com"
          },
          {
            "r_name"  = "6jdsxdvu4gytfwy7tpg7i3ymngihs3hm._domainkey"
            "r_value" = "6jdsxdvu4gytfwy7tpg7i3ymngihs3hm.dkim.eu-south-1.amazonses.com"
          },
        ]
      }
    }
  }
}

locals {
  dev_products   = { for k, v in local.products_dns_zones : k => v.dev_delegation_records if length(v.dev_delegation_records) != 0 }
  uat_products   = { for k, v in local.products_dns_zones : k => v.uat_delegation_records if length(v.uat_delegation_records) != 0 }
  email_products = { for k, v in local.products_dns_zones : k => v.aws_ses_settings if length(v.aws_ses_settings) != 0 }
  email_dkim_flattened = {
    for item in flatten([
      for product, settings in local.products_dns_zones : [
        for dkim in settings.aws_ses_settings.dkim_records : {
          key   = "${product}#${dkim.r_name}"
          value = dkim
        }
      ] if settings.aws_ses_settings != {}
    ]) : item.key => item.value
  }
}

resource "azurerm_dns_zone" "public_product_dns_zone" {
  for_each            = local.products_dns_zones
  name                = join(".", var.env_short == "p" ? [each.key, var.external_domain] : [var.env, each.key, var.external_domain])
  resource_group_name = azurerm_resource_group.rg_vnet.name
  tags                = module.tag_config.tags
}


# Prod ONLY record to DEV public DNS delegation
resource "azurerm_dns_ns_record" "dev_product_dns_zone_delegation" {
  for_each            = var.env_short == "p" ? local.dev_products : {}
  name                = "dev"
  zone_name           = azurerm_dns_zone.public_product_dns_zone[each.key].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  records             = each.value
  ttl                 = var.dns_default_ttl_sec
  tags                = module.tag_config.tags
}


# Prod ONLY record to UAT public DNS delegation
resource "azurerm_dns_ns_record" "uat_product_dns_zone_delegation" {
  for_each            = var.env_short == "p" ? local.uat_products : {}
  name                = "uat"
  zone_name           = azurerm_dns_zone.public_product_dns_zone[each.key].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  records             = each.value
  ttl                 = var.dns_default_ttl_sec
  tags                = module.tag_config.tags
}


# EMAIL RECORDS (PROD ONLY)
resource "azurerm_dns_txt_record" "aws_ses_dns_txt_record" {
  for_each            = var.env_short == "p" ? local.email_products : {}
  name                = "_amazonses"
  zone_name           = azurerm_dns_zone.public_product_dns_zone[each.key].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  record {
    value = each.value.amazonses_record
  }
  tags = module.tag_config.tags
}

resource "azurerm_dns_cname_record" "dkim_aws_ses_dns_cname_record" {
  for_each            = var.env_short == "p" ? local.email_dkim_flattened : {}
  name                = each.value.r_name
  zone_name           = azurerm_dns_zone.public_product_dns_zone[split("#", each.key)[0]].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  record              = each.value.r_value
  tags                = module.tag_config.tags
}

resource "azurerm_dns_mx_record" "email_dns_mx_record" {
  for_each            = var.env_short == "p" ? local.email_products : {}
  name                = "email"
  zone_name           = azurerm_dns_zone.public_product_dns_zone[each.key].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec

  record {
    preference = 10
    exchange   = each.value.mx_record
  }

  tags = module.tag_config.tags
}

# Prod ONLY spf record
resource "azurerm_dns_txt_record" "email_dns_txt_spf_record" {
  for_each            = var.env_short == "p" ? local.email_products : {}
  name                = "email"
  zone_name           = azurerm_dns_zone.public_product_dns_zone[each.key].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  record {
    value = each.value.spf_record
  }
  tags = module.tag_config.tags
}

# Prod ONLY bimi record

resource "azurerm_dns_txt_record" "email_dns_txt_bimi_record" {
  for_each            = var.env_short == "p" ? local.email_products : {}
  name                = "default._bimi"
  zone_name           = azurerm_dns_zone.public_product_dns_zone[each.key].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec_short
  record {
    value = each.value.bimi_record
  }
  tags = module.tag_config.tags
}

resource "azurerm_dns_txt_record" "email_dns_txt_dmarc_record" {
  for_each            = var.env_short == "p" ? local.email_products : {}
  name                = "_dmarc"
  zone_name           = azurerm_dns_zone.public_product_dns_zone[each.key].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec_short
  record {
    value = each.value.dmarc_record
  }
  tags = module.tag_config.tags
}
