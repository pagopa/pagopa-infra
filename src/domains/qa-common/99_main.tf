terraform {
  required_version = ">= 1.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.16"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.1.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "<= 3.2.3"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.35"
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
  host                   = data.azurerm_kubernetes_cluster.aks.kube_config[0].host
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "kubelogin"
    args = [
      "get-token",
      "--environment", "AzurePublicCloud",
      "--server-id", "6dae42f8-4368-4678-94ff-3960e28e3630",
      "--client-id", "80faf920-1908-4b52-b5ef-a8e7bedfc67a",
      "--tenant-id", data.azurerm_client_config.current.tenant_id,
      "--login", "azurecli"
    ]
  }
}

module "__v4__" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v4?ref=967a41a376e80daf7e4c2eb412fb4ae82d61ad85"
}