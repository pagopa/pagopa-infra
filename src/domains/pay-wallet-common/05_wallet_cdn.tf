locals {
  npg_sdk_hostname    = var.env_short == "p" ? "xpay.nexigroup.com" : "stg-ta.nexigroup.com"
}
/**
 * wallet resource group
 **/
resource "azurerm_resource_group" "wallet_fe_rg" {
  name     = "${local.project}-fe-rg"
  location = var.location

  tags = module.tag_config.tags
}

/**
 * CDN
 */
module "wallet_fe_cdn" {
  source = "./.terraform/modules/__v4__/cdn"

  name                  = "fe"
  prefix                = local.project
  resource_group_name   = azurerm_resource_group.wallet_fe_rg.name
  location              = var.location
  cdn_location          = var.cdn_location
  hostname              = "${var.dns_zone_prefix}.${var.external_domain}"
  https_rewrite_enabled = true

  storage_account_replication_type = "ZRS"

  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics_italy.id

  index_document     = "index.html"
  error_404_document = "index.html"

  dns_zone_name                = azurerm_dns_zone.payment_wallet_public.name
  dns_zone_resource_group_name = azurerm_dns_zone.payment_wallet_public.resource_group_name

  keyvault_resource_group_name = module.key_vault.resource_group_name
  keyvault_subscription_id     = data.azurerm_subscription.current.subscription_id
  keyvault_vault_name          = module.key_vault.name

  querystring_caching_behaviour = "BypassCaching"

  global_delivery_rule = {
    cache_expiration_action       = []
    cache_key_query_string_action = []
    modify_request_header_action  = []

    # HSTS
    modify_response_header_action = [{
      action = "Overwrite"
      name   = "Strict-Transport-Security"
      value  = "max-age=31536000"
      },
      # Content-Security-Policy
      {
        action = "Overwrite"
        name   = "Content-Security-Policy"
        value  = "default-src 'self'; connect-src 'self' *.platform.pagopa.it *.pagopa.gov.it *.nexigroup.com;"
      },
      {
        action = "Append"
        name   = "Content-Security-Policy"
        value  = "frame-ancestors 'none'; object-src 'none'; frame-src 'self' *.platform.pagopa.it *.nexigroup.com;"
      },
      {
        action = "Append"
        name   = "Content-Security-Policy"
        value  = "img-src 'self' https://assets.cdn.io.italia.it *.platform.pagopa.it data:;"
      },
      {
        action = "Append"
        name   = "Content-Security-Policy"
        value  = "script-src 'self' 'unsafe-inline' *.nexigroup.com;"
      },
      {
        action = "Append"
        name   = "Content-Security-Policy"
        value  = "style-src 'self' 'unsafe-inline'; worker-src blob:;"
      }
    ]
  }

  delivery_rule_rewrite = [{
    name  = "RewriteRulesForReactRouting"
    order = 2

    conditions = [{
      condition_type   = "url_file_extension_condition"
      operator         = "LessThan"
      match_values     = ["1"]
      transforms       = []
      negate_condition = false
    }]

    url_rewrite_action = {
      source_pattern          = "/"
      destination             = "/index.html"
      preserve_unmatched_path = false
    }
  }]

  delivery_rule = [
    {
      name  = "CorsFontForNPG"
      order = 3

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
        match_values     = ["https://${local.npg_sdk_hostname}"]
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
        value  = "https://${local.npg_sdk_hostname}"
      }]
      cache_expiration_actions       = []
      cache_key_query_string_actions = []
      modify_request_header_actions  = []
      url_redirect_actions           = []
      url_rewrite_actions            = []
    }
  ]

  tags = module.tag_config.tags
}


module "wallet_fe_web_test" {
  count                                 = var.env_short == "p" ? 1 : 0
  source                                = "./.terraform/modules/__v4__/application_insights_standard_web_test"
  https_endpoint                        = "https://${module.wallet_fe_cdn.fqdn}"
  https_endpoint_path                   = "/index.html"
  alert_name                            = "${local.project}-fe-web-test"
  location                              = var.location
  alert_enabled                         = true
  application_insights_resource_group   = data.azurerm_resource_group.monitor_italy_rg.name
  application_insights_id               = data.azurerm_application_insights.application_insights_italy.id
  application_insights_action_group_ids = [data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.email.id, azurerm_monitor_action_group.payment_wallet_opsgenie[0].id]
  https_probe_method                    = "GET"
  timeout                               = 10
  frequency                             = 300
  https_probe_threshold                 = 99
  metric_frequency                      = "PT5M"
  metric_window_size                    = "PT1H"
  retry_enabled                         = true

}
