/**
 * Checkout resource group
 **/
resource "azurerm_resource_group" "checkout_fe_rg" {
  count    = var.checkout_enabled ? 1 : 0
  name     = format("%s-checkout-fe-rg", local.parent_project)
  location = var.location

  tags = var.tags
}

/**
 * CDN
 */
module "checkout_cdn" {
  source = "git::https://github.com/pagopa/azurerm.git//cdn?ref=v2.0.28"

  count                 = var.checkout_enabled ? 1 : 0
  name                  = "checkout"
  prefix                = local.parent_project
  resource_group_name   = azurerm_resource_group.checkout_fe_rg[0].name
  location              = var.location
  hostname              = format("%s.%s", var.dns_zone_checkout, var.external_domain)
  https_rewrite_enabled = true
  lock_enabled          = false

  index_document     = "index.html"
  error_404_document = "index.html"

  dns_zone_name                = data.azurerm_dns_zone.checkout_public[0].name
  dns_zone_resource_group_name = data.azurerm_dns_zone.checkout_public[0].resource_group_name

  keyvault_resource_group_name = data.azurerm_key_vault.key_vault.resource_group_name
  keyvault_subscription_id     = data.azurerm_subscription.current.subscription_id
  keyvault_vault_name          = data.azurerm_key_vault.key_vault.name

  querystring_caching_behaviour = "BypassCaching"

  storage_account_replication_type = var.checkout_cdn_storage_replication_type

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
        name   = var.env_short == "p" ? "Content-Security-Policy-Report-Only" : "Content-Security-Policy"
        value  = format("default-src 'self'; connect-src 'self' https://api.%s.%s https://api-eu.mixpanel.com https://wisp2.pagopa.gov.it", var.dns_zone_prefix, var.external_domain)
      },
      {
        action = "Append"
        name   = var.env_short == "p" ? "Content-Security-Policy-Report-Only" : "Content-Security-Policy"
        value  = " https://acardste.vaservices.eu:* https://cdn.cookielaw.org https://privacyportal-de.onetrust.com https://geolocation.onetrust.com;"
      },
      {
        action = "Append"
        name   = var.env_short == "p" ? "Content-Security-Policy-Report-Only" : "Content-Security-Policy"
        value  = "frame-ancestors 'none'; object-src 'none'; frame-src 'self' https://www.google.com *.platform.pagopa.it *.sia.eu *.nexigroup.com *.recaptcha.net recaptcha.net https://recaptcha.google.com;"
      },
      {
        action = "Append"
        name   = var.env_short == "p" ? "Content-Security-Policy-Report-Only" : "Content-Security-Policy"
        value  = "img-src 'self' https://cdn.cookielaw.org https://acardste.vaservices.eu:* https://wisp2.pagopa.gov.it https://assets.cdn.io.italia.it www.gstatic.com/recaptcha data:;"
      },
      {
        action = "Append"
        name   = var.env_short == "p" ? "Content-Security-Policy-Report-Only" : "Content-Security-Policy"
        value  = "script-src 'self' 'unsafe-inline' https://www.google.com https://www.gstatic.com https://cdn.cookielaw.org https://geolocation.onetrust.com https://www.recaptcha.net https://recaptcha.net https://www.gstatic.com/recaptcha/ https://www.gstatic.cn/recaptcha/;"
      },
      {
        action = "Append"
        name   = var.env_short == "p" ? "Content-Security-Policy-Report-Only" : "Content-Security-Policy"
        value  = "style-src 'self'  'unsafe-inline'; worker-src www.recaptcha.net blob:;"
      }
    ]
  }

  delivery_rule_rewrite = [{
    name  = "RewriteRules"
    order = 2

    conditions = [{
      condition_type   = "url_path_condition"
      operator         = "EndsWith"
      match_values     = ["/dona", "/dona/"]
      transforms       = []
      negate_condition = false
    }]

    url_rewrite_action = {
      source_pattern          = "/"
      destination             = "/dona.html"
      preserve_unmatched_path = false
    }
    },
    {
      name  = "RewriteRulesPaymentTransactionsGateway"
      order = 3

      conditions = [{
        condition_type   = "url_path_condition"
        operator         = "BeginsWith"
        match_values     = ["/payment-transactions-gateway/vpos", "/payment-transactions-gateway/postepay", "/payment-transactions-gateway/xpay"]
        transforms       = []
        negate_condition = false
      }]

      url_rewrite_action = {
        source_pattern          = "/"
        destination             = "/payment-transactions-gateway/index.html"
        preserve_unmatched_path = false
      }
  }]

  tags = var.tags
}

resource "azurerm_application_insights_web_test" "checkout_fe_web_test" {
  count                   = var.checkout_enabled && var.env_short == "p" ? 1 : 0
  name                    = format("%s-checkout-fe-web-test", local.parent_project)
  location                = var.location
  resource_group_name     = data.azurerm_resource_group.monitor_rg.name
  application_insights_id = data.azurerm_application_insights.application_insights.id
  kind                    = "ping"
  frequency               = 300
  timeout                 = 10
  enabled                 = true
  geo_locations           = ["emea-nl-ams-azr"]

  configuration = <<XML
<WebTest Name="checkout_fe_web_test" Id="ABD48585-0831-40CB-9069-682EA6BB3583" Enabled="True" CssProjectStructure="" CssIteration="" Timeout="10" WorkItemIds=""
    xmlns="http://microsoft.com/schemas/VisualStudio/TeamTest/2010" Description="" CredentialUserName="" CredentialPassword="" PreAuthenticate="True" Proxy="default" StopOnError="False" RecordedResultFile="" ResultsLocale="">
    <Items>
        <Request Method="GET" Guid="a5f10126-e4cd-570d-961c-cea43999a200" Version="1.1" Url="${format("https://%s.%s/index.html", var.dns_zone_checkout, var.external_domain)}" ThinkTime="0" Timeout="10" ParseDependentRequests="False" FollowRedirects="True" RecordResult="True" Cache="False" ResponseTimeGoal="0" Encoding="utf-8" ExpectedHttpStatusCode="200" ExpectedResponseUrl="" ReportingName="" IgnoreHttpStatusCode="False" />
    </Items>
</WebTest>
XML

}
