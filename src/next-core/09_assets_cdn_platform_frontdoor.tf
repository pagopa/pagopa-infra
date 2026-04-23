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
module "assets_cdn_platform_frontdoor" {
  source = "./.terraform/modules/__v4__/cdn_frontdoor"
  count  = var.env_short == "p" ? 1 : 0

  cdn_prefix_name     = "${var.prefix}-${var.env_short}-assets-platform"
  location            = var.location
  resource_group_name = azurerm_resource_group.assets_cdn_platform_rg[0].name

  storage_account_error_404_document = "index.html"
  storage_account_index_document     = "index.html"
  storage_account_replication_type   = var.cdn_storage_account_replication_type
  querystring_caching_behaviour      = "UseQueryString"

  custom_domains = [
    {
      domain_name             = "assets.cdn.${azurerm_dns_zone.public[0].name}"
      dns_name                = azurerm_dns_zone.public[0].name
      dns_resource_group_name = azurerm_dns_zone.public[0].resource_group_name
      ttl                     = var.env != "p" ? 300 : 3600
    }
  ]

  global_delivery_rules = [{
    order = 1

    # HSTS
    modify_response_header_actions = [{
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
  }]

  delivery_rule_redirects = [
    {
      name              = "GoTOIndex2"
      order             = 2
      behavior_on_match = "Continue"
      url_path_conditions = [{
        operator         = "Equal"
        match_values     = ["/"]
        negate_condition = false
        transforms       = []
      }]

      url_redirect_actions = [{
        redirect_type = "Found"
        protocol      = "MatchRequest"
        hostname      = "portal.pagopa.gov.it"
        path          = "/pda.html"
        fragment      = ""
        query_string  = ""
        }
      ]
    },
    {
      name              = "PdaPortaltoRoot"
      order             = 3
      behavior_on_match = "Continue"
      url_path_conditions = [{
        operator         = "Equal"
        match_values     = ["/pda-portal/admin/login"]
        negate_condition = false
        transforms       = []
      }]
      url_redirect_actions = [{
        redirect_type = "Found"
        protocol      = "MatchRequest"
        hostname      = "portal.pagopa.gov.it"
        path          = "/pda.html"
        fragment      = ""
        query_string  = ""
        }
      ]
    }
  ]

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

  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id

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