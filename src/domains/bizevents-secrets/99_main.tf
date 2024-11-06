terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.106.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "= 2.21.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "= 3.1.1"
    }
    external = {
      source  = "hashicorp/external"
      version = "= 2.2.3"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.16.1"
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

provider "kubernetes" {
  config_path    = "~/.kube/config-${var.prefix}-${var.env_short}-${var.location_short}-${var.env}-aks"
  config_context = "${var.prefix}-${var.env_short}-${var.location_short}-${var.env}-aks"
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

data "azuread_client_config" "current" {}
