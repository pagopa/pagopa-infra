resource "kubernetes_namespace" "opencost" {
  metadata {
    name = "opencost"
  }
}

resource "azurerm_role_definition" "opencostrole" {
  name        = "${local.project}-${var.env_short}-${var.location_short}-OpenCostRole-${module.aks.name}"
  scope       = data.azurerm_subscription.current.id
  description = "This is a Rate Card query role for ${module.aks.name} OpenCostRole"

  permissions {
    actions = [
      "Microsoft.Compute/virtualMachines/vmSizes/read",
      "Microsoft.Resources/subscriptions/locations/read",
      "Microsoft.Resources/providers/read",
      "Microsoft.ContainerService/containerServices/read",
      "Microsoft.Commerce/RateCard/read"
    ]
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_subscription.current.id,
  ]
}

resource "azuread_service_principal" "opencostrole" {
  client_id    = azuread_application.opencostrole.client_id
  use_existing = true
}

resource "azuread_application" "opencostrole" {
  display_name = "${local.project}-${var.env_short}-${var.location_short}-OpenCostAccess-${module.aks.name}"
}

resource "azurerm_role_assignment" "opencostrole" {
  principal_id         = azuread_service_principal.opencostrole.id
  role_definition_name = azurerm_role_definition.opencostrole.name
  scope                = data.azurerm_subscription.current.id
}

resource "azuread_service_principal_password" "opencostrole" {
  service_principal_id = azuread_service_principal.opencostrole.id
  end_date_relative    = "240h"
}

resource "kubernetes_secret" "azure_service_key" {
  metadata {
    name      = "azure-service-key"
    namespace = "opencost"
  }

  data = {
    "service-key.json" = base64encode(jsonencode({
      clientId       = azuread_application.opencostrole.application_id
      clientSecret   = azuread_service_principal_password.opencostrole.value
      tenantId       = data.azurerm_subscription.current.tenant_id
      subscriptionId = data.azurerm_subscription.current.id
    }))
  }
}


resource "helm_release" "opencost" {
  name       = "opencost"
  namespace  = kubernetes_namespace.opencost.metadata[0].name
  repository = "https://opencost.github.io/opencost-helm-chart"
  chart      = "opencost"
  version    = "1.9.8"

  values = [
    <<EOF
{
  "opencost": {
    "prometheus": {
      "internal": {
        "namespace": "elastic-system",
        "serviceName": "prometheus-kube-prometheus-prometheus"
      }
      "serviceDiscovery": {
        "enabled": true
      }
    },
    "exporter": {
      "extraVolumeMounts": [
        {
          "mountPath": "/var/secrets",
          "name": "service-key-secret"
        }
      ]
    }
  },
  "extraVolumes": [
    {
      "name": "service-key-secret",
      "secret": {
        "secretName": "azure-service-key"
      }
    }
  ]
}
EOF
  ]

}
