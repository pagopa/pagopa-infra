terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.16"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.1"
    }
    null = {
      source  = "hashicorp/null"
      version = "<= 3.2.1"
    }
    restapi = {
      source  = "Mastercard/restapi"
      version = "2.0.1"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
}

provider "restapi" {
  uri                  = local.metabase_uri
  write_returns_object = true
  debug                = true

  headers = {
    "x-api-key"    = data.azurerm_key_vault_secret.metabase_api_key.value,
    "Content-Type" = "application/json"
  }

}


data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}


