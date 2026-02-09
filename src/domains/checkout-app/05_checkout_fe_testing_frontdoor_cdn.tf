locals {

  test = {
# Front Door CDN specific locals
  # NOTE: After switch, rename these to match ecommerce pattern:
  #   cdn_frontdoor_npg_sdk_hostname → npg_sdk_hostname
  #   cdn_frontdoor_csp_header_name → content_security_policy_header_name
  cdn_frontdoor_npg_sdk_hostname = var.env_short == "p" ? "xpay.nexigroup.com" : "stg-ta.nexigroup.com"
  cdn_frontdoor_csp_header_name  = "Content-Security-Policy"
  cdn_storage_account_name       = "${local.project}tecdn"
  cdn_index_document             = "index.html"
  cdn_error_document             = "index.html"

  # DNS Zone Key for the main CDN (the one configured in the module)
  dns_zone_key = "${var.dns_zone_checkout}.${var.external_domain}"

  # Custom domains configuration - Front Door CDN creation only (PR #2 / PIDM-1151)
  # NOTE: custom_domains is empty to avoid Azure conflict with CDN Classic
  # Azure doesn't allow the same domain on both CDN Classic and Front Door simultaneously
  # DNS switch will happen in a separate PR (PR #3 / PIDM-1410) which will (process to be validated):
  #   1. Remove custom domain from CDN Classic
  #   2. Add custom domain to Front Door (with enable_dns_records = false for staged DNS switch)

  custom_domains = []

  global_delivery_rules = [
    {
      order = 1
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
      order = 2
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
      name  = "CorsFontForNPG"
      order = 5

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
      order = 3

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
      order = 4

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
  
}

/**
 * Checkout resource group
 * NOTE: Currently defined in 05_checkout_fe.tf
 * After switch: uncomment this block and delete 05_checkout_fe.tf
 */
# resource "azurerm_resource_group" "checkout_fe_rg" {
#   count    = var.checkout_enabled ? 1 : 0
#   name     = format("%s-checkout-fe-rg", local.parent_project)
#   location = var.location
#
#   tags = module.tag_config.tags
# }

/**
 * CDN Front Door
 * NOTE: After cleanup, rename module to "checkout_cdn" and run:
 *   terraform state mv module.checkout_cdn_frontdoor module.checkout_cdn
 */
module "checkout_testing_cdn_frontdoor" {
  source = "./.terraform/modules/__v4__/cdn_frontdoor"

  cdn_prefix_name     = "pagopa-checkout-testing"
  resource_group_name = azurerm_resource_group.checkout_fe_rg[0].name // refers to resource group in 05_checkout_fe.tf, to be changed after cleanup
  location            = var.location

  https_rewrite_enabled = true

  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics.id

  storage_account_name               = local.test.cdn_storage_account_name
  storage_account_index_document     = local.test.cdn_index_document
  storage_account_error_404_document = local.test.cdn_error_document
  storage_account_replication_type   = var.checkout_cdn_storage_replication_type

  keyvault_id = data.azurerm_key_vault.key_vault.id
  tenant_id   = data.azurerm_client_config.current.tenant_id

  querystring_caching_behaviour = "IgnoreQueryString"

  custom_domains = local.test.custom_domains

  global_delivery_rules  = local.test.global_delivery_rules
  delivery_custom_rules  = local.test.delivery_custom_rules
  delivery_rule_rewrites = local.test.delivery_rule_rewrites

  tags = module.tag_config.tags
}

