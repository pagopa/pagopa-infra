data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg_sec" {
  name     = format("%s-sec-rg", local.project)
  location = var.location
  tags     = var.tags
}

# User managed identity
resource "azurerm_user_assigned_identity" "main" {
  resource_group_name = azurerm_resource_group.rg_sec.name
  location            = azurerm_resource_group.rg_sec.location
  name                = format("%s-user-identity", local.project)

  tags = var.tags
}


# Create Key Vault
resource "azurerm_key_vault" "key_vault" {
  name                        = format("%s-key-vault", local.project)
  location                    = azurerm_resource_group.rg_sec.location
  resource_group_name         = azurerm_resource_group.rg_sec.name
  enabled_for_disk_encryption = false
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  tags                        = var.tags
  sku_name                    = var.key_vault_sku

  network_acls {
    bypass         = "AzureServices"
    default_action = "Allow"
  }

}

#
# POLICIES
#

resource "azurerm_key_vault_access_policy" "terraform_cloud_policy" {
  key_vault_id = azurerm_key_vault.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = ["Get", "List", "Update", "Create", "Import", "Delete",
    "Recover", "Backup", "Restore"
  ]

  secret_permissions = ["Get", "List", "Set", "Delete", "Recover", "Backup",
    "Restore"
  ]

  certificate_permissions = ["Get", "List", "Update", "Create", "Import",
    "Delete", "Recover", "Backup", "Restore", "ManageContacts", "ManageIssuers",
    "GetIssuers", "ListIssuers", "SetIssuers", "DeleteIssuers", "Purge"
  ]

  storage_permissions = []

}

# app service management policy 
# resource "azurerm_key_vault_access_policy" "app_service_policy" {
#   key_vault_id = azurerm_key_vault.key_vault.id
#   tenant_id    = data.azurerm_client_config.current.tenant_id
#   object_id    = azurerm_user_assigned_identity.main.principal_id

#   key_permissions         = ["Get", "List"]
#   secret_permissions      = ["Get", "List"]
#   certificate_permissions = ["Get", "List"]
#   storage_permissions     = []
# }

# Owner policy - associated to user of key_vault
resource "azurerm_key_vault_access_policy" "my_policy" {
  key_vault_id = azurerm_key_vault.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.key_vault_owner_id
  certificate_permissions = ["Get", "List", "Update", "Create", "Import",
    "Delete", "Recover", "Backup", "Restore", "ManageContacts", "ManageIssuers",
  "GetIssuers", "ListIssuers", "SetIssuers", "DeleteIssuers", "Purge"]
  key_permissions = ["Get", "List", "Update", "Create", "Import", "Delete",
    "Recover", "Backup", "Restore", "Decrypt", "Encrypt", "UnwrapKey", "WrapKey",
  "Verify", "Sign", "Purge"]
  storage_permissions = []
}


#
# CERTIFICATES
#
resource "azurerm_key_vault_certificate" "app_service_cert" {
  name         = format("%s-cert-client-auth", local.project)
  key_vault_id = azurerm_key_vault.key_vault.id

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
      key_usage = [
        "cRLSign",
        "dataEncipherment",
        "digitalSignature",
        "keyAgreement",
        "keyCertSign",
        "keyEncipherment",
      ]

      subject            = format("CN=%s", module.mockpa_service.fqdn)
      validity_in_months = 12

      subject_alternative_names {
        dns_names = [module.mockpa_service.fqdn,
        ]
      }
    }
  }
}

data "azurerm_key_vault_certificate_data" "app_kv_cert_data" {
  # dovrebbe essere letto da una variabile ( )
  # name         = azurerm_key_vault_certificate.app_service_cert.name
  name         = var.cert_name
  key_vault_id = azurerm_key_vault.key_vault.id
}

# Data to access certificate created from Let's Encrypt
# data "azurerm_key_vault_secret" "app_app_cert" {
#   depends_on   = [azurerm_key_vault_access_policy.app_gateway_policy]
#   count        = var.app_service_certificate_name != null ? 1 : 0
#   name         = var.app_service_certificate_name
#   key_vault_id = azurerm_key_vault.key_vault.id
# }
