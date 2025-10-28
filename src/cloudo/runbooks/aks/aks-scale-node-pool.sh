#!/bin/bash

# Log in using managed identity
echo "Logging in with managed identity..."
if [[ -n "${AZURE_CLIENT_ID:-}" ]]; then
  if ! az login --identity --client-id "$AZURE_CLIENT_ID"; then
    echo "1 Failed to login with managed identity"
    exit 1
  fi
else
  if ! az login --identity; then
    echo "2 Failed to login with managed identity"
    exit 1
  fi
fi

if [[ -n "${AZURE_SUBSCRIPTION_ID:-}" ]]; then
  echo "Setting subscription..."
  if ! az account set --subscription "$AZURE_SUBSCRIPTION_ID"; then
    echo "Failed to set subscription"
    exit 1
  fi
fi

# Function to get current node count
get_current_node_count() {
    local resource_group=$1
    local cluster_name=$2
    local nodepool_name=$3
    local query=$4

    current_count=$(az aks nodepool show \
        --resource-group "$resource_group" \
        --cluster-name "$cluster_name" \
        --name "$nodepool_name" \
        --query "$query" \
        --output tsv)

    echo "$current_count"
}

# Function to scale node pool
scale_node_pool() {
    local resource_group=$1
    local cluster_name=$2
    local nodepool_name=$3

    # Get current node count
    current_count=$(get_current_node_count "$RESOURCE_GROUP" "$CLUSTER_NAME" "$NODEPOOL_NAME" "count")
    max_count=$(get_current_node_count "$RESOURCE_GROUP" "$CLUSTER_NAME" "$NODEPOOL_NAME" "maxCount")
    min_count=$(get_current_node_count "$RESOURCE_GROUP" "$CLUSTER_NAME" "$NODEPOOL_NAME" "minCount")

    # Scale by 1
    new_count=$((current_count + 1))

    # Check if node pool is in autoscale mode
    local mode=$(az aks nodepool show \
        --resource-group "$resource_group" \
        --cluster-name "$cluster_name" \
        --name "$nodepool_name" \
        --query 'enableAutoScaling' \
        --output tsv)

    echo "Current nodepool mode -> $mode"

    if [[ "$mode" == "true" ]]; then
        # Scale max count instead by 1
        new_count=$((max_count + 1))

        echo "Set min: $min_count & max: $new_count"

        az aks nodepool update \
            --resource-group "$resource_group" \
            --cluster-name "$cluster_name" \
            --name "$nodepool_name" \
            --max-count "$new_count" \
            --min-count "$min_count"
    else
        az aks nodepool scale \
            --resource-group "$resource_group" \
            --cluster-name "$cluster_name" \
            --name "$nodepool_name" \
            --node-count "$new_count"
    fi
}

# Main script execution
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <nodepool-name>"
    exit 1
fi

RESOURCE_GROUP=$RESOURCE_RG
CLUSTER_NAME=$RESOURCE_NAME
NODEPOOL_NAME=$1

# Scale the node pool
echo "Scaling node pool from $current_count to $new_count nodes..."
scale_node_pool "$RESOURCE_GROUP" "$CLUSTER_NAME" "$NODEPOOL_NAME"
