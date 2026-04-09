module "api_config_fe_cdn_frontdoor" {
  source = "./.terraform/modules/__v4__/cdn_frontdoor"
  count  = var.api_config_fe_enabled ? 1 : 0

  cdn_prefix_name     = "${local.product}-api-config-fe"
  resource_group_name = azurerm_resource_group.api_config_fe_rg[0].name
  location            = var.location

  custom_domains = [
    {
      domain_name             = "${var.cname_record_name}.${var.apim_dns_zone_prefix}.${var.external_domain}"
      dns_name                = data.azurerm_dns_zone.public.name
      dns_resource_group_name = data.azurerm_dns_zone.public.resource_group_name
      ttl                     = var.env != "p" ? 300 : 3600
    }
  ]

  storage_account_replication_type   = var.cdn_storage_account_replication_type
  storage_account_index_document     = "index.html"
  storage_account_error_404_document = "not_found.html"

  querystring_caching_behaviour = "IgnoreQueryString"

  delivery_rule_rewrites = [{
    name  = "RewriteRules"
    order = 2

    url_file_extension_conditions = [{
      condition_type   = "url_file_extension_condition"
      operator         = "LessThan"
      match_values     = ["1"]
      transforms       = []
      negate_condition = false
    }]

    url_rewrite_actions = [{
      source_pattern          = "/"
      destination             = "/index.html"
      preserve_unmatched_path = false
    }]
  }]

  global_delivery_rules = [{
    order                         = 1
    cache_expiration_action       = []
    cache_key_query_string_action = []
    modify_request_header_action  = []

    # HSTS
    modify_response_header_actions = [{
      action = "Overwrite"
      name   = "Strict-Transport-Security"
      value  = "max-age=31536000"
      },
      # Content-Security-Policy (in Report mode)
      {
        action = "Overwrite"
        name   = "Content-Security-Policy-Report-Only"
        value = format("object-src 'none'; connect-src 'self' https://api.%s.%s/; script-src https://api.%s.%s/"
        , var.apim_dns_zone_prefix, var.external_domain, var.apim_dns_zone_prefix, var.external_domain)
      }
    ]
  }]

  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics.id

  tags = module.tag_config.tags
}

moved {
  from = module.api_config_fe_cdn[0].module.cdn_storage_account
  to   = module.api_config_fe_cdn_frontdoor[0].module.cdn_storage_account
}