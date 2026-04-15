module "crusc8_cdn_frontdoor" {
  source = "./.terraform/modules/__v4__/cdn_frontdoor"

  cdn_prefix_name     = "${local.product}-crusc8"
  resource_group_name = azurerm_resource_group.crusc8_fe_rg.name
  location            = var.location_weu

  custom_domains = [
    {
      #                       crusc8.<ENV>.platform.pagopa.it
      domain_name             = "${local.dns_zone_crusc8}.${local.dns_zone_platform}.${local.external_domain}"
      hostname                = local.dns_zone_crusc8
      dns_name                = "${local.dns_zone_platform}.${local.external_domain}"
      dns_resource_group_name = local.vnet_resource_group_name_weu
      ttl                     = var.env != "p" ? 300 : 3600
    }
  ]
  storage_account_index_document     = "index.html"
  storage_account_error_404_document = "index.html"
  querystring_caching_behaviour      = "UseQueryString"

  storage_account_replication_type = var.crusc8_storage_replication_type

  delivery_rule_url_path_condition_cache_expiration_action = [
    {
      name  = "BypassCacheOnQueryString"
      order = 0

      query_string_conditions = [{
        operator         = "GreaterThan"
        match_values     = ["0"]
        negate_condition = false
        transforms       = []
      }]

      route_configuration_override = {
        cache_behavior = "DisableCache"
      }
    }
  ]

  global_delivery_rules = [
    {
      order = 1
      # HSTS
      modify_response_header_actions = [
        {
          action = "Overwrite"
          name   = "Strict-Transport-Security"
          value  = "max-age=31536000"
        },
        # Content-Security-Policy (in Report mode)
        {
          action = "Overwrite"
          name   = "Content-Security-Policy-Report-Only"
          value  = "default-src 'self'; object-src 'none'; connect-src 'self' https://api.${local.dns_zone_crusc8}.${local.external_domain}/ https://${local.dns_zone_crusc8}.${local.dns_zone_platform}.${local.external_domain}/;"
          # https://api-eu.mixpanel.com https://wisp2.pagopa.gov.it
        },
        {
          action = "Append"
          name   = "Content-Security-Policy-Report-Only"
          value  = "script-src 'self'; style-src 'self' 'unsafe-inline' https://crusc8.pagopa.it/assets/font/selfhostedfonts.css; worker-src 'none'; font-src 'self' https://crusc8.pagopa.it/assets/font/; "
        },
        # {
        #   action = "Append"
        #   name   = "Content-Security-Policy-Report-Only"
        #   value  = format("img-src 'self' https://assets.cdn.io.italia.it https://%s data:; ", module.crusc8_cdn.storage_primary_web_host)
        # },
        {
          action = "Append"
          name   = "X-Content-Type-Options"
          value  = "nosniff"
        },
        # {
        #   action = "Append"
        #   name   = "Content-Security-Policy-Report-Only"
        #   value  = " https://acardste.vaservices.eu:* https://cdn.cookielaw.org https://privacyportal-de.onetrust.com https://geolocation.onetrust.com;"
        # },
        # {
        #   action = "Append"
        #   name   = "Content-Security-Policy-Report-Only"
        #   value  = "frame-ancestors 'none'; object-src 'none'; frame-src 'self' https://www.google.com *.platform.pagopa.it *.sia.eu *.nexigroup.com *.recaptcha.net recaptcha.net https://recaptcha.google.com;"
        # },
        {
          action = "Append"
          name   = "Content-Security-Policy-Report-Only"
          value  = "img-src 'self' https://assets.cdn.io.italia.it https://selcdcheckoutsa.z6.web.core.windows.net data:;"
        },
        # {
        #   action = "Append"
        #   name   = "Content-Security-Policy-Report-Only"
        #   value  = "script-src 'self' 'unsafe-inline' https://www.google.com https://www.gstatic.com https://cdn.cookielaw.org https://geolocation.onetrust.com https://www.recaptcha.net https://recaptcha.net https://www.gstatic.com/recaptcha/ https://www.gstatic.cn/recaptcha/;"
        # },
        # {
        #   action = "Append"
        #   name   = "Content-Security-Policy-Report-Only"
        #   value  = "style-src 'self'  'unsafe-inline'; worker-src www.recaptcha.net blob:;"
        # }
      ]
    }
  ]
  delivery_rule_rewrites = concat([
    {
      name  = "RewriteRules"
      order = 2
      url_path_conditions = [
        {
          operator         = "Equal"
          match_values     = ["/"]
          negate_condition = false
          transforms       = null
        }
      ]
      url_rewrite_actions = [
        {
          source_pattern          = "/"
          destination             = "/ui/index.html"
          preserve_unmatched_path = false
        }
      ]
    }
    ],
    local.spa
  )
  delivery_custom_rules = [
    {
      name  = "robotsNoIndex"
      order = 3 + length(local.spa)

      // conditions
      url_path_conditions = [
        {
          operator         = "Equal"
          match_values     = length(var.robots_indexed_paths) > 0 ? var.robots_indexed_paths : ["dummy"]
          negate_condition = true
          transforms       = null
        }
      ]
      cookies_conditions            = []
      device_conditions             = []
      http_version_conditions       = []
      post_arg_conditions           = []
      query_string_conditions       = []
      remote_address_conditions     = []
      request_body_conditions       = []
      request_header_conditions     = []
      request_method_conditions     = []
      request_scheme_conditions     = []
      request_uri_conditions        = []
      url_file_extension_conditions = []
      url_file_name_conditions      = []

      // actions
      modify_response_header_actions = [
        {
          action = "Overwrite"
          name   = "X-Robots-Tag"
          value  = "noindex, nofollow"
        }
      ]
      cache_expiration_actions       = []
      cache_key_query_string_actions = []
      modify_request_header_actions  = []
      url_redirect_actions           = []
      url_rewrite_actions            = []
    },
    {
      name  = "microcomponentsNoCache"
      order = 4 + length(local.spa)

      // conditions
      url_path_conditions           = []
      cookies_conditions            = []
      device_conditions             = []
      http_version_conditions       = []
      post_arg_conditions           = []
      query_string_conditions       = []
      remote_address_conditions     = []
      request_body_conditions       = []
      request_header_conditions     = []
      request_method_conditions     = []
      request_scheme_conditions     = []
      request_uri_conditions        = []
      url_file_extension_conditions = []

      url_file_name_conditions = [
        {
          operator         = "Equal"
          match_values     = ["remoteEntry.js"]
          negate_condition = false
          transforms       = null
        }
      ]

      // actions
      modify_response_header_actions = [
        {
          action = "Overwrite"
          name   = "Cache-Control"
          value  = "no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0"
        }
      ]
      cache_expiration_actions       = []
      cache_key_query_string_actions = []
      modify_request_header_actions  = []
      url_redirect_actions           = []
      url_rewrite_actions            = []
    },
    {
      name  = "cors"
      order = 5 + length(local.spa)

      // conditions
      url_path_conditions = [
        {
          operator         = "BeginsWith"
          match_values     = local.cors.paths
          negate_condition = false
          transforms       = null
        }
      ]
      request_header_conditions     = []
      cookies_conditions            = []
      device_conditions             = []
      http_version_conditions       = []
      post_arg_conditions           = []
      query_string_conditions       = []
      remote_address_conditions     = []
      request_body_conditions       = []
      request_method_conditions     = []
      request_scheme_conditions     = []
      request_uri_conditions        = []
      url_file_extension_conditions = []
      url_file_name_conditions      = []

      // actions
      modify_response_header_actions = [
        {
          action = "Overwrite"
          name   = "Access-Control-Allow-Origin"
          value  = "*"
        }
      ]
      cache_expiration_actions       = []
      cache_key_query_string_actions = []
      modify_request_header_actions  = []
      url_redirect_actions           = []
      url_rewrite_actions            = []
    }
  ]
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics_italy.id

  tags = module.tag_config.tags
}

moved {
  from = module.crusc8_cdn.module.cdn_storage_account
  to   = module.crusc8_cdn_frontdoor.module.cdn_storage_account
}

moved {
  from = azurerm_dns_cname_record.hostname_cruscotto
  to   = module.crusc8_cdn_frontdoor.azurerm_dns_cname_record.subdomain["crusc8.dev.platform.pagopa.it"]
}

import {
  to = module.crusc8_cdn_frontdoor.azurerm_cdn_frontdoor_custom_domain.this["crusc8.dev.platform.pagopa.it"]
  id = "/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-weu-crusc8-fe-rg/providers/Microsoft.Cdn/profiles/pagopa-d-crusc8-cdn-profile/customDomains/crusc8-dev-platform-pagopa-it"
}

import {
  to = module.crusc8_cdn_frontdoor.azurerm_cdn_frontdoor_profile.this
  id = "/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-weu-crusc8-fe-rg/providers/Microsoft.Cdn/profiles/pagopa-d-crusc8-cdn-profile"
}

import {
  to = module.crusc8_cdn_frontdoor.azurerm_cdn_frontdoor_rule_set.this[0]
  id = "/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-weu-crusc8-fe-rg/providers/Microsoft.Cdn/profiles/pagopa-d-crusc8-cdn-profile/ruleSets/Migratedpagopadcrusc8cdnendpoint"
}

import {
  to = module.crusc8_cdn_frontdoor.azurerm_cdn_frontdoor_route.default_route
  id = "/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-weu-crusc8-fe-rg/providers/Microsoft.Cdn/profiles/pagopa-d-crusc8-cdn-profile/afdEndpoints/pagopa-d-crusc8-cdn-endpoint/routes/pagopadcrusc8cdnendpoint"
}

import {
  to = module.crusc8_cdn_frontdoor.azurerm_cdn_frontdoor_endpoint.this
  id = "/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-weu-crusc8-fe-rg/providers/Microsoft.Cdn/profiles/pagopa-d-crusc8-cdn-profile/afdEndpoints/pagopa-d-crusc8-cdn-endpoint"
}
import {
  to = module.crusc8_cdn_frontdoor.azurerm_cdn_frontdoor_origin.storage_web_host
  id = "/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourcegroups/pagopa-d-weu-crusc8-fe-rg/providers/Microsoft.Cdn/profiles/pagopa-d-crusc8-cdn-profile/originGroups/pagopa-d-crusc8-cdn-endpoint-Default/origins/primary"
}
import {
  to = module.crusc8_cdn_frontdoor.azurerm_cdn_frontdoor_origin_group.this
  id = "/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourcegroups/pagopa-d-weu-crusc8-fe-rg/providers/Microsoft.Cdn/profiles/pagopa-d-crusc8-cdn-profile/originGroups/pagopa-d-crusc8-cdn-endpoint-Default"
}

# import {
#   to = module.crusc8_cdn_frontdoor.azurerm_dns_cname_record.subdomain["crusc8.dev.platform.pagopa.it"]
#   id = "/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-vnet-rg/providers/Microsoft.Network/dnsZones/dev.platform.pagopa.it/CNAME/crusc8"
# }

import {
  to = module.crusc8_cdn_frontdoor.azurerm_cdn_frontdoor_rule.rule_url_path_cache["0"]
  id = "/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-weu-crusc8-fe-rg/providers/Microsoft.Cdn/profiles/pagopa-d-crusc8-cdn-profile/ruleSets/Migratedpagopadcrusc8cdnendpoint/rules/BypassCachingforQueryStringMigrated"
}

import {
  to = module.crusc8_cdn_frontdoor.azurerm_cdn_frontdoor_rule.rule_global["1"]
  id = "/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-weu-crusc8-fe-rg/providers/Microsoft.Cdn/profiles/pagopa-d-crusc8-cdn-profile/ruleSets/Migratedpagopadcrusc8cdnendpoint/rules/Global"
}

import {
  to = module.crusc8_cdn_frontdoor.azurerm_cdn_frontdoor_rule.rewrite_only["2"]
  id = "/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-weu-crusc8-fe-rg/providers/Microsoft.Cdn/profiles/pagopa-d-crusc8-cdn-profile/ruleSets/Migratedpagopadcrusc8cdnendpoint/rules/RewriteRules"
}

import {
  to = module.crusc8_cdn_frontdoor.azurerm_cdn_frontdoor_rule.rewrite_only["3"]
  id = "/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-weu-crusc8-fe-rg/providers/Microsoft.Cdn/profiles/pagopa-d-crusc8-cdn-profile/ruleSets/Migratedpagopadcrusc8cdnendpoint/rules/SPAui"
}

import {
  to = module.crusc8_cdn_frontdoor.azurerm_cdn_frontdoor_rule.custom_rules["robotsNoIndex"]
  id = "/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-weu-crusc8-fe-rg/providers/Microsoft.Cdn/profiles/pagopa-d-crusc8-cdn-profile/ruleSets/Migratedpagopadcrusc8cdnendpoint/rules/robotsNoIndex"
}

import {
  to = module.crusc8_cdn_frontdoor.azurerm_cdn_frontdoor_rule.custom_rules["microcomponentsNoCache"]
  id = "/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-weu-crusc8-fe-rg/providers/Microsoft.Cdn/profiles/pagopa-d-crusc8-cdn-profile/ruleSets/Migratedpagopadcrusc8cdnendpoint/rules/microcomponentsNoCache"
}

import {
  to = module.crusc8_cdn_frontdoor.azurerm_cdn_frontdoor_rule.custom_rules["cors"]
  id = "/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-weu-crusc8-fe-rg/providers/Microsoft.Cdn/profiles/pagopa-d-crusc8-cdn-profile/ruleSets/Migratedpagopadcrusc8cdnendpoint/rules/cors"
}

import {
  to = module.crusc8_cdn_frontdoor.azurerm_monitor_diagnostic_setting.diagnostic_settings_cdn_profile
  id = "/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-weu-crusc8-fe-rg/providers/Microsoft.Cdn/profiles/pagopa-d-crusc8-cdn-profile|pagopa-d-crusc8-cdn-profile-diagnostic-settings"
}

import {
  to = module.crusc8_cdn_frontdoor.azurerm_dns_txt_record.validation["crusc8.dev.platform.pagopa.it"]
  id = "/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-vnet-rg/providers/Microsoft.Network/dnsZones/dev.platform.pagopa.it/TXT/_dnsauth.crusc8"
}