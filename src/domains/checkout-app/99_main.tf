terraform {
  required_version = ">= 1.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "> 4.0.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "<= 3.0.2"
    }
    null = {
      source  = "hashicorp/null"
      version = "<= 3.3.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "= 2.30.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "<= 2.12.1"
    }
    azapi = {
      source  = "azure/azapi"
      version = "<= 1.3.0"
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
  config_path = "${var.k8s_kube_config_path_prefix}/config-${local.aks_name}"
}

provider "helm" {
  kubernetes {
    config_path = "${var.k8s_kube_config_path_prefix}/config-${local.aks_name}"
  }
}

module "__v3__" {
  # v8.59.0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3?ref=3fc1dafaf4354e24ca8673005ec0caf4106343a3"
}

module "__v4__" {
  # v7.25.0
  source = "git::https://github.com/pagopa/terraform-azurerm-v4?ref=c75765102e77026cb603ea4c33984d2d688bd56b"
}

