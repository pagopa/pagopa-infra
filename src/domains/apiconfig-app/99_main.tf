terraform {
  required_version = ">=1.3.0"

  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "<= 1.3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.53"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.116"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "<= 2.12.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.36.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
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

module "__v3__" {
  # v8.83.1
  # source = "git::https://github.com/pagopa/terraform-azurerm-v3?ref=087a57940a67444c3b883030c54ceb78562c64ef"

  # v8.99.0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3?ref=f97230b8a5838fe3c616b5aa01bef8caeff8bc6b"
}
