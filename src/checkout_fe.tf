/**
 * Checkout resource group
 **/
resource "azurerm_resource_group" "checkout_fe_rg" {
  count    = var.checkout_enabled ? 1 : 0
  name     = format("%s-checkout-fe-rg", local.project)
  location = var.location

  tags = var.tags
}

/**
 * Checkout cdn profile
 **/
resource "azurerm_cdn_profile" "checkout_cdn_p" {
  count               = var.checkout_enabled ? 1 : 0
  name                = format("%s-checkout-cdn-p", local.project)
  resource_group_name = azurerm_resource_group.checkout_fe_rg[0].name
  location            = var.location
  sku                 = "Standard_Microsoft"

  tags = var.tags
}

/**
 * Checkout storage account
 **/
resource "azurerm_storage_account" "checkout_sa" {
  name                      = replace(format("%s-checkout-cdn-sa", local.project), "-", "")
  resource_group_name       = azurerm_resource_group.checkout_fe_rg[0].name
  location                  = var.location
  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "GRS"
  access_tier               = "Hot"
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"
  allow_blob_public_access  = true

  dynamic "static_website" {
    for_each = [{}]
    content {
      index_document     = var.index_path
      error_404_document = var.custom_404_path
    }
  }

  dynamic "blob_properties" {
    for_each = var.soft_delete_retention != null || length(var.cors_rule) != 0 ? [{}] : []
    content {
      dynamic "delete_retention_policy" {
        for_each = var.soft_delete_retention != null ? [{}] : []
        content {
          days = var.soft_delete_retention
        }
      }
      dynamic "cors_rule" {
        for_each = var.cors_rule
        content {
          allowed_origins    = cors_rule.value.allowed_origins
          allowed_methods    = cors_rule.value.allowed_methods
          allowed_headers    = cors_rule.value.allowed_headers
          exposed_headers    = cors_rule.value.exposed_headers
          max_age_in_seconds = cors_rule.value.max_age_in_seconds
        }
      }
    }
  }


  dynamic "network_rules" {
    for_each = var.network_rules == null ? [] : [var.network_rules]

    content {
      default_action             = length(network_rules.value["ip_rules"]) == 0 && length(network_rules.value["virtual_network_subnet_ids"]) == 0 ? network_rules.value["default_action"] : "Deny"
      bypass                     = network_rules.value["bypass"]
      ip_rules                   = network_rules.value["ip_rules"]
      virtual_network_subnet_ids = network_rules.value["virtual_network_subnet_ids"]
    }
  }

  tags = var.tags
}

# Enable advanced threat protection
resource "azurerm_advanced_threat_protection" "advanced_threat_protection" {
  target_resource_id = azurerm_storage_account.checkout_sa.id
  enabled            = false
}

resource "azurerm_template_deployment" "versioning" {
  depends_on          = [azurerm_storage_account.checkout_sa]
  name                = format("%s-sa-versioning", local.project)
  resource_group_name = azurerm_resource_group.checkout_fe_rg[0].name
  deployment_mode     = "Incremental"
  parameters = {
    "storageAccount" = azurerm_storage_account.checkout_sa.name
  }

  template_body = <<DEPLOY
        {
            "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
            "contentVersion": "1.0.0.0",
            "parameters": {
                "storageAccount": {
                    "type": "string",
                    "metadata": {
                        "description": "Storage Account Name"}
                }
            },
            "variables": {},
            "resources": [
                {
                    "type": "Microsoft.Storage/storageAccounts/blobServices",
                    "apiVersion": "2019-06-01",
                    "name": "[concat(parameters('storageAccount'), '/default')]",
                    "properties": {
                        "IsVersioningEnabled": true
                    }
                }
            ]
        }
    DEPLOY
}

# Lock scoping to a Subscription, Resource Group or Resource
resource "azurerm_management_lock" "management_lock" {
  count      = var.lock ? 1 : 0
  name       = azurerm_resource_group.checkout_fe_rg[0].name
  scope      = var.lock_scope
  lock_level = var.lock_level
  notes      = var.lock_notes
}

/**
 * CDN endpoint
 */

resource "azurerm_cdn_endpoint" "checkout_cdn_e" {
  name                          = format("%s-checkout-cdn-p", local.project)
  resource_group_name           = azurerm_resource_group.checkout_fe_rg[0].name
  location                      = var.location
  profile_name                  = azurerm_cdn_profile.checkout_cdn_p[0].name
  is_https_allowed              = true
  is_http_allowed               = true
  querystring_caching_behaviour = "BypassCaching"
  origin_host_header            = azurerm_storage_account.checkout_sa.primary_web_host

  origin {
    name      = "primary"
    host_name = azurerm_storage_account.checkout_sa.primary_web_host
  }
}
