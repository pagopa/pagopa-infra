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
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

module "__v4__" {
  # 8.3.7
  source = "git::https://github.com/pagopa/terraform-azurerm-v4?ref=d72285dd7a5f032fdbe8f572f796b75d76865004"
}
