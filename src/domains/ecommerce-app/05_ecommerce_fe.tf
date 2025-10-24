
locals {
  npg_sdk_hostname                    = var.env_short == "p" ? "xpay.nexigroup.com" : "stg-ta.nexigroup.com"
  content_security_policy_header_name = "Content-Security-Policy"
  cdn_storage_account_name            = "${local.project}cdnsa"
  cdn_index_document                  = "index.html"
  cdn_error_document                  = "index.html"
  # DNS Zone Key for the main CDN (the one configured in the module)
  dns_zone_key = "${var.dns_zone_ecommerce}.${var.external_domain}"
  # ecommerce zones apex
  # TO BE DEFINED ecommerce_zones_apex = data.azurerm_dns_zone.ecommerce_apex
  custom_domains = [
    {
      domain_name             = local.dns_zone_key
      dns_name                = data.azurerm_dns_zone.ecommerce_public[0].name
      dns_resource_group_name = data.azurerm_dns_zone.ecommerce_public[0].resource_group_name
      ttl                     = var.dns_default_ttl_sec
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
        # Content-Security-Policy
        {
          action = "Overwrite"
          name   = local.content_security_policy_header_name
          value  = format("default-src 'self'; connect-src 'self' https://api.%s.%s https://api-eu.mixpanel.com", var.dns_zone_prefix, var.external_domain)
        },
        {
          action = "Append"
          name   = local.content_security_policy_header_name
          value  = "https://recaptcha.net/;"
        },
        {
          action = "Append"
          name   = local.content_security_policy_header_name
          value  = "frame-ancestors 'none'; object-src 'none'; frame-src 'self' https://www.google.com *.platform.pagopa.it *.sia.eu *.nexigroup.com *.recaptcha.net recaptcha.net https://recaptcha.google.com;"
        }
      ]
    },
    {
      order = 2
      # HSTS
      modify_response_header_actions = [
        {
          action = "Append"
          name   = local.content_security_policy_header_name
          value  = "img-src 'self' https://assets.cdn.io.italia.it www.gstatic.com/recaptcha data: https://assets.cdn.platform.pagopa.it"
        },
        {
          action = "Append"
          name   = local.content_security_policy_header_name
          value  = "script-src 'self' 'sha256-LIYUdRhA1kkKYXZ4mrNoTMM7+5ehEwuxwv4/FRhgems=' https://www.google.com https://www.gstatic.com https://www.recaptcha.net https://recaptcha.net https://www.gstatic.com/recaptcha/ https://www.gstatic.cn/recaptcha/ https://${local.npg_sdk_hostname};"
        },
        {
          action = "Append"
          name   = local.content_security_policy_header_name
          value  = "style-src 'self' 'unsafe-inline'; worker-src www.recaptcha.net blob:;"
        },
        {
          action = "Overwrite"
          name   = "X-Frame-Options"
          value  = "SAMEORIGIN"
        },
      ]
    }
  ]

  delivery_custom_rules = [
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
      url_redirect_actions = []
      url_rewrite_actions  = []
    }
  ]
}

/**
 * Ecommerce resource group
 **/
resource "azurerm_resource_group" "ecommerce_fe_rg" {
  name     = format("%s-ecommerce-fe-rg", local.product)
  location = var.location

  tags = module.tag_config.tags
}

/**
 * CDN
 */
module "ecommerce_cdn" {
  source = "./.terraform/modules/__v4__/cdn_frontdoor"

  #name                  = "ecommerce"
  cdn_prefix_name     = local.project
  resource_group_name = azurerm_resource_group.ecommerce_fe_rg.name
  location            = var.location

  https_rewrite_enabled = true

  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics.id

  storage_account_name               = local.cdn_storage_account_name
  storage_account_index_document     = local.cdn_index_document
  storage_account_error_404_document = local.cdn_error_document
  storage_account_replication_type   = var.ecommerce_cdn_storage_replication_type

  keyvault_id = data.azurerm_key_vault.kv.id
  tenant_id   = data.azurerm_client_config.current.tenant_id

  querystring_caching_behaviour = "IgnoreQueryString"

  custom_domains        = local.custom_domains
  global_delivery_rules = local.global_delivery_rules
  delivery_custom_rules = local.delivery_custom_rules

  tags = module.tag_config.tags
}

resource "azurerm_application_insights_web_test" "ecommerce_fe_web_test" {
  count                   = var.env_short == "p" ? 1 : 0
  name                    = format("%s-ecommerce-fe-web-test", local.product)
  location                = var.location
  resource_group_name     = data.azurerm_resource_group.monitor_rg.name
  application_insights_id = data.azurerm_application_insights.application_insights.id
  kind                    = "ping"
  frequency               = 300
  timeout                 = 10
  enabled                 = true
  geo_locations           = ["emea-nl-ams-azr"]

  configuration = <<XML
<WebTest Name="ecommerce_fe_web_test" Id="ABD48585-0831-40CB-9069-682EA6BB3583" Enabled="True" CssProjectStructure="" CssIteration="" Timeout="10" WorkItemIds=""
    xmlns="http://microsoft.com/schemas/VisualStudio/TeamTest/2010" Description="" CredentialUserName="" CredentialPassword="" PreAuthenticate="True" Proxy="default" StopOnError="False" RecordedResultFile="" ResultsLocale="">
    <Items>
        <Request Method="GET" Guid="a5f10126-e4cd-570d-961c-cea43999a200" Version="1.1" Url="${format("https://%s.%s/index.html", var.dns_zone_ecommerce, var.external_domain)}" ThinkTime="0" Timeout="10" ParseDependentRequests="False" FollowRedirects="True" RecordResult="True" Cache="False" ResponseTimeGoal="0" Encoding="utf-8" ExpectedHttpStatusCode="200" ExpectedResponseUrl="" ReportingName="" IgnoreHttpStatusCode="False" />
    </Items>
</WebTest>
XML

}
