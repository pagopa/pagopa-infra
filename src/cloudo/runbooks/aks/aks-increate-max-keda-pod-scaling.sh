#!/bin/bash

# This script patches a KEDA ScaledObject to increment maxReplicaCount by 1

NAMESPACE=$AKS_NAMESPACE
HPA=$AKS_HPA
SCALED_OBJECT_NAME=$(kubectl get hpa $HPA -n $NAMESPACE -o=jsonpath='{.metadata.labels.scaledobject\.keda\.sh/name}')
if [ -z "$SCALED_OBJECT_NAME" ]; then
    echo "Error: Could not find ScaledObject name in HPA annotations"
    exit 1
fi

# Get current maxReplicaCount
CURRENT_MAX=$(kubectl get scaledobject $SCALED_OBJECT_NAME -n $NAMESPACE -o jsonpath='{.spec.maxReplicaCount}')

if [ -z "$CURRENT_MAX" ]; then
    echo "Error: Could not get current maxReplicaCount"
    exit 1
fi

# Increment maxReplicaCount by 1
NEW_MAX=$((CURRENT_MAX + 1))

# Patch ScaledObject with new maxReplicaCount
kubectl patch scaledobject $SCALED_OBJECT_NAME -n $NAMESPACE --type='json' -p="[{'op': 'replace', 'path': '/spec/maxReplicaCount', 'value': $NEW_MAX}]"

echo "Successfully updated maxReplicaCount from $CURRENT_MAX to $NEW_MAX"
