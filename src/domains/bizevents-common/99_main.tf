terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.53"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
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

module "__v4__" {
  # v10.46.0
  source = "git::https://github.com/pagopa/terraform-azurerm-v4?ref=588ea917b4c495e1b6af2b955a154d2de6d94a43"
}
