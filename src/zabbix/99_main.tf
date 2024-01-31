terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.85.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "<= 2.17.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "<= 2.8.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}
