resource "azurerm_resource_group" "sec_rg" {
  name     = format("%s-sec-rg", local.project)
  location = var.location

  tags = var.tags
}

# Create Key Vault
module "key_vault" {
  source              = "git::https://github.com/pagopa/azurerm.git//key_vault?ref=v1.0.7"
  name                = format("%s-kv", local.project)
  location            = azurerm_resource_group.sec_rg.location
  resource_group_name = azurerm_resource_group.sec_rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  // terraform_cloud_object_id = data.azurerm_client_config.current.client_id

  tags = var.tags
}

#
# POLICIES
#

## api management policy ## 
resource "azurerm_key_vault_access_policy" "mockec_policy" {
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.mock_ec.principal_id

  key_permissions         = []
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "ad_group_policy" {
  count        = var.ad_key_vault_group_object_id != null ? 1 : 0
  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = var.ad_key_vault_group_object_id

  key_permissions     = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions  = ["Get", "List", "Set", "Delete", ]
  storage_permissions = []
  certificate_permissions = [
    "Get", "List", "Update", "Create", "Import",
    "Delete", "Restore", "Purge", "Recover"
  ]
}

# Owner policy
# resource "azurerm_key_vault_access_policy" "my_policy" {
#   key_vault_id = azurerm_key_vault.key_vault.id

#   tenant_id               = data.azurerm_client_config.current.tenant_id
#   object_id               = var.key_vault_owner_id
#   certificate_permissions = [ "Get", "List", "Update", "Create", "Import",
#     "Delete", "Recover", "Backup", "Restore", "ManageContacts", "ManageIssuers",
#     "GetIssuers", "ListIssuers", "SetIssuers", "DeleteIssuers", "Purge" ]
#   key_permissions         = [ "Get", "List", "Update", "Create", "Import", "Delete",
#     "Recover", "Backup", "Restore", "Decrypt", "Encrypt", "UnwrapKey", "WrapKey",
#     "Verify", "Sign", "Purge" ]
#   storage_permissions     = []
# }


# User managed identity
resource "azurerm_user_assigned_identity" "app_service_mock_ec" {
  resource_group_name = azurerm_resource_group.sec_rg.name
  location            = azurerm_resource_group.sec_rg.location
  name                = format("%s-mock_ec-identity", local.project)

  tags = var.tags
}

data "azurerm_key_vault_secret" "mockec_cert" {
  depends_on   = [azurerm_key_vault_access_policy.ad_group_policy]
  count        = var.mockec_certificate_name != null ? 1 : 0
  name         = var.mockec_certificate_name
  key_vault_id = module.key_vault.id
}

# resource "azurerm_key_vault_certificate" "apim_proxy_endpoint_cert" {
#   depends_on = [
#     azurerm_key_vault_access_policy.api_management_policy
#   ]

#   name         = local.apim_cert_name_proxy_endpoint
#   key_vault_id = module.key_vault.id

#   certificate_policy {
#     issuer_parameters {
#       name = "Self"
#     }

#     key_properties {
#       exportable = true
#       key_size   = 2048
#       key_type   = "RSA"
#       reuse_key  = true
#     }

#     lifetime_action {
#       action {
#         action_type = "AutoRenew"
#       }

#       trigger {
#         days_before_expiry = 30
#       }
#     }

#     secret_properties {
#       content_type = "application/x-pkcs12"
#     }

#     x509_certificate_properties {
#       key_usage = [
#         "cRLSign",
#         "dataEncipherment",
#         "digitalSignature",
#         "keyAgreement",
#         "keyCertSign",
#         "keyEncipherment",
#       ]

#       subject            = format("CN=%s", trim(azurerm_private_dns_a_record.private_dns_a_record_api.fqdn, "."))
#       validity_in_months = 12

#       subject_alternative_names {
#         dns_names = [
#           trim(azurerm_private_dns_a_record.private_dns_a_record_api.fqdn, "."),
#         ]
#       }
#     }
#   }
# }

data "azurerm_key_vault_secret" "nodo_client_certificate_thumbprint" {
  name         = "nodo-client-certificate-thumbprint"
  key_vault_id = module.key_vault.id
}
