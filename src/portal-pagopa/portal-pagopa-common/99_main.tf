terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.16"
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
  # v10.13.0
  source = "git::https://github.com/pagopa/terraform-azurerm-v4?ref=ac1ff495df50f4c7a1f28ab6e09acf3322a4ebc9"
}

