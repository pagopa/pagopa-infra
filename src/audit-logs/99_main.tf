terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
    }
  }
  backend "azurerm" {}

}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}


data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}




module "__v4__" {
  # v8.1.3
  source = "git::https://github.com/pagopa/terraform-azurerm-v4?ref=da30369e66508e38252f34aa7209c645ba208546"
}