##################
##Token Exchange##
##################
locals {
  pagopa_cdn_storage_account_name = replace(format("%s-%s-sa", local.project, "selc"), "-", "")
  pagopa-oidc-config_url          = "https://${local.pagopa_cdn_storage_account_name}.blob.core.windows.net/pagopa-fe-oidc-config/openid-configuration.json"
  pagopa-portal-hostname          = "welfare.${local.dns_zone_platform}.${local.external_domain}"
  selfcare-issuer                 = "https://${var.env != "p" ? "${var.env}." : ""}selfcare.pagopa.it"
  pagopa-issuer                   = "https://api.${var.env != "p" ? "${var.env}." : ""}platform.pagopa.it"
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
    selfcare-issuer = local.selfcare-issuer
  })

}

resource "null_resource" "upload_oidc_configuration" {
  triggers = {
    "changes-in-config" : md5(local_file.oidc_configuration_file.content)
  }

  provisioner "local-exec" {
    command = <<EOT
              az storage azcopy blob upload --container ${azurerm_storage_container.pagopa_oidc_config.name} --account-name ${replace(format("%s-%s-sa", local.project, "selc"), "-", "")} --source ${local_file.oidc_configuration_file.filename} --account-key ${data.azurerm_key_vault_secret.cdn_storage_access_secret.value}
          EOT
  }
}

data "azurerm_key_vault_secret" "cdn_storage_access_secret" {
  name         = "web-storage-access-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

# from cstar
resource "azurerm_key_vault_certificate" "pagopa_jwt_signing_cert" {
  name         = "${local.project}-${var.domain}-jwt-signing-cert"
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

      subject            = "CN=${local.project}-${var.domain}-jwt-signing-cert"
      validity_in_months = 12
    }
  }
}

from selfcare

module "key_vault" {
  source              = "git::https://github.com/pagopa/azurerm.git//key_vault?ref=v2.12.1"
  name                = data.azurerm_key_vault.kv.name
  location            = azurerm_resource_group.sec_rg.location
  resource_group_name = data.azurerm_key_vault.kv.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  lock_enable         = var.lock_enable

  # Security Logs
  sec_log_analytics_workspace_id = var.env_short == "p" ? data.azurerm_key_vault_secret.sec_workspace_id[0].value : null
  sec_storage_id                 = var.env_short == "p" ? data.azurerm_key_vault_secret.sec_storage_id[0].value : null

  tags = var.tags
}

# JWT
# module "jwt" {
#   source = "git::https://github.com/pagopa/azurerm.git//jwt_keys?ref=v2.12.1"

#   jwt_name         = "jwt"
#   key_vault_id     = module.key_vault.id
#   cert_common_name = "apim"
#   cert_password    = ""
#   tags             = var.tags
# }

# # from selfcare
# resource "pkcs12_from_pem" "jwt_pkcs12" {
#   password        = ""
#   cert_pem        = module.jwt.certificate_data_pem
#   private_key_pem = module.jwt.jwt_private_key_pem
# }

# # from selfcare
# resource "azurerm_api_management_certificate" "jwt_certificate" {
#   name                = "jwt-spid-crt"
#   api_management_name = module.apim.name
#   resource_group_name = azurerm_resource_group.rg_api.name
#   data                = pkcs12_from_pem.jwt_pkcs12.result
# }

resource "azurerm_api_management_certificate" "pagopa_token_exchange_cert_jwt" {
  name                = "${local.project}-${var.domain}-token-exchange-jwt"
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
    openid-config-url           = local.pagopa-oidc-config_url,
    selfcare-issuer             = local.selfcare-issuer,
    pagopa-issuer               = local.pagopa-issuer,
    jwt_cert_signing_thumbprint = azurerm_api_management_certificate.pagopa_token_exchange_cert_jwt.thumbprint,
    pagopa-portal-hostname      = local.pagopa-portal-hostname,
  })

}
