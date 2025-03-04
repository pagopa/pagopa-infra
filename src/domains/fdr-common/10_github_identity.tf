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
    "pagopa-fdr-nodo-dei-pagamenti", # FdR-1
    "pagopa-fdr",                    # FdR-3
    "pagopa-fdr-2-event-hub"
  ]

  federations_01 = [
    for repo in local.repos_01 : {
      repository = repo
      subject    = var.env
    }
  ]

  federations_01_oidc = [
    for repo in local.repos_01 : {
      repository = repo
      subject    = "oidc"
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
  source = "github.com/pagopa/terraform-azurerm-v3//github_federated_identity"
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
  count  = var.env_short == "p" ? 0 : 1
  source = "github.com/pagopa/terraform-azurerm-v3//github_federated_identity"
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

# create a module for each 20 repos
module "identity_oidc_01" {
  source    = "github.com/pagopa/terraform-azurerm-v3//github_federated_identity?ref=v8.36.1"
  prefix    = var.prefix
  env_short = var.env_short
  domain    = "${var.domain}-01-oidc"

  identity_role = "cd"

  github_federations = local.federations_01_oidc

  cd_rbac_roles = {
    subscription_roles = local.environment_cd_roles.subscription
    resource_groups    = local.environment_cd_roles.resource_groups
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
  count = var.env_short == "p" ? 0 : 1
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

# WL-IDENTITY
# https://pagopa.atlassian.net/wiki/spaces/DEVOPS/pages/1227751458/Migrazione+pod+Identity+vs+workload+Identity#Init-workload-identity
module "workload_identity" {
  source = "./.terraform/modules/__v3__/kubernetes_workload_identity_init"

  workload_identity_name_prefix         = var.domain
  workload_identity_resource_group_name = data.azurerm_kubernetes_cluster.aks.resource_group_name
  workload_identity_location            = var.location
}
