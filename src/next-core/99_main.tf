terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.85.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "<= 2.47.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "= 3.1.1"
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
      source = "hashicorp/local"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

# data "terraform_remote_state" "core" {
#   backend = "azurerm"

#   config = {
#     resource_group_name  = var.terraform_remote_state_core.resource_group_name
#     storage_account_name = var.terraform_remote_state_core.storage_account_name
#     container_name       = var.terraform_remote_state_core.container_name
#     key                  = var.terraform_remote_state_core.key
#   }
# }
