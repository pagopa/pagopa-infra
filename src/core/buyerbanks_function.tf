resource "azurerm_resource_group" "buyerbanks_rg" {
  name     = format("%s-buyerbanks-rg", local.project)
  location = var.location

  tags = var.tags
}

# Subnet to host buyerbanks function
module "buyerbanks_function_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.90"
  name                                           = format("%s-buyerbanks-snet", local.project)
  address_prefixes                               = var.cidr_subnet_buyerbanks
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet.name
  enforce_private_link_endpoint_network_policies = true

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.Storage",
  ]
}

module "buyerbanks_function" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v3.2.5"

  resource_group_name                      = azurerm_resource_group.buyerbanks_rg.name
  name                                     = format("%s-fn-buyerbanks", local.project)
  location                                 = var.location
  health_check_path                        = "/api/v1/info"
  subnet_id                                = module.buyerbanks_function_snet.id
  runtime_version                          = "~4"
  always_on                                = true
  os_type                                  = "linux"
  linux_fx_version                         = "NODE|18"
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_name = format("%s-plan-fnbuyerbanks", local.project)
  app_service_plan_info = {
    kind                         = var.buyerbanks_function_kind
    sku_tier                     = var.buyerbanks_function_sku_tier
    sku_size                     = var.buyerbanks_function_sku_size
    maximum_elastic_worker_count = 0
  }

  storage_account_info = var.function_app_storage_account_info

  storage_account_name = replace(format("%s-st-fnbuyerbanks", local.project), "-", "")

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME          = "node"
    WEBSITE_NODE_DEFAULT_VERSION      = "18.16.0"
    FUNCTIONS_WORKER_PROCESS_COUNT    = 4
    NODE_ENV                          = var.env_short == "p" ? "production" : "uat"
    BUYERBANKS_SA_CONNECTION_STRING   = module.buyerbanks_storage.primary_connection_string
    BUYERBANKS_BLOB_CONTAINER         = azurerm_storage_container.banks.name
    PAGOPA_BUYERBANKS_CERT            = azurerm_key_vault_certificate.buyerbanks_cert.certificate_data_base64
    PAGOPA_BUYERBANKS_THUMBPRINT      = data.azurerm_key_vault_secret.pagopa_buyerbank_thumbprint.value
    PAGOPA_BUYERBANKS_KEY_CERT        = data.azurerm_key_vault_secret.pagopa_buyerbank_cert_key.value
    PAGOPA_BUYERBANKS_BRANCH          = "10000"
    PAGOPA_BUYERBANKS_CERT_PASSPHRASE = ""
    PAGOPA_BUYERBANKS_INSTITUTE       = "1000"
    PAGOPA_BUYERBANKS_RS_URL          = var.env_short == "p" ? "https://rs-pr.mybankpayments.eu" : "https://rs-te.mybankpayments.eu"
    PAGOPA_BUYERBANKS_SIGNATURE       = trimspace(data.azurerm_key_vault_secret.pagopa_buyerbank_signature.value)
    PAGOPA_BUYERBANKS_SIGN_ALG        = "RSA-SHA256"
    PAGOPA_BUYERBANKS_SIGN_ALG_STRING = "SHA256withRSA"
    PAGOPA_BUYERBANKS_CERT_PEER       = var.env_short == "p" ? data.azurerm_key_vault_secret.pagopa_buyerbank_cert_peer[0].value : null
    PAGOPA_BUYERBANKS_THUMBPRINT_PEER = var.env_short == "p" ? data.azurerm_key_vault_secret.pagopa_buyerbank_thumbprint_peer[0].value : null
  }

  allowed_subnets = [data.azurerm_subnet.apim_snet.id]

  allowed_ips = []

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "buyerbanks_function" {

  name                = format("%s-autoscale", module.buyerbanks_function.name)
  resource_group_name = azurerm_resource_group.buyerbanks_rg.name
  location            = var.location
  target_resource_id  = module.buyerbanks_function.app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.buyerbanks_function_autoscale_default
      minimum = var.buyerbanks_function_autoscale_minimum
      maximum = var.buyerbanks_function_autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.buyerbanks_function.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 4000
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.buyerbanks_function.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 3000
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT20M"
      }
    }
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "buyerbanks_update_alert" {
  count = var.env_short == "p" ? 1 : 0

  name                = format("%s-availability-alert", module.buyerbanks_function.name)
  resource_group_name = azurerm_resource_group.buyerbanks_rg.name
  location            = var.location

  action {
    action_group           = [azurerm_monitor_action_group.email.id, azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  data_source_id = azurerm_application_insights.application_insights.id
  description    = "Availability greater than or equal 99%"
  enabled        = true
  query = format(<<-QUERY
  requests
    | where cloud_RoleName == '%s'
    | where name contains "UpdateBuyerBanks"
    | summarize Sucess=count(success == true) by length=bin(timestamp,24h)
    | where toint(Sucess) < 1

  QUERY
  , format("%s", module.buyerbanks_function.name))
  severity    = 1
  frequency   = 60
  time_window = 1440
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

#tfsec:ignore:azure-storage-default-action-deny
module "buyerbanks_storage" {

  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v2.0.28"

  name                       = replace(format("%s-buyerbanks-storage", local.project), "-", "")
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  account_replication_type   = var.buyer_banks_storage_account_replication_type
  access_tier                = "Hot"
  versioning_name            = "versioning"
  enable_versioning          = var.buyerbanks_enable_versioning
  resource_group_name        = azurerm_resource_group.buyerbanks_rg.name
  location                   = var.location
  advanced_threat_protection = var.buyerbanks_advanced_threat_protection
  allow_blob_public_access   = false

  blob_properties_delete_retention_policy_days = var.buyerbanks_delete_retention_days

  # TODO FIXME
  # network_rules = {
  #   default_action             = "Deny"
  #   ip_rules                   = []
  #   bypass                     = ["AzureServices"]
  #   virtual_network_subnet_ids = [module.buyerbanks_function_snet.id]
  # }

  tags = var.tags
}

## blob container buyerbanks
resource "azurerm_storage_container" "banks" {

  name                  = "banks"
  storage_account_name  = module.buyerbanks_storage.name
  container_access_type = "private"
}

# 🐞https://github.com/hashicorp/terraform-provider-azurerm/pull/15832
## blob lifecycle policy
resource "azurerm_storage_management_policy" "buyerbanks_storage_lifeclycle_policies" {
  storage_account_id = module.buyerbanks_storage.id

  rule {
    name    = "BlobRetentionRule"
    enabled = true
    filters {
      prefix_match = ["banks/"]
      blob_types   = ["blockBlob"]
    }
    actions {
      base_blob {
        delete_after_days_since_modification_greater_than           = 30
        tier_to_cool_after_days_since_last_access_time_greater_than = 0
      }
      snapshot {
        delete_after_days_since_creation_greater_than = 30
      }
    }
  }

}

/*
 * KEY cert - buyerbanks functions
 */
data "azurerm_key_vault_secret" "pagopa_buyerbank_cert_key" {
  name         = "pagopa-buyerbank-cert-key"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

/*
 * Cert thumbprint - buyerbanks functions
 */
data "azurerm_key_vault_secret" "pagopa_buyerbank_thumbprint" {
  name         = "pagopa-buyerbank-thumbprint"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

/*
 * Body signature - buyerbanks functions
 */
data "azurerm_key_vault_secret" "pagopa_buyerbank_signature" {
  name         = "pagopa-buyerbank-signature"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

/*
 * MyBank certificate for response authentication
 */
data "azurerm_key_vault_secret" "pagopa_buyerbank_cert_peer" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "pagopa-buyerbank-cert-peer"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

/*
 * MyBank certificate thumbprint
 */
data "azurerm_key_vault_secret" "pagopa_buyerbank_thumbprint_peer" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "pagopa-buyerbank-thumbprint-peer"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

/*
 * X.509 cert - buyerbanks functions
 */
resource "azurerm_key_vault_certificate" "buyerbanks_cert" {

  name = format("%s-buyerbanks-cert", local.project) # module.buyerbanks_function.name

  key_vault_id = data.azurerm_key_vault.key_vault.id

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = true
      key_size   = 2048
      key_type   = "RSA"
      reuse_key  = true
    }

    lifetime_action {
      action {
        action_type = "EmailContacts"
      }

      trigger {
        days_before_expiry = 30
      }
    }

    secret_properties {
      content_type = "application/x-pem-file"
    }

    x509_certificate_properties {

      key_usage = [
        "digitalSignature",
        "nonRepudiation"
      ]

      subject            = var.env_short == "p" ? format("CN=%s-buyerbanks", local.project) : format("CN=%s-buyerbanks-%s", local.project, var.env_short)
      validity_in_months = 12
    }
  }
}
