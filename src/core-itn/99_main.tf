terraform {
  required_version = ">= 1.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.103.1"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "<= 2.47.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "<= 3.2.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "<= 2.25.2"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "<= 2.12.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "<= 2.40.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "<= 3.4.3"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "<= 4.0.4"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}


module "__v3__" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git?ref=v8.13.0"
}
