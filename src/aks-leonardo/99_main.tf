terraform {
  required_version = ">= 1.3.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.110.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "<= 2.47.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "<= 2.3.3"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "<= 2.27.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "<= 2.12.1"
    }
    null = {
      source  = "hashicorp/null"
      version = "<= 3.2.2"
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
