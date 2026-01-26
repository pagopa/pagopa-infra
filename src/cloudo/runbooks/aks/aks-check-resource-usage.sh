#!/bin/bash

# Script to check CPU and Memory usage of pods in a namespace
# Required environment variables:
# - AKS_NAMESPACE
# Optional environment variables:
# - CPU_THRESHOLD_PERCENT (default: 80) - Informational only if metrics-server doesn't provide limits
# - MEM_THRESHOLD_PERCENT (default: 80)

NAMESPACE=${AKS_NAMESPACE:-"default"}
CPU_THRESHOLD=${CPU_THRESHOLD_PERCENT:-80}
MEM_THRESHOLD=${MEM_THRESHOLD_PERCENT:-80}

if [ "$MONITOR_CONDITION" == "Resolved" ]; then
  echo "Alert mitigated!"
  exit 0
fi

echo "Checking resource usage in namespace: $NAMESPACE"
echo "---------------------------------------------------"

# Check if metrics-server is available by running kubectl top
if ! kubectl top pods -n "$NAMESPACE" > /dev/null 2>&1; then
  echo "Error: kubectl top pods failed. Is metrics-server installed and running?"
  exit 1
fi

echo "Current pod resource usage:"
kubectl top pods -n "$NAMESPACE" --sort-by=cpu | head -n 20
echo "---------------------------------------------------"

EXIT_CODE=0

# Get pods and their usage
# Format: NAME CPU(cores) MEMORY(bytes)
USAGE_DATA=$(kubectl top pods -n "$NAMESPACE" --no-headers)

while read -r line; do
  POD_NAME=$(echo "$line" | awk '{print $1}')
  CPU_USAGE=$(echo "$line" | awk '{print $2}' | sed 's/m//')
  MEM_USAGE=$(echo "$line" | awk '{print $3}' | sed 's/Mi//')

  # Note: kubectl top doesn't show limits, so we'd need to fetch them via kubectl get pod if we want percentage of limit
  # For now, we list the pods and identify those that look particularly high or we just report the top ones.
  
  # Fetching limits for the pod to calculate percentage
  LIMITS=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.spec.containers[*].resources.limits}')
  
  if [ -n "$LIMITS" ]; then
    CPU_LIMIT=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.spec.containers[0].resources.limits.cpu}' | sed 's/m//')
    MEM_LIMIT=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.spec.containers[0].resources.limits.memory}' | sed 's/Mi//' | sed 's/Gi/ * 1024/' | bc 2>/dev/null)

    # Simple check if limit is in 'm' for CPU
    if [[ "$CPU_LIMIT" =~ ^[0-9]+$ ]]; then
        # it's already in millicores or full cores? kubectl usually returns 'm' or full number.
        # If it's a full number (e.g. 1), it means 1000m
        :
    else
        # If it's something like "1", convert to 1000
        CPU_LIMIT=$((CPU_LIMIT * 1000))
    fi

    if [ -n "$CPU_LIMIT" ] && [ "$CPU_LIMIT" -gt 0 ]; then
      CPU_PERC=$(( (CPU_USAGE * 100) / CPU_LIMIT ))
      if [ "$CPU_PERC" -gt "$CPU_THRESHOLD" ]; then
        echo "WARNING: Pod $POD_NAME is using $CPU_PERC% of CPU limit ($CPU_USAGE m / $CPU_LIMIT m)"
        EXIT_CODE=1
      fi
    fi

    if [ -n "$MEM_LIMIT" ] && [ "$MEM_LIMIT" -gt 0 ]; then
      MEM_PERC=$(( (MEM_USAGE * 100) / MEM_LIMIT ))
      if [ "$MEM_PERC" -gt "$MEM_THRESHOLD" ]; then
        echo "WARNING: Pod $POD_NAME is using $MEM_PERC% of Memory limit ($MEM_USAGE Mi / $MEM_LIMIT Mi)"
        EXIT_CODE=1
      fi
    fi
  fi

done <<< "$USAGE_DATA"

if [ "$EXIT_CODE" -eq 0 ]; then
  echo "Resource usage is within thresholds."
fi

exit $EXIT_CODE
