##################
##Token Exchange##
##################
locals {
  #                                         pagopa-<env_short>-wue-selfcare
  pagopa_cdn_storage_account_name = replace("${local.product}-${var.domain}-sa", "-", "")
  pagopa-oidc-config_url          = "https://${local.pagopa_cdn_storage_account_name}.blob.core.windows.net/pagopa-fe-oidc-config/openid-configuration.json"
  pagopa-portal-hostname          = "welfare.${local.dns_zone_platform}.${local.external_domain}"
  selfcare-issuer                 = "https://${var.env_short != "p" ? "${var.env}." : ""}selfcare.pagopa.it"
  selfcare-jwt-issuer             = "https://${var.env_short == "d" ? "${var.env}." : ""}selfcare.pagopa.it"
  pagopa-issuer                   = "https://api.${var.env_short != "p" ? "${var.env}." : ""}platform.pagopa.it"
  cert_subject                    = "${local.project}-jwt-signing-cert"
}


# Container for oidc configuration
resource "azurerm_storage_container" "pagopa_oidc_config" {
  name                  = "pagopa-fe-oidc-config"
  storage_account_name  = local.pagopa_cdn_storage_account_name
  container_access_type = "blob"
}

## Upload file for oidc configuration
resource "local_file" "oidc_configuration_file" {
  filename = "./.terraform/tmp/openid-configuration.json"

  content = templatefile("./api/pagopa_token_exchange/openid-configuration.json.tpl", {
    selfcare-issuer = local.selfcare-jwt-issuer
  })

}

resource "null_resource" "upload_oidc_configuration" {
  triggers = {
    "changes-in-config" : md5(local_file.oidc_configuration_file.content)
  }

  provisioner "local-exec" {
    command = <<EOT
              az storage azcopy blob upload --container ${azurerm_storage_container.pagopa_oidc_config.name} --account-name ${local.pagopa_cdn_storage_account_name} --source ${local_file.oidc_configuration_file.filename} --account-key ${data.azurerm_key_vault_secret.cdn_storage_access_secret.value}
          EOT
  }
}

data "azurerm_key_vault_secret" "cdn_storage_access_secret" {
  name         = "web-storage-access-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

# from cstar
resource "azurerm_key_vault_certificate" "pagopa_jwt_signing_cert" {
  name         = "${local.project}-jwt-signing-cert"
  key_vault_id = data.azurerm_key_vault.kv.id

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

      subject            = "CN=${local.project}-jwt-signing-cert"
      validity_in_months = 12
    }
  }
}

data "azurerm_key_vault_certificate_data" "pagopa_token_exchange_cert_jwt_public" {
  depends_on   = [azurerm_key_vault_certificate.pagopa_jwt_signing_cert]
  name         = "${local.project}-jwt-signing-cert"
  key_vault_id = data.azurerm_key_vault.kv.id
}

# output "jwt_signing_cert_pem" {
#   value = data.azurerm_key_vault_certificate_data.pagopa_token_exchange_cert_jwt_public.pem
# }

# Public key loaded from a terraform-generated private key, using the PEM (RFC 1421) format
data "tls_public_key" "private_key_pem" {
  depends_on      = [data.azurerm_key_vault_certificate_data.pagopa_token_exchange_cert_jwt_public]
  private_key_pem = data.azurerm_key_vault_certificate_data.pagopa_token_exchange_cert_jwt_public.key
}

resource "azurerm_key_vault_secret" "jwt_pub_key" {
  depends_on   = [data.tls_public_key.private_key_pem]
  name         = "${local.project}-jwt-pub-key"
  value        = data.tls_public_key.private_key_pem.public_key_pem
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_api_management_certificate" "pagopa_token_exchange_cert_jwt" {
  name                = "${local.project}-token-exchange-jwt"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  key_vault_secret_id = azurerm_key_vault_certificate.pagopa_jwt_signing_cert.versionless_secret_id
}


resource "azurerm_api_management_api" "pagopa_token_exchange" {
  name                = "${var.env_short}-pagopa-token-exchange"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

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
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
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
    openid-config-url      = local.pagopa-oidc-config_url,
    selfcare-issuer        = local.selfcare-jwt-issuer,
    pagopa-issuer          = local.pagopa-issuer,
    cert_cn                = local.cert_subject,
    pagopa-portal-hostname = local.pagopa-portal-hostname,
    origin                 = local.selfcare_fe_hostname,
  })

}

################################
## Token Exchange API - v1    ##
################################
locals {
  pagopa_token_exchange_v1_api = {
    display_name          = "PagoPA Token Exchange API"
    description           = "Exchange a Selfcare or pagoPA session token for a pagoPA platform token"
    path                  = "backoffice/selfcare/sso"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "pagopa_token_exchange_v1" {
  name                = "${var.env_short}-pagopa-token-exchange-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.pagopa_token_exchange_v1_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pagopa_token_exchange_v1" {
  source = "./.terraform/modules/__v4__/api_management_api"

  name                  = "${local.project}-token-exchange-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_selfcare_product.product_id]
  subscription_required = local.pagopa_token_exchange_v1_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pagopa_token_exchange_v1.id
  api_version           = "v1"

  description  = local.pagopa_token_exchange_v1_api.description
  display_name = local.pagopa_token_exchange_v1_api.display_name
  path         = local.pagopa_token_exchange_v1_api.path
  protocols    = ["https"]
  service_url  = local.pagopa_token_exchange_v1_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/pagopa-selfcare-ms-backoffice/sso/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/pagopa-selfcare-ms-backoffice/sso/v1/_base_policy.xml.tpl", {
    openid-config-url = local.pagopa-oidc-config_url
    selfcare-issuer   = local.selfcare-jwt-issuer
    pagopa-issuer     = local.pagopa-issuer
    cert_cn           = local.cert_subject
    origin            = local.selfcare_fe_hostname
  })
}
