terraform {
  required_version = ">=1.3.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.71.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "> 2.10.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "> 2.0.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "= 2.17.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "= 2.8.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.1.1"
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

provider "kubernetes" {
  config_path = "${var.k8s_kube_config_path_prefix}/config-${local.aks_cluster_name}"
}

provider "helm" {
  kubernetes {
    config_path = "${var.k8s_kube_config_path_prefix}/config-${local.aks_cluster_name}"
  }
}
