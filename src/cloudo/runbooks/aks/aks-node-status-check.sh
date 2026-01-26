#!/bin/bash

# Script to check the status of AKS nodes and provide details on those with issues
# Required environment variables:
# - None (uses current context)

echo "Checking status of all nodes in the cluster..."
echo "---------------------------------------------------"

# Get nodes and their status
NODES_STATUS=$(kubectl get nodes -o custom-columns=NAME:.metadata.name,STATUS:.status.conditions[?(@.type==\"Ready\")].status,REASON:.status.conditions[?(@.type==\"Ready\")].reason)

echo "$NODES_STATUS"
echo "---------------------------------------------------"

# Identify NotReady nodes
NOT_READY_NODES=$(kubectl get nodes | grep -v "STATUS" | grep "NotReady" | awk '{print $1}')

EXIT_CODE=0

if [ -n "$NOT_READY_NODES" ]; then
  echo "Found NotReady nodes:"
  EXIT_CODE=1
  for NODE in $NOT_READY_NODES; do
    echo "---------------------------------------------------"
    echo "Analyzing NotReady NODE: $NODE"
    kubectl describe node "$NODE" | grep -A 10 "Conditions:"
    echo "Recent events for node $NODE:"
    kubectl get events --field-selector involvedObject.name="$NODE" --sort-by='.lastTimestamp' | tail -n 5
  done
else
  echo "All nodes are in Ready state."
fi

echo "---------------------------------------------------"
echo "Checking for resource pressure on nodes..."
# Check for DiskPressure, MemoryPressure, PIDPressure
PRESSURE_NODES=$(kubectl get nodes -o json | jq -r '.items[] | select(.status.conditions[] | select(.type != "Ready" and .status == "True")) | .metadata.name' | sort -u)

if [ -n "$PRESSURE_NODES" ]; then
  echo "Nodes with resource pressure detected:"
  EXIT_CODE=1
  for NODE in $PRESSURE_NODES; do
     echo "Node: $NODE"
     kubectl get node "$NODE" -o custom-columns=NAME:.metadata.name,DISK_PRESSURE:.status.conditions[?(@.type==\"DiskPressure\")].status,MEM_PRESSURE:.status.conditions[?(@.type==\"MemoryPressure\")].status,PID_PRESSURE:.status.conditions[?(@.type==\"PIDPressure\")].status
  done
else
  echo "No resource pressure detected on any node."
fi

exit $EXIT_CODE
