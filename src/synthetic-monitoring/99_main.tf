terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "<= 1.11.0"
    }
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
      version = "<= 3.2.1"
    }
    grafana = {
      source  = "grafana/grafana"
      version = "~> 3"
    }
  }

  backend "azurerm" {}
}

provider "grafana" {
  alias = "cloudinternal"

  url  = data.azurerm_dashboard_grafana.managed_grafana.endpoint
  auth = data.azurerm_key_vault_secret.grafana_key.value
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

module "__v4__" {
  # v8.8.4
  source = "git::https://github.com/pagopa/terraform-azurerm-v4?ref=89e6891c9259faa71232e82c9895378e12209135"
}
