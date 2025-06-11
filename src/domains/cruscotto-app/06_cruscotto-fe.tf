/**
 * crusc8 resource group
 **/
resource "azurerm_resource_group" "crusc8_fe_rg" {
  name     = "${local.project_weu}-fe-rg" #-${var.domain}
  location = var.location_weu

  tags = module.tag_config.tags
}

locals {
  spa = [
    for i, spa in var.spa :
    {
      name  = replace("SPA-${spa}", "-", "")
      order = i + 3
      // +3 required because the order start from 1: 1 is reserved for default application redirect; 2 is reserved for the https rewrite;
      conditions = [
        {
          condition_type   = "url_path_condition"
          operator         = "BeginsWith"
          match_values     = ["/${spa}/"]
          negate_condition = false
          transforms       = null
        },
        {
          condition_type   = "url_file_extension_condition"
          operator         = "LessThanOrEqual"
          match_values     = ["0"]
          negate_condition = false
          transforms       = null
        },
      ]
      url_rewrite_action = {
        source_pattern          = "/${spa}/"
        destination             = "/${spa}/index.html"
        preserve_unmatched_path = false
      }
    }
  ]
  cors = {
    paths = ["/assets/"]
  }
}

/**
 * CDN
 */
// public storage used to serve FE
#tfsec:ignore:azure-storage-default-action-deny
module "crusc8_cdn" {
  source = "./.terraform/modules/__v4__/cdn"

  name                = "crusc8"
  prefix              = local.product
  resource_group_name = azurerm_resource_group.crusc8_fe_rg.name
  location            = var.location_weu
  #                       crusc8.<ENV>.platform.pagopa.it
  hostname              = "${local.dns_zone_crusc8}.${local.dns_zone_platform}.${local.external_domain}"
  https_rewrite_enabled = true

  index_document     = "index.html"
  error_404_document = "index.html"

  #                             <ENV>.platform.pagopa.it
  # create_dns_record            = false # Skip creation
  dns_zone_name                = "${local.dns_zone_platform}.${local.external_domain}"
  dns_zone_resource_group_name = local.vnet_resource_group_name_weu

  keyvault_resource_group_name = data.azurerm_key_vault.kv.resource_group_name
  keyvault_subscription_id     = data.azurerm_subscription.current.subscription_id
  keyvault_vault_name          = data.azurerm_key_vault.kv.name

  querystring_caching_behaviour = "BypassCaching"

  storage_account_replication_type = var.crusc8_storage_replication_type

  global_delivery_rule = {
    cache_expiration_action       = []
    cache_key_query_string_action = []
    modify_request_header_action  = []

    # HSTS
    modify_response_header_action = [
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

  delivery_rule_rewrite = concat([
    {
      name  = "RewriteRules"
      order = 2
      conditions = [
        {
          condition_type   = "url_path_condition"
          operator         = "Equal"
          match_values     = ["/"]
          negate_condition = false
          transforms       = null
        }
      ]
      url_rewrite_action = {
        source_pattern          = "/"
        destination             = "/ui/index.html"
        preserve_unmatched_path = false
      }
    }
    ],
    local.spa
  )

  delivery_rule = [
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

  tags                       = module.tag_config.tags
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics_italy.id
}


## forced creata CNAME to fqdn DNS extaranl from module
resource "null_resource" "custom_hostname_cruscotto" {

  # - triggers = {
  #     - "endpoint_name"       = "pagopa-d-crusc8-cdn-endpoint"
  #     - "hostname"            = "crusc8.dev.platform.pagopa.it"
  #     - "name"                = "crusc8.dev.platform.pagopa.it"
  #     - "profile_name"        = "pagopa-d-crusc8-cdn-profile"
  #     - "resource_group_name" = "pagopa-d-weu-crusc8-fe-rg"
  #   } -> null

  triggers = {
    resource_group_name = azurerm_resource_group.crusc8_fe_rg.name
    endpoint_name       = "pagopa-${var.env_short}-crusc8-cdn-endpoint"
    profile_name        = "pagopa-${var.env_short}-crusc8-cdn-profile"
    name                = "${local.dns_zone_crusc8}.${local.dns_zone_platform}.${local.external_domain}"
    hostname            = "${local.dns_zone_crusc8}.${local.dns_zone_platform}.${local.external_domain}"
  }

  # https://docs.microsoft.com/it-it/cli/azure/cdn/custom-domain?view=azure-cli-latest
  provisioner "local-exec" {
    command = <<EOT
      az cdn custom-domain create \
        --resource-group ${self.triggers.resource_group_name} \
        --endpoint-name ${self.triggers.endpoint_name} \
        --profile-name ${self.triggers.profile_name} \
        --name ${replace(self.triggers.name, ".", "-")} \
        --hostname ${self.triggers.hostname} && \
      az cdn custom-domain enable-https \
        --resource-group ${self.triggers.resource_group_name} \
        --endpoint-name ${self.triggers.endpoint_name} \
        --profile-name ${self.triggers.profile_name} \
        --name ${replace(self.triggers.name, ".", "-")} \
        --min-tls-version "1.2"
    EOT
  }
  # https://docs.microsoft.com/it-it/cli/azure/cdn/custom-domain?view=azure-cli-latest
  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
      az cdn custom-domain disable-https \
        --resource-group ${self.triggers.resource_group_name} \
        --endpoint-name ${self.triggers.endpoint_name} \
        --profile-name ${self.triggers.profile_name} \
        --name ${replace(self.triggers.name, ".", "-")} && \
      az cdn custom-domain delete \
        --resource-group ${self.triggers.resource_group_name} \
        --endpoint-name ${self.triggers.endpoint_name} \
        --profile-name ${self.triggers.profile_name} \
        --name ${replace(self.triggers.name, ".", "-")}
    EOT
  }
}

resource "azurerm_dns_cname_record" "hostname_cruscotto" {
  name                = trimsuffix(replace("${local.dns_zone_crusc8}.${local.dns_zone_platform}.${local.external_domain}", "${local.dns_zone_platform}.${local.external_domain}", ""), ".")
  zone_name           = "${local.dns_zone_platform}.${local.external_domain}"
  resource_group_name = "pagopa-${var.env_short}-vnet-rg"
  ttl                 = 3600
  #   value = var.create_dns_record ? var.dns_zone_name == var.hostname ? trimsuffix(azurerm_dns_a_record.apex_hostname[0].fqdn, ".") : trimsuffix(azurerm_dns_cname_record.hostname[0].fqdn, ".") : null
  record = "pagopa-${var.env_short}-crusc8-cdn-endpoint.azureedge.net"

  tags = module.tag_config.tags


  # depends_on = [ null_resource.custom_hostname_cruscotto ]
}


#tfsec:ignore:azure-keyvault-ensure-secret-expiry
resource "azurerm_key_vault_secret" "crusc8_web_storage_access_key" {
  name         = "web-storage-access-key"
  value        = module.crusc8_cdn.storage_primary_access_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry
resource "azurerm_key_vault_secret" "crusc8_web_storage_connection_string" {
  name         = "web-storage-connection-string"
  value        = module.crusc8_cdn.storage_primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry
resource "azurerm_key_vault_secret" "crusc8_web_storage_blob_connection_string" {
  name         = "web-storage-blob-connection-string"
  value        = module.crusc8_cdn.storage_primary_blob_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}


resource "azurerm_static_web_app" "crusc8_static_web_app" {
  count = var.env_short == "d" ? 1 : 0

  name                = "${var.prefix}-${var.env_short}-${var.domain}-fe"
  resource_group_name = azurerm_resource_group.crusc8_fe_rg.name
  location            = var.location_weu

  sku_tier = "Standard"
  sku_size = "Standard"
}

resource "azurerm_key_vault_secret" "crusc8_static_app_key" {
  count = var.env_short == "d" ? 1 : 0

  name         = "crusc8-static-app-key"
  value        = azurerm_static_web_app.crusc8_static_web_app[0].api_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}
