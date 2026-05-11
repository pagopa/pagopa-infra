#!/bin/bash

# Script to get recent events from a namespace or the whole cluster
# Optional environment variables:
# - AKS_NAMESPACE (default: all namespaces if not set)
# - EVENT_TYPE (Normal/Warning, default: all)

NAMESPACE=$AKS_NAMESPACE
TYPE=$EVENT_TYPE

ARGS=()
if [ -n "$NAMESPACE" ]; then
  ARGS+=("-n" "$NAMESPACE")
  echo "Fetching events for namespace: $NAMESPACE"
else
  ARGS+=("--all-namespaces")
  echo "Fetching events for all namespaces"
fi

if [ -n "$TYPE" ]; then
  ARGS+=("--field-selector" "type=$TYPE")
  echo "Filtering by event type: $TYPE"
fi

echo "---------------------------------------------------"
kubectl get events "${ARGS[@]}" --sort-by='.lastTimestamp' | tail -n 20 || exit 1
echo "---------------------------------------------------"
