terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "<= 1.13.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "<= 3.0.2"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4"
    }
    local = {
      source  = "hashicorp/local"
      version = "<= 2.5.1"
    }
    time = {
      source  = "hashicorp/time"
      version = "<= 0.11.1"
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
  # v7.25.0
  source = "git::https://github.com/pagopa/terraform-azurerm-v4?ref=1ed70549ce796e30c27d89bc6aabcb5f6eaaf925"
}
