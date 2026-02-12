terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "<= 1.13.1"
    }
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
      version = "<= 3.2.2"
    }
  }

  backend "azurerm" {}
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
  # 8.8.0
  source = "git::https://github.com/pagopa/terraform-azurerm-v4?ref=81073ffef1efb331aec9aaecdfe6929e3a3ffe91"
}
