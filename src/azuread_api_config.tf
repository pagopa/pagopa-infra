resource "random_uuid" "oauth2_permission_scope_id" {}

# https://docs.microsoft.com/en-us/azure/api-management/api-management-howto-protect-backend-with-aad#1-register-an-application-in-azure-ad-to-represent-the-api
resource "azuread_application" "apiconfig-be" {
  display_name     = format("%s-apiconfig-be", local.project)
  sign_in_audience = "AzureADMyOrg"
  identifier_uris  = [format("api://%s-apiconfig-be", local.project)]

  api {
    mapped_claims_enabled          = true
    requested_access_token_version = 2

    oauth2_permission_scope {
      admin_consent_description  = "Allow the application to access ApiConfig APIs"
      admin_consent_display_name = "Access ApiConfig BE"
      enabled                    = true
      id                         = random_uuid.oauth2_permission_scope_id.result
      type                       = "User"
      value                      = "access-apiconfig-be"
    }
  }
}

# https://docs.microsoft.com/en-us/azure/api-management/api-management-howto-protect-backend-with-aad#2-register-another-application-in-azure-ad-to-represent-a-client-application
resource "azuread_application" "apiconfig-fe" {
  display_name     = format("%s-apiconfig-fe", local.project)
  sign_in_audience = "AzureADMultipleOrgs"

  single_page_application {
    redirect_uris = [format("https://%s/", module.api_config_fe_cdn[0].hostname), "http://localhost:3000/"]
  }

  # https://docs.microsoft.com/en-us/azure/api-management/api-management-howto-protect-backend-with-aad#3-grant-permissions-in-azure-ad
  required_resource_access {
    resource_app_id = azuread_application.apiconfig-be.id

    resource_access {
      id   = tolist(azuread_application.apiconfig-be.api[0].oauth2_permission_scope)[0].id
      type = "Scope"
    }

  }
}

resource "time_rotating" "apiconfig-fe-secret-expiration" {
  rotation_months = 6
}

resource "azuread_application_password" "apiconfig-fe-secret" {
  application_object_id = azuread_application.apiconfig-fe.object_id
  rotate_when_changed = {
    rotation = time_rotating.apiconfig-fe-secret-expiration.id
  }
}

output "apiconfig-fe-secret" {
  value     = azuread_application_password.apiconfig-fe-secret.value
  sensitive = true
}
