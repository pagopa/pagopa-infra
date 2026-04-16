#!/bin/bash

# Script to fetch logs for a specific pod or all pods in a deployment
# Required environment variables:
# - AKS_NAMESPACE
# Optional environment variables:
# - AKS_POD_NAME
# - AKS_DEPLOYMENT
# - LOG_LINES (default: 50)

NAMESPACE=${AKS_NAMESPACE:-"default"}
LINES=${LOG_LINES:-50}

if [ -n "$AKS_POD_NAME" ]; then
  echo "Fetching logs for pod: $AKS_POD_NAME in namespace: $NAMESPACE"
  kubectl logs "$AKS_POD_NAME" -n "$NAMESPACE" --tail="$LINES" || exit 1
elif [ -n "$AKS_DEPLOYMENT" ]; then
  echo "Fetching logs for deployment: $AKS_DEPLOYMENT in namespace: $NAMESPACE"
  kubectl logs "deployment/$AKS_DEPLOYMENT" -n "$NAMESPACE" --tail="$LINES" --all-containers=true || exit 1
else
  echo "Error: Neither AKS_POD_NAME nor AKS_DEPLOYMENT provided."
  exit 1
fi
