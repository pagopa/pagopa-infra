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
    "pagopa-fdr-nodo-dei-pagamenti"
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

  environment_ci_roles = {
    subscription = [
      "Contributor",
    ]
    resource_groups = {
      "${local.product}-${var.domain}-sec-rg" = [
        "Key Vault Reader",
      ],
      "${local.product}-${var.location_short}-${var.env}-aks-rg" = [
        "Contributor"
      ],
      "${local.product}-${var.location_short}-shared-tst-dt-rg" = [
        "Storage Blob Data Contributor",
      ],
    }
  }
}

# create a module for each 20 repos
module "identity_cd_01" {

  source = "github.com/pagopa/terraform-azurerm-v3//github_federated_identity?ref=v7.45.0"
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

  tags = var.tags

  depends_on = [
    data.azurerm_resource_group.identity_rg
  ]
}

# create a module for each 20 repos
module "identity_ci_01" {
  count = var.env_short == "d" ? 1 : 0

  source = "github.com/pagopa/terraform-azurerm-v3//github_federated_identity?ref=v7.45.0"
  # pagopa-<ENV><DOMAIN>-<COUNTER>-github-<PERMS>-identity
  prefix    = var.prefix
  env_short = var.env_short
  domain    = "${var.domain}-01"

  identity_role = "ci"

  github_federations = local.federations_01

  ci_rbac_roles = {
    subscription_roles = local.environment_ci_roles.subscription
    resource_groups    = local.environment_ci_roles.resource_groups
  }

  tags = var.tags

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

resource "null_resource" "github_runner_app_permissions_to_namespace_ci_01" {
  count = var.env_short == "d" ? 1 : 0

  triggers = {
    aks_id               = data.azurerm_kubernetes_cluster.aks.id
    service_principal_id = module.identity_ci_01[0].identity_client_id
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
    module.identity_ci_01
  ]
}

