terraform {
  required_version = ">=1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.116.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.30.0"
    }
    github = {
      source  = "integrations/github"
      version = "5.12.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "<= 2.30.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "<= 2.12.1"
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
  # v8.62.1
  # source = "git::https://github.com/pagopa/terraform-azurerm-v3?ref=f3485105e35ce8c801209dcbb4ef72f3d944f0e5"

  # v8.99.0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3?ref=f97230b8a5838fe3c616b5aa01bef8caeff8bc6b"
}

