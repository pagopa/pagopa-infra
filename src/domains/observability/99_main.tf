terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.117.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "= 2.21.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "= 3.1.1"
    }
    azapi = {
      source  = "azure/azapi"
      version = "<= 2.0.1"
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

module "__v3__" {
  # v8.83.1
  source = "git::https://github.com/pagopa/terraform-azurerm-v3?ref=087a57940a67444c3b883030c54ceb78562c64ef"
}
