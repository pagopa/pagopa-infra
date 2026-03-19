#!/bin/bash

# Script to restart pods matching a specific label selector
# Required environment variables:
# - AKS_NAMESPACE
# - AKS_LABEL_SELECTOR (e.g., "app=my-app")

NAMESPACE=${AKS_NAMESPACE:-"default"}
LABEL_SELECTOR=$AKS_LABEL_SELECTOR

if [ -z "$LABEL_SELECTOR" ]; then
  echo "Error: AKS_LABEL_SELECTOR is required."
  exit 1
fi

echo "Restarting pods in namespace $NAMESPACE with label selector $LABEL_SELECTOR..."

# We use delete pod because it's more generic than rollout restart if we are targeting specific pods via labels 
# and not necessarily a whole deployment (though usually it's the same).
kubectl delete pods -n "$NAMESPACE" -l "$LABEL_SELECTOR" --wait=false || exit 1

echo "Delete command issued. The Controller will recreate the pods."
