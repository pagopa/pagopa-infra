# https://pagopa.atlassian.net/wiki/spaces/DEVOPS/pages/509739888/AKS+pod+identity+v1+Please+grant+at+least+Managed+Identity+Operator+permission+before+assigning+pod+identity.

############
#  STEP-1  #
############
## CHANGE ME
AKS_NAME="pagopa-d-weu-dev-aks"
AKS_RESOURCE_GROUP="pagopa-d-weu-dev-aks-rg"

az aks show \
  --name $AKS_NAME \
  --resource-group $AKS_RESOURCE_GROUP \
  --query 'podIdentityProfile.userAssignedIdentities[].{name:name, state:provisioningState}'

# The behavior of this command has been altered by the following extension: aks-preview
# [
#   {
#     "name": "keda-pod-identity",
#     "state": "Assigned"
#   },
#   {
#     "name": "ecommerce-pod-identity",
#     "state": "Assigned"
#   },
#   {
#     "name": "ecommerce-ingress-pod-identity",
#     "state": "Failed"
#   }
# ]

############
#  STEP-2  #
############
## CHANGE ME
# NAMESPACE="ecommerce"
# POD_IDENTITY_NAME="ecommerce-ingress-pod-identity"

# az aks pod-identity delete \
#   --cluster-name $AKS_NAME \
#   --resource-group $AKS_RESOURCE_GROUP \
#   --namespace $NAMESPACE \
#   --name $POD_IDENTITY_NAME