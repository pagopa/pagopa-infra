##################
##Token Exchange##
##################
locals {
  pagopa_cdn_storage_account_name = replace(format("%s-%s-sa", local.project, "pagopacdn"), "-", "") #"cstardweuidpayidpaycdnsa"
  pagopa-oidc-config_url          = "https://${local.pagopa_cdn_storage_account_name}.blob.core.windows.net/pagopa-fe-oidc-config/openid-configuration.json"
  pagopa-portal-hostname          = "welfare.${azurerm_dns_zone.public[0].name}"
  selfcare-issuer                = "https://${var.env != "p" ? "${var.env}." : ""}selfcare.pagopa.it"
}

resource "azurerm_key_vault_certificate" "pagopa_jwt_signing_cert" {
  name         = "${local.project}-${var.domain}-jwt-signing-cert"
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
        action_type = "AutoRenew"
      }

      trigger {
        days_before_expiry = 30
      }
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }

    x509_certificate_properties {
      # Server Authentication = 1.3.6.1.5.5.7.3.1
      # Client Authentication = 1.3.6.1.5.5.7.3.2
      extended_key_usage = ["1.3.6.1.5.5.7.3.2"]
      key_usage = [
        "cRLSign",
        "dataEncipherment",
        "digitalSignature",
        "keyAgreement",
        "keyCertSign",
        "keyEncipherment",
      ]

      subject            = "CN=${local.project}-${var.domain}-jwt-signing-cert"
      validity_in_months = 12
    }
  }
}

resource "azurerm_api_management_certificate" "pagopa_token_exchange_cert_jwt" {
  name                = "${local.project}-${var.domain}-token-exchange-jwt"
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name
  key_vault_secret_id = azurerm_key_vault_certificate.pagopa_jwt_signing_cert.versionless_secret_id
}


resource "azurerm_api_management_api" "pagopa_token_exchange" {
  name                = "${var.env_short}-pagopa-token-exchange"
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name

  revision              = "1"
  display_name          = "PagoPa Token Exchange"
  path                  = "api/token"
  subscription_required = false
  #service_url           = ""
  protocols = ["https"]
}

resource "azurerm_api_management_api_operation" "pagopa_token_exchange" {
  operation_id        = "pagopa-token-exchange"
  api_name            = azurerm_api_management_api.pagopa_token_exchange.name
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name
  display_name        = "PagoPa Token Exchange"
  method              = "POST"
  url_template        = "/token"
  description         = "Endpoint for selfcare token exchange"
}


resource "azurerm_api_management_api_operation_policy" "pagopa_token_exchange_policy" {
  api_name            = azurerm_api_management_api_operation.pagopa_token_exchange.api_name
  api_management_name = azurerm_api_management_api_operation.pagopa_token_exchange.api_management_name
  resource_group_name = azurerm_api_management_api_operation.pagopa_token_exchange.resource_group_name
  operation_id        = azurerm_api_management_api_operation.pagopa_token_exchange.operation_id

  xml_content = templatefile("./api/pagopa_token_exchange/jwt_exchange.xml.tpl", {
    openid-config-url           = local.pagopa-oidc-config_url,
    selfcare-issuer             = local.selfcare-issuer,
    jwt_cert_signing_thumbprint = azurerm_api_management_certificate.pagopa_token_exchange_cert_jwt.thumbprint,
    pagopa-portal-hostname      = local.pagopa-portal-hostname,
  })

}
