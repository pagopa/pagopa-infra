##############
## Products ##
##############

module "apim_donations_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "donations-iuv"
  display_name = "Donations"
  description  = "Donations"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false # TO DISABLE DONA
  approval_required     = false
  subscriptions_limit   = 1

  policy_xml = file("./api_product/donations/_base_policy.xml")
}

##############
##    API   ##
##############

resource "azurerm_api_management_api_version_set" "api_donations_api" {

  name                = format("%s-api-donations-api", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "Donations"
  versioning_scheme   = "Segment"
}


module "apim_api_donations_api" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.1.13"

  name                  = format("%s-api-donations-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_donations_product.product_id]
  subscription_required = false # TO DISABLE DONA
  api_version           = "v1"
  version_set_id        = azurerm_api_management_api_version_set.api_donations_api.id
  service_url           = null // no BE


  description  = "donations"
  display_name = "donations pagoPA"
  path         = "donations/api"
  protocols    = ["https"]


  content_format = "openapi"
  content_value = templatefile("./api/donations/v1/_openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/donations/v1/_base_policy.xml")
}


resource "azurerm_api_management_api_operation_policy" "get_donations" {
  api_name            = format("%s-api-donations-api-v1", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  operation_id        = "getavailabledonations"

  # xml_content = file("./api/donations/v1/donazioni_ucraina.xml")

  xml_content = templatefile("./api/donations/v1/donazioni_ucraina.xml", {
    env_short = var.env_short
    logo_1    = file("./api/donations/v1/logos/logo1")
    logo_2    = file("./api/donations/v1/logos/logo2")
    logo_3    = file("./api/donations/v1/logos/logo3")
    logo_4    = file("./api/donations/v1/logos/logo4")
    logo_5    = file("./api/donations/v1/logos/logo5")
    logo_6    = file("./api/donations/v1/logos/logo6")
  })

}


## Storage Account
module "logos_donation_flows_sa" {
  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v2.0.28"

  name                       = replace(format("%s-logos-donation-sa", local.project), "-", "")
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  account_replication_type   = var.logos_donations_storage_account_replication_type
  access_tier                = "Hot"
  versioning_name            = "versioning"
  enable_versioning          = var.enable_logos_backup
  resource_group_name        = azurerm_resource_group.data.name
  location                   = var.location
  advanced_threat_protection = false
  allow_blob_public_access   = false

  blob_properties_delete_retention_policy_days = 30


  tags = var.tags
}

## blob container logo 7
resource "azurerm_storage_container" "donation_logo7" {
  name                  = format("%slogo7", module.logos_donation_flows_sa.name)
  storage_account_name  = module.logos_donation_flows_sa.name
  container_access_type = "private"
}
resource "azurerm_storage_blob" "donation_logo7" {
  name                   = "logo7"
  storage_account_name   = module.logos_donation_flows_sa.name
  storage_container_name = azurerm_storage_container.donation_logo7.name
  type                   = "Block"
  source                 = "./api/donations/v1/logos/logo7"
}

## blob container logo 8
resource "azurerm_storage_container" "donation_logo8" {
  name                  = format("%slogo8", module.logos_donation_flows_sa.name)
  storage_account_name  = module.logos_donation_flows_sa.name
  container_access_type = "private"
}
resource "azurerm_storage_blob" "donation_logo8" {
  name                   = "logo8"
  storage_account_name   = module.logos_donation_flows_sa.name
  storage_container_name = azurerm_storage_container.donation_logo8.name
  type                   = "Block"
  source                 = "./api/donations/v1/logos/logo8"
}

## blob container logo 9
resource "azurerm_storage_container" "donation_logo9" {
  name                  = format("%slogo9", module.logos_donation_flows_sa.name)
  storage_account_name  = module.logos_donation_flows_sa.name
  container_access_type = "private"
}
resource "azurerm_storage_blob" "donation_logo9" {
  name                   = "logo9"
  storage_account_name   = module.logos_donation_flows_sa.name
  storage_container_name = azurerm_storage_container.donation_logo9.name
  type                   = "Block"
  source                 = "./api/donations/v1/logos/logo9"
}

## blob container logo 10
resource "azurerm_storage_container" "donation_logo10" {
  name                  = format("%slogo10", module.logos_donation_flows_sa.name)
  storage_account_name  = module.logos_donation_flows_sa.name
  container_access_type = "private"
}
resource "azurerm_storage_blob" "donation_logo10" {
  name                   = "logo10"
  storage_account_name   = module.logos_donation_flows_sa.name
  storage_container_name = azurerm_storage_container.donation_logo10.name
  type                   = "Block"
  source                 = "./api/donations/v1/logos/logo10"
}


# https://medium.com/marcus-tee-anytime/secure-azure-blob-storage-with-azure-api-management-managed-identities-b0b82b53533c

# 1 - add Blob Data Contributor to apim for Fdr blob storage
resource "azurerm_role_assignment" "data_contributor_role_donations" {
  scope                = module.logos_donation_flows_sa.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = module.apim.principal_id

  depends_on = [
    module.logos_donation_flows_sa
  ]
}

# 2 - Change container Authentication method to Azure AD authentication
resource "null_resource" "change_auth_donations_blob_container_logo7" {

  triggers = {
    apim_principal_id = module.apim.principal_id
  }

  provisioner "local-exec" {
    command = <<EOT
              az storage container set-permission \
                --name ${azurerm_storage_container.donation_logo7.name} \
                --account-name ${module.logos_donation_flows_sa.name} \
                --account-key ${module.logos_donation_flows_sa.primary_access_key} \
                --auth-mode login
          EOT
  }

  depends_on = [
    azurerm_storage_container.donation_logo7
  ]
}

resource "null_resource" "change_auth_donations_blob_container_logo8" {

  triggers = {
    apim_principal_id = module.apim.principal_id
  }

  provisioner "local-exec" {
    command = <<EOT
              az storage container set-permission \
                --name ${azurerm_storage_container.donation_logo8.name} \
                --account-name ${module.logos_donation_flows_sa.name} \
                --account-key ${module.logos_donation_flows_sa.primary_access_key} \
                --auth-mode login
          EOT
  }

  depends_on = [
    azurerm_storage_container.donation_logo8
  ]
}

resource "null_resource" "change_auth_donations_blob_container_logo9" {

  triggers = {
    apim_principal_id = module.apim.principal_id
  }

  provisioner "local-exec" {
    command = <<EOT
              az storage container set-permission \
                --name ${azurerm_storage_container.donation_logo9.name} \
                --account-name ${module.logos_donation_flows_sa.name} \
                --account-key ${module.logos_donation_flows_sa.primary_access_key} \
                --auth-mode login
          EOT
  }

  depends_on = [
    azurerm_storage_container.donation_logo9
  ]
}

resource "null_resource" "change_auth_donations_blob_container_logo10" {

  triggers = {
    apim_principal_id = module.apim.principal_id
  }

  provisioner "local-exec" {
    command = <<EOT
              az storage container set-permission \
                --name ${azurerm_storage_container.donation_logo10.name} \
                --account-name ${module.logos_donation_flows_sa.name} \
                --account-key ${module.logos_donation_flows_sa.primary_access_key} \
                --auth-mode login
          EOT
  }

  depends_on = [
    azurerm_storage_container.donation_logo10
  ]
}
