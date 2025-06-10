data "azurerm_resource_group" "identity_rg" {
  name = "${local.product}-identity-rg"
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = "${local.product}-${var.location_short}-${var.instance}-aks"
  resource_group_name = "${local.product}-${var.location_short}-${var.instance}-aks-rg"
}

# repos must be lower than 20 items
locals {
  repos_01 = [
    "pagopa-api-config-cache",
    "pagopa-api-config",
    "pagopa-api-config-selfcare-integration",
    "pagopa-api-config-testing-support"
  ]

  federations_01 = [
    for repo in local.repos_01 : {
      repository = repo
      subject    = var.env
    }
  ]

  environment_cd_roles = {
    subscription = [
      "Contributor"
    ]
    resource_groups = {
      "${local.product}-${var.domain}-sec-rg" = [
        "Key Vault Reader"
      ],
      "${local.product}-${var.location_short}-${var.env}-aks-rg" = [
        "Contributor"
      ]
    }
  }
}

# create a module for each 20 repos
module "identity_cd_01" {
  source = "./.terraform/modules/__v3__/github_federated_identity"
  # pagopa-<ENV><DOMAIN>-<COUNTER>-github-<PERMS>-identity
  prefix    = var.prefix
  env_short = var.env_short
  domain    = "${var.domain}-01"

  identity_role = "cd"

  github_federations = local.federations_01

  cd_rbac_roles = {
    subscription_roles = local.environment_cd_roles.subscription
    resource_groups    = local.environment_cd_roles.resource_groups
  }

  tags = module.tag_config.tags

  depends_on = [
    data.azurerm_resource_group.identity_rg
  ]
}

resource "null_resource" "github_runner_app_permissions_to_namespace_cd_01" {
  triggers = {
    aks_id               = data.azurerm_kubernetes_cluster.aks.id
    service_principal_id = module.identity_cd_01.identity_client_id
    namespace            = var.domain
    version              = "v2"
  }

  provisioner "local-exec" {
    command = <<EOT
      az role assignment create --role "Azure Kubernetes Service RBAC Admin" \
      --assignee ${self.triggers.service_principal_id} \
      --scope ${self.triggers.aks_id}/namespaces/${self.triggers.namespace}

      az role assignment list --role "Azure Kubernetes Service RBAC Admin"  \
      --scope ${self.triggers.aks_id}/namespaces/${self.triggers.namespace}
    EOT
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
      az role assignment delete --role "Azure Kubernetes Service RBAC Admin" \
      --assignee ${self.triggers.service_principal_id} \
      --scope ${self.triggers.aks_id}/namespaces/${self.triggers.namespace}
    EOT
  }

  depends_on = [
    module.identity_cd_01
  ]
}

module "workload_identity_init" {
  source                                = "./.terraform/modules/__v3__/kubernetes_workload_identity_init"
  workload_identity_name_prefix         = var.domain
  workload_identity_resource_group_name = data.azurerm_kubernetes_cluster.aks.resource_group_name
  workload_identity_location            = var.location
}
