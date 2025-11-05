terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.110.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "<= 2.21.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "<= 3.2.1"
    }
    azapi = {
      source  = "azure/azapi"
      version = "<= 1.13.1"
    }
  }

  backend "azurerm" {}
}

provider "azapi" {
}

provider "azurerm" {
  skip_provider_registration = true
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

module "__v3__" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3?ref=ce3200bf6673671bd6e641722e6c9d7500043fda"
}
