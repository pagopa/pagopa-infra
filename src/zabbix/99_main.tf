terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.71.0"
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

provider "kubernetes" {
  config_path = "${var.k8s_kube_config_path_prefix}/config-${local.aks_name}"
}

provider "helm" {
  kubernetes {
    config_path = "${var.k8s_kube_config_path_prefix}/config-${local.aks_name}"
  }
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}
