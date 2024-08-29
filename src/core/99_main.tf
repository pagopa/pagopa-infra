terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "<= 1.3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "<= 2.6.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 2.99.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "<= 2.3.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "<= 3.2.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "<= 3.4.3"
    }
    time = {
      source  = "hashicorp/time"
      version = "<= 0.11.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "<= 4.0.5"
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

provider "azapi" {

}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}
