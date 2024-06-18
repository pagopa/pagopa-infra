terraform {
  required_version = ">=1.3.0"

  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "<= 1.3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "<= 2.30.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.40.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "<= 2.5.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "<= 2.11.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "<= 3.2.1"
    }
    github = {
      source  = "integrations/github"
      version = "<= 5.12.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

provider "github" {
  owner = var.github.org
}

provider "kubernetes" {
  config_path = "${var.k8s_kube_config_path_prefix}/config-${local.aks_name}"
}

provider "helm" {
  kubernetes {
    config_path = "${var.k8s_kube_config_path_prefix}/config-${local.aks_name}"
  }
}

provider "azapi" {

}


data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}
