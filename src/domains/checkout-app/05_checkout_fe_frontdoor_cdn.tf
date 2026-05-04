locals {
  # Front Door CDN specific locals
  # NOTE: After switching from Standard to Front Door, optionally rename these to match ecommerce pattern:
  #   cdn_frontdoor_npg_sdk_hostname → npg_sdk_hostname
  #   cdn_frontdoor_csp_header_name → content_security_policy_header_name
  cdn_frontdoor_npg_sdk_hostname = var.env_short == "p" ? "xpay.nexigroup.com" : "stg-ta.nexigroup.com"
  cdn_frontdoor_csp_header_name  = "Content-Security-Policy"
  cdn_storage_account_name       = "${local.project}cdnsa"
  cdn_index_document             = "index.html"
  cdn_error_document             = "index.html"

  # shared CSP value -> single source of truth for both CDN delivery rules and APIM policy
  checkout_csp_value = join("", [
    "default-src 'self'; connect-src 'self' https://api.${var.dns_zone_prefix}.${var.external_domain} https://api-eu.mixpanel.com https://privacyportalde-cdn.onetrust.com https://privacyportal-de.onetrust.com",
    " https://recaptcha.net/;",
    "frame-ancestors 'none'; object-src 'none'; frame-src 'self' https://www.google.com *.platform.pagopa.it *.nexigroup.com *.recaptcha.net recaptcha.net https://recaptcha.google.com;",
    "img-src 'self' https://assets.cdn.io.italia.it www.gstatic.com/recaptcha data: https://assets.cdn.platform.pagopa.it https://privacyportalde-cdn.onetrust.com;",
    "script-src 'self' 'sha256-LIYUdRhA1kkKYXZ4mrNoTMM7+5ehEwuxwv4/FRhgems=' https://www.google.com https://www.gstatic.com https://www.recaptcha.net https://recaptcha.net https://www.gstatic.com/recaptcha/ https://www.gstatic.cn/recaptcha/ https://privacyportalde-cdn.onetrust.com https://${local.cdn_frontdoor_npg_sdk_hostname};",
    "style-src 'self'  'unsafe-inline' https://privacyportalde-cdn.onetrust.com; font-src 'self' https://privacyportalde-cdn.onetrust.com; worker-src www.recaptcha.net blob:;"
  ])

  # DNS Zone Key for the main CDN (the one configured in the module)
  dns_zone_key = "${var.dns_zone_checkout}.${var.external_domain}"

  # Note for App GW/APIM <-> CDN switches:
  # when DNS is pointing to App GW, setting enable_dns_records to true and applying will change the A record IP to Front Door's one,
  # while setting it to false and applying will destroy the A record (not managed by terraform anymore)
  custom_domains = [
    {
      domain_name             = local.dns_zone_key
      dns_name                = data.azurerm_dns_zone.checkout_public[0].name
      dns_resource_group_name = data.azurerm_dns_zone.checkout_public[0].resource_group_name
      ttl                     = var.dns_default_ttl_sec
      enable_dns_records      = true # false destroys azurerm_dns_a_record, true changes IP from App GW one to Front Door one
    }
  ]

  global_delivery_rules = [
    {
      order = 2
      # HSTS and Content-Security-Policy
      modify_response_header_actions = [
        {
          action = "Overwrite"
          name   = "Strict-Transport-Security"
          value  = "max-age=31536000"
        },
        # Content-Security-Policy
        {
          action = "Overwrite"
          name   = local.cdn_frontdoor_csp_header_name
          value  = format("default-src 'self'; connect-src 'self' https://api.%s.%s https://api-eu.mixpanel.com https://privacyportalde-cdn.onetrust.com https://privacyportal-de.onetrust.com", var.dns_zone_prefix, var.external_domain)
        },
        {
          action = "Append"
          name   = local.cdn_frontdoor_csp_header_name
          value  = " https://recaptcha.net/;"
        },
        {
          action = "Append"
          name   = local.cdn_frontdoor_csp_header_name
          value  = "frame-ancestors 'none'; object-src 'none'; frame-src 'self' https://www.google.com *.platform.pagopa.it *.nexigroup.com *.recaptcha.net recaptcha.net https://recaptcha.google.com;"
        }
      ]
    },
    {
      order = 3
      modify_response_header_actions = [
        {
          action = "Append"
          name   = local.cdn_frontdoor_csp_header_name
          value  = "img-src 'self' https://assets.cdn.io.italia.it www.gstatic.com/recaptcha data: https://assets.cdn.platform.pagopa.it https://privacyportalde-cdn.onetrust.com;"
        },
        {
          action = "Append"
          name   = local.cdn_frontdoor_csp_header_name
          value  = "script-src 'self' 'sha256-LIYUdRhA1kkKYXZ4mrNoTMM7+5ehEwuxwv4/FRhgems=' https://www.google.com https://www.gstatic.com https://www.recaptcha.net https://recaptcha.net https://www.gstatic.com/recaptcha/ https://www.gstatic.cn/recaptcha/ https://privacyportalde-cdn.onetrust.com https://${local.cdn_frontdoor_npg_sdk_hostname};"
        },
        {
          action = "Append"
          name   = local.cdn_frontdoor_csp_header_name
          value  = "style-src 'self'  'unsafe-inline' https://privacyportalde-cdn.onetrust.com; font-src 'self' https://privacyportalde-cdn.onetrust.com; worker-src www.recaptcha.net blob:;"
        },
        {
          action = "Overwrite"
          name   = "X-Frame-Options"
          value  = "SAMEORIGIN"
        }
      ]
    }
  ]

  delivery_custom_rules = [
    {
      name              = "RedirectAzureFdEndpoint"
      order             = 1
      behavior_on_match = "Stop"

      // conditions: match any request NOT arriving on the official custom domain
      host_name_condition = [{
        operator         = "Equal"
        match_values     = [local.dns_zone_key]
        negate_condition = true
        transforms       = ["Lowercase"]
      }]

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
      url_file_name_conditions      = []

      // actions: redirect to the proper custom domain
      modify_response_header_actions = []
      url_rewrite_actions            = []
      url_redirect_actions = [{
        redirect_type = "Found"
        protocol      = "Https"
        hostname      = local.dns_zone_key
        path          = "/"
        fragment      = ""
        query_string  = ""
      }]
    },
    {
      name  = "CorsFontForNPG"
      order = 6

      // conditions
      url_path_conditions       = []
      cookies_conditions        = []
      device_conditions         = []
      http_version_conditions   = []
      post_arg_conditions       = []
      query_string_conditions   = []
      remote_address_conditions = []
      request_body_conditions   = []
      request_header_conditions = [{
        selector         = "Origin"
        operator         = "Equal"
        match_values     = ["https://${local.cdn_frontdoor_npg_sdk_hostname}"]
        transforms       = []
        negate_condition = false
      }]
      request_method_conditions     = []
      request_scheme_conditions     = []
      request_uri_conditions        = []
      url_file_extension_conditions = []
      url_file_name_conditions      = []

      // actions
      modify_response_header_actions = [{
        action = "Overwrite"
        name   = "Access-Control-Allow-Origin"
        value  = "https://${local.cdn_frontdoor_npg_sdk_hostname}"
      }]
      url_redirect_actions = []
      url_rewrite_actions  = []
    }
  ]

  delivery_rule_rewrites = [
    {
      name  = "RewriteRules"
      order = 4

      url_path_conditions = [{
        condition_type   = "url_path_condition"
        operator         = "EndsWith"
        match_values     = ["/dona", "/dona/"]
        transforms       = []
        negate_condition = false
      }]

      url_rewrite_actions = [{
        source_pattern          = "/"
        destination             = "/dona.html"
        preserve_unmatched_path = false
      }]
    },
    {
      name  = "RewriteRulesTerms"
      order = 5

      url_path_conditions = [{
        condition_type   = "url_path_condition"
        operator         = "Equal"
        match_values     = ["/termini-di-servizio"]
        transforms       = []
        negate_condition = false
      }]

      url_rewrite_actions = [{
        source_pattern          = "/"
        destination             = "/terms/it.html"
        preserve_unmatched_path = false
      }]
    }
  ]
}

/**
 * Checkout resource group
 */
resource "azurerm_resource_group" "checkout_fe_rg" {
  count    = var.checkout_enabled ? 1 : 0
  name     = format("%s-checkout-fe-rg", local.parent_project)
  location = var.location

  tags = module.tag_config.tags
}

/**
 * CDN Front Door
 * NOTE: After cleanup, rename module to "checkout_cdn" and run:
 *   terraform state mv module.checkout_cdn_frontdoor module.checkout_cdn
 */
module "checkout_cdn_frontdoor" {
  source = "./.terraform/modules/__v4__/cdn_frontdoor"

  cdn_prefix_name     = local.project
  resource_group_name = azurerm_resource_group.checkout_fe_rg[0].name // refers to resource group in 05_checkout_fe.tf, to be changed after cleanup
  location            = var.location

  https_rewrite_enabled = true

  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics.id

  storage_account_name               = local.cdn_storage_account_name
  storage_account_index_document     = local.cdn_index_document
  storage_account_error_404_document = local.cdn_error_document
  storage_account_replication_type   = var.checkout_cdn_storage_replication_type

  keyvault_id = data.azurerm_key_vault.key_vault.id
  tenant_id   = data.azurerm_client_config.current.tenant_id

  querystring_caching_behaviour = "IgnoreQueryString"

  custom_domains = local.custom_domains

  global_delivery_rules  = local.global_delivery_rules
  delivery_custom_rules  = local.delivery_custom_rules
  delivery_rule_rewrites = local.delivery_rule_rewrites

  tags = module.tag_config.tags
}

/**
 * Web Test for CDN
 * NOTE: After cleanup, rename module to "checkout_fe_web_test" and run:
 *   terraform state mv module.checkout_fe_frontdoor_web_test module.checkout_fe_web_test
 */
module "checkout_fe_frontdoor_web_test" {
  count  = var.env_short == "p" ? 1 : 0
  source = "./.terraform/modules/__v4__/application_insights_standard_web_test"

  https_endpoint                        = "https://${module.checkout_cdn_frontdoor.fqdn}"
  https_endpoint_path                   = "/index.html"
  alert_name                            = "${local.project}-fe-web-test"
  location                              = var.location
  alert_enabled                         = true
  application_insights_resource_group   = data.azurerm_resource_group.monitor_rg.name
  application_insights_id               = data.azurerm_application_insights.application_insights.id
  application_insights_action_group_ids = [data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.email.id]
  https_probe_method                    = "GET"
  timeout                               = 10
  frequency                             = 300
  https_probe_threshold                 = 99
  metric_frequency                      = "PT5M"
  metric_window_size                    = "PT1H"
  retry_enabled                         = true
}
