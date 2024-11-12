terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.114.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "<= 2.21.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "<= 3.2.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "<= 2.2.3"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "<= 2.31.0"
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

provider "kubernetes" {
  config_path = "${var.k8s_kube_config_path_prefix}/config-${local.aks_name}"
}
