terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "<= 1.3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "<= 2.21.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.116.0, < 4.0.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "<= 3.2.1"
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


module "__v3__" {
  # 8.65.0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3?ref=47ac1373640adf1653d19898e2c4237d25bcf861"
}
