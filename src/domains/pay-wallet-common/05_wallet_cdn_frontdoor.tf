locals {
  # NOTE: After switch, rename these to drop the frontdoor_cdn_ prefix:
  #   frontdoor_cdn_npg_sdk_hostname → npg_sdk_hostname
  #   frontdoor_cdn_csp_header_name  → content_security_policy_header_name
  frontdoor_cdn_npg_sdk_hostname = var.env_short == "p" ? "xpay.nexigroup.com" : "stg-ta.nexigroup.com"
  frontdoor_cdn_csp_header_name  = "Content-Security-Policy"
  cdn_storage_account_name       = "${local.project}cdnsa"
  cdn_index_document             = "index.html"
  cdn_error_document             = "index.html"

  wallet_dns_zone_key = "${var.dns_zone_prefix}.${var.external_domain}"

  # Note for App GW/APIM <-> CDN switches:
  # when DNS is pointing to App GW, setting enable_dns_records to true and applying will change the A record IP to Front Door's one,
  # while setting it to false and applying will destroy the A record (not managed by terraform anymore)
  wallet_cdn_custom_domains = [
    {
      domain_name             = local.wallet_dns_zone_key
      dns_name                = azurerm_dns_zone.payment_wallet_public.name
      dns_resource_group_name = azurerm_dns_zone.payment_wallet_public.resource_group_name
      ttl                     = var.dns_default_ttl_sec
      enable_dns_records      = true
    }
  ]

  wallet_cdn_global_delivery_rules = [
    {
      order = 2
      modify_response_header_actions = [
        {
          action = "Overwrite"
          name   = "Strict-Transport-Security"
          value  = "max-age=31536000"
        },
        {
          action = "Overwrite"
          name   = local.frontdoor_cdn_csp_header_name
          value  = "default-src 'self'; connect-src 'self' *.platform.pagopa.it *.pagopa.gov.it *.nexigroup.com;"
        },
        {
          action = "Append"
          name   = local.frontdoor_cdn_csp_header_name
          value  = "frame-ancestors 'none'; object-src 'none'; frame-src 'self' *.platform.pagopa.it *.nexigroup.com;"
        },
      ]
    },
    {
      order = 3
      modify_response_header_actions = [
        {
          action = "Append"
          name   = local.frontdoor_cdn_csp_header_name
          value  = "img-src 'self' https://assets.cdn.io.italia.it *.platform.pagopa.it data:;"
        },
        {
          action = "Append"
          name   = local.frontdoor_cdn_csp_header_name
          value  = "script-src 'self' 'unsafe-inline' *.nexigroup.com;"
        },
        {
          action = "Append"
          name   = local.frontdoor_cdn_csp_header_name
          value  = "style-src 'self' 'unsafe-inline'; worker-src blob:;"
        },
      ]
    }
  ]

  wallet_cdn_delivery_custom_rules = [
    {
      name              = "RedirectAzureFdEndpoint"
      order             = 1
      behavior_on_match = "Stop"

      host_name_condition = [{
        operator         = "Equal"
        match_values     = [local.wallet_dns_zone_key]
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

      modify_response_header_actions = []
      url_rewrite_actions            = []
      url_redirect_actions = [{
        redirect_type = "Found"
        protocol      = "Https"
        hostname      = local.wallet_dns_zone_key
        path          = "/"
        fragment      = ""
        query_string  = ""
      }]
    },
    {
      name  = "CorsFontForNPG"
      order = 6

      host_name_condition       = []
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
        match_values     = ["https://${local.frontdoor_cdn_npg_sdk_hostname}"]
        transforms       = []
        negate_condition = false
      }]
      request_method_conditions     = []
      request_scheme_conditions     = []
      request_uri_conditions        = []
      url_file_extension_conditions = []
      url_file_name_conditions      = []

      modify_response_header_actions = [{
        action = "Overwrite"
        name   = "Access-Control-Allow-Origin"
        value  = "https://${local.frontdoor_cdn_npg_sdk_hostname}"
      }]
      url_redirect_actions = []
      url_rewrite_actions  = []
    }
  ]

  wallet_cdn_delivery_rule_rewrites = [
    {
      name  = "RewriteRulesForReactRouting"
      order = 4

      url_file_extension_conditions = [{
        operator         = "LessThan"
        match_values     = ["1"]
        negate_condition = false
        transforms       = []
      }]

      url_rewrite_actions = [{
        source_pattern          = "/"
        destination             = "/index.html"
        preserve_unmatched_path = "false"
      }]
    }
  ]
}

/**
 * Wallet FE resource group
 * NOTE: Currently defined in 05_wallet_cdn.tf
 * After switch: uncomment this block and delete 05_wallet_cdn.tf
 */
# resource "azurerm_resource_group" "wallet_fe_rg" {
#   name     = "${local.project}-fe-rg"
#   location = var.location
#
#   tags = module.tag_config.tags
# }

/**
 * CDN Front Door
 * NOTE: After cleanup, optionally rename module to "wallet_cdn" and run:
 *   terraform state mv module.wallet_cdn_frontdoor module.wallet_cdn
 */
module "wallet_cdn_frontdoor" {
  source = "./.terraform/modules/__v4__/cdn_frontdoor"

  cdn_prefix_name     = local.project
  resource_group_name = azurerm_resource_group.wallet_fe_rg.name // refers to resource group in 05_wallet_cdn.tf, to be changed after cleanup
  location            = var.location

  https_rewrite_enabled = true

  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics_italy.id

  storage_account_name               = local.cdn_storage_account_name
  storage_account_index_document     = local.cdn_index_document
  storage_account_error_404_document = local.cdn_error_document
  storage_account_replication_type   = "ZRS"

  keyvault_id = module.key_vault.id
  tenant_id   = data.azurerm_client_config.current.tenant_id

  querystring_caching_behaviour = "IgnoreQueryString"

  custom_domains = local.wallet_cdn_custom_domains

  global_delivery_rules  = local.wallet_cdn_global_delivery_rules
  delivery_custom_rules  = local.wallet_cdn_delivery_custom_rules
  delivery_rule_rewrites = local.wallet_cdn_delivery_rule_rewrites

  tags = module.tag_config.tags
}
