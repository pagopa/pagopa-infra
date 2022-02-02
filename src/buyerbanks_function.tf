resource "azurerm_resource_group" "buyerbanks_rg" {
  name     = format("%s-buyerbanks-rg", local.project)
  location = var.location

  tags = var.tags
}

# Subnet to host buyerbanks function
module "buyerbanks_function_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
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
}

module "buyerbanks_function" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v1.0.84"

  resource_group_name                      = azurerm_resource_group.buyerbanks_rg.name
  prefix                                   = var.prefix
  env_short                                = var.env_short
  name                                     = "buyerbanks"
  location                                 = var.location
  health_check_path                        = "info"
  subnet_out_id                            = module.buyerbanks_function_snet.id
  runtime_version                          = "~3"
  always_on                                = var.env_short == "p" ? true : false
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_info = {
    kind                         = var.buyerbanks_function_kind
    sku_tier                     = var.buyerbanks_function_sku_tier
    sku_size                     = var.buyerbanks_function_sku_size
    maximum_elastic_worker_count = 0
  }

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME          = "node"
    WEBSITE_NODE_DEFAULT_VERSION      = "14.16.0"
    FUNCTIONS_WORKER_PROCESS_COUNT    = 4
    NODE_ENV                          = "production"
    BUYERBANKS_SA_CONNECTION_STRING   = module.buyerbanks_storage.primary_connection_string
    BUYERBANKS_BLOB_CONTAINER         = azurerm_storage_container.banks.name
    PAGOPA_BUYERBANKS_CERT            = azurerm_key_vault_certificate.buyerbanks_cert.certificate_data_base64
    PAGOPA_BUYERBANKS_THUMBPRINT      = data.azurerm_key_vault_secret.pagopa_buyerbank_thumbprint.value
    PAGOPA_BUYERBANKS_KEY_CERT        = data.azurerm_key_vault_secret.pagopa_buyerbank_cert_key.value
    PAGOPA_BUYERBANKS_BRANCH          = "10000"
    PAGOPA_BUYERBANKS_CERT_PASSPHRASE = ""
    PAGOPA_BUYERBANKS_INSTITUTE       = "1000"
    PAGOPA_BUYERBANKS_RS_URL          = "https://rs-te.mybankpayments.eu"
    PAGOPA_BUYERBANKS_SIGNATURE       = data.azurerm_key_vault_secret.pagopa_buyerbank_signature.value
    PAGOPA_BUYERBANKS_SIGN_ALG        = "RSA-SHA256"
    PAGOPA_BUYERBANKS_SIGN_ALG_STRING = "SHA256withRSA"
  }

  allowed_subnets = [module.apim_snet.id]

  allowed_ips = []

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "buyerbanks_function" {

  name                = format("%s-%s-autoscale", local.project, module.buyerbanks_function.name)
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

# Availability: Alerting Action
resource "azurerm_monitor_scheduled_query_rules_alert" "buyerbanks_availability" {
  count = var.env_short == "p" ? 1 : 0

  name                = format("%s-%s-availability-alert", local.project, module.buyerbanks_function.name)
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
    | summarize Total=count(), Success=count(toint(resultCode) >= 200 and toint(resultCode) < 500 ) by length=bin(timestamp,15m)
    | extend Availability=((Success*1.0)/Total)*100
    | where toint(Availability) < 99

  QUERY
  , format("%s-fn-%s", local.project, module.buyerbanks_function.name))
  severity    = 1
  frequency   = 45
  time_window = 45
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 3
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "buyerbanks_update_alert" {
  count = var.env_short == "p" ? 1 : 0

  name                = format("%s-%s-availability-alert", local.project, module.buyerbanks_function.name)
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
    | where toint(Sucess) >= 1

  QUERY
  , format("%s-fn-%s", local.project, module.buyerbanks_function.name))
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

  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v2.0.13"

  name                       = replace(format("%s-buyerbanks-storage", local.project), "-", "")
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  account_replication_type   = "LRS"
  access_tier                = "Hot"
  versioning_name            = "versioning"
  enable_versioning          = var.buyerbanks_enable_versioning
  resource_group_name        = azurerm_resource_group.buyerbanks_rg.name
  location                   = var.location
  advanced_threat_protection = var.buyerbanks_advanced_threat_protection
  allow_blob_public_access   = false

  blob_properties_delete_retention_policy_days = var.buyerbanks_delete_retention_days

  tags = var.tags
}

## blob container buyerbanks
resource "azurerm_storage_container" "banks" {

  name                  = "banks"
  storage_account_name  = module.buyerbanks_storage.name
  container_access_type = "private"
}

/*
 * KEY cert - buyerbanks functions
 */
data "azurerm_key_vault_secret" "pagopa_buyerbank_cert_key" {
  name         = "pagopa-buyerbank-cert-key"
  key_vault_id = module.key_vault.id
}

/*
 * Cert thumbprint - buyerbanks functions
 */
data "azurerm_key_vault_secret" "pagopa_buyerbank_thumbprint" {
  name         = "pagopa-buyerbank-thumbprint"
  key_vault_id = module.key_vault.id
}

/*
 * Body signature - buyerbanks functions
 */
data "azurerm_key_vault_secret" "pagopa_buyerbank_signature" {
  name         = "pagopa-buyerbank-signature"
  key_vault_id = module.key_vault.id
}


/*
 * X.509 cert - buyerbanks functions
 */
resource "azurerm_key_vault_certificate" "buyerbanks_cert" {

  name         = format("%s-%s-cert", local.project, module.buyerbanks_function.name)
  key_vault_id = module.key_vault.id

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
