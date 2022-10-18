# dataexp-<d|u|p>-grafana 
# con secrect dataex-4-grafana


# Generate random password
# resource "random_string" "service_principal_password_txt" {
#   length           = 20
#   special          = true
#   override_special = "!@#$&*()-_=+[]{}<>:?"
# }

# Create an azurerm application

resource "azuread_application" "application_aad_client_grafana" {
  display_name     = format("%s-dataexp-grafana", local.project)
  identifier_uris  = []
  sign_in_audience = "AzureADMultipleOrgs"

  app_role {
    allowed_member_types = ["User", "Application"]
    description          = "Admins can manage roles and perform all task actions"
    display_name         = "Admin"
    enabled              = true
    id                   = "1b19509b-32b1-4e9f-b71d-4992aa991967"
    value                = "admin"
  }

  app_role {
    allowed_member_types = ["User"]
    description          = "ReadOnly roles have limited query access"
    display_name         = "ReadOnly"
    enabled              = true
    id                   = "497406e4-012a-4267-bf18-45a1cb148a01"
    value                = "User"
  }

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

    resource_access {
      id   = "df021288-bdef-4463-88db-98f22de89214" # User.Read.All
      type = "Role"
    }

  }

}


# Create a azurerm service principal
resource "azuread_service_principal" "service_principal_aad_client" {
  application_id = azuread_application.application_aad_client_grafana.application_id
}


resource "time_rotating" "time_rotating" {
  rotation_days = 7
}

# Set client secret

resource "azuread_service_principal_password" "service_principal_password_aad_client" {
  service_principal_id = azuread_service_principal.service_principal_aad_client.id
  #   value                = "${random_string.service_principal_password_txt.result}"

  #   lifecycle {
  #     ignore_changes = ["value"]
  #   }

  rotate_when_changed = {
    rotation = time_rotating.time_rotating.id
  }
}

output "sp_password" {
  value     = azuread_service_principal_password.service_principal_password_aad_client.value
  sensitive = true
}