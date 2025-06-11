/**
 * Platform assets resource group
 **/
resource "azurerm_resource_group" "assets_cdn_platform_rg" {
  count    = var.env_short == "p" ? 1 : 0
  name     = format("%s-assets-cdn-platform-rg", local.product)
  location = var.location

  tags = module.tag_config.tags
}

/**
 * CDN
 */
module "assets_cdn_platform" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cdn?ref=v7.50.0"

  count                 = var.env_short == "p" ? 1 : 0
  name                  = "assets-platform"
  prefix                = local.product
  resource_group_name   = azurerm_resource_group.assets_cdn_platform_rg[0].name
  location              = var.location
  hostname              = "assets.cdn.platform.pagopa.it"
  https_rewrite_enabled = true

  dns_zone_name                = azurerm_dns_zone.public[0].name
  dns_zone_resource_group_name = azurerm_dns_zone.public[0].resource_group_name

  keyvault_resource_group_name = module.key_vault.resource_group_name
  keyvault_subscription_id     = data.azurerm_subscription.current.subscription_id
  keyvault_vault_name          = module.key_vault.name

  storage_account_replication_type = var.cdn_storage_account_replication_type

  querystring_caching_behaviour = "BypassCaching"

  index_document     = "index.html"
  error_404_document = "index.html"

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
      # Content-Security-Policy (in Report mode)
      # {
      #   action = "Overwrite"
      #   name   = "Content-Security-Policy-Report-Only"
      #   value  = format("default-src 'self'; connect-src 'self' https://api.%s.%s https://api-eu.mixpanel.com https://wisp2.pagopa.gov.it", var.dns_zone_prefix, var.external_domain)
      # }
    ]
  }

  delivery_rule = [
    {
      name  = "GoTOIndex2"
      order = 2
      url_path_conditions = [
        {
          operator         = "Equal"
          match_values     = ["/"]
          negate_condition = false
          transforms       = []
        }
      ]
      url_redirect_actions = [{
        redirect_type = "Found"
        protocol      = "MatchRequest"
        hostname      = "portal.pagopa.gov.it"
        path          = "/pda.html"
        fragment      = ""
        query_string  = ""
        }
      ]
      cache_expiration_actions       = []
      cache_key_query_string_actions = []
      cookies_conditions             = []
      device_conditions              = []
      http_version_conditions        = []
      modify_request_header_actions  = []
      modify_response_header_actions = []
      post_arg_conditions            = []
      query_string_conditions        = []
      remote_address_conditions      = []
      request_body_conditions        = []
      request_header_conditions      = []
      request_method_conditions      = []
      request_scheme_conditions      = []
      request_uri_conditions         = []
      url_file_extension_conditions  = []
      url_file_name_conditions       = []
      url_rewrite_actions            = []
    },
    {
      name  = "PdaPortaltoRoot"
      order = 3
      url_path_conditions = [
        {
          operator         = "Equal"
          match_values     = ["/pda-portal/admin/login"]
          negate_condition = false
          transforms       = []

        }
      ]
      url_redirect_actions = [{
        redirect_type = "Found"
        protocol      = "MatchRequest"
        hostname      = "portal.pagopa.gov.it"
        path          = "/pda.html"
        fragment      = ""
        query_string  = ""
        }
      ]
      cache_expiration_actions       = []
      cache_key_query_string_actions = []
      cookies_conditions             = []
      device_conditions              = []
      http_version_conditions        = []
      modify_request_header_actions  = []
      modify_response_header_actions = []
      post_arg_conditions            = []
      query_string_conditions        = []
      remote_address_conditions      = []
      request_body_conditions        = []
      request_header_conditions      = []
      request_method_conditions      = []
      request_scheme_conditions      = []
      request_uri_conditions         = []
      url_file_extension_conditions  = []
      url_file_name_conditions       = []
      url_rewrite_actions            = []

    }
  ]

  tags = module.tag_config.tags
}

resource "azurerm_application_insights_web_test" "assets_cdn_platform_web_test" {
  count                   = var.env_short == "p" ? 1 : 0
  name                    = format("%s-assets-platform-web-test", local.product)
  location                = var.location
  resource_group_name     = azurerm_resource_group.monitor_rg.name
  application_insights_id = azurerm_application_insights.application_insights.id
  kind                    = "ping"
  frequency               = 300
  timeout                 = 10
  enabled                 = true
  geo_locations           = ["emea-nl-ams-azr"]

  configuration = <<XML
<WebTest Name="checkout_fe_web_test" Id="ABD48585-0831-40CB-9069-682EA6BB3583" Enabled="True" CssProjectStructure="" CssIteration="" Timeout="10" WorkItemIds=""
    xmlns="http://microsoft.com/schemas/VisualStudio/TeamTest/2010" Description="" CredentialUserName="" CredentialPassword="" PreAuthenticate="True" Proxy="default" StopOnError="False" RecordedResultFile="" ResultsLocale="">
    <Items>
        <Request Method="GET" Guid="a5f10126-e4cd-570d-961c-cea43999a200" Version="1.1" Url="https://assets.cdn.platform.pagopa.it/index.html" ThinkTime="0" Timeout="10" ParseDependentRequests="False" FollowRedirects="True" RecordResult="True" Cache="False" ResponseTimeGoal="0" Encoding="utf-8" ExpectedHttpStatusCode="200" ExpectedResponseUrl="" ReportingName="" IgnoreHttpStatusCode="False" />
    </Items>
</WebTest>
XML

}
