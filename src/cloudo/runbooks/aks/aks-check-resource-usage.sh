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
METRICS_AVAILABLE=true
if ! kubectl top pods -n "$NAMESPACE" > /dev/null 2>&1; then
  echo "Warning: kubectl top pods failed. metrics-server might not be installed."
  echo "Falling back to showing Pod resource requests and limits only."
  METRICS_AVAILABLE=false
fi

if [ "$METRICS_AVAILABLE" = true ]; then
  echo "Current pod resource usage:"
  kubectl top pods -n "$NAMESPACE" --sort-by=cpu | head -n 20
  echo "---------------------------------------------------"
fi

EXIT_CODE=0

if [ "$METRICS_AVAILABLE" = true ]; then
  # Get pods and their usage
  # Format: NAME CPU(cores) MEMORY(bytes)
  USAGE_DATA=$(kubectl top pods -n "$NAMESPACE" --no-headers)
else
  # If no metrics, just get the list of pods to check limits/requests
  USAGE_DATA=$(kubectl get pods -n "$NAMESPACE" --no-headers -o custom-columns=NAME:.metadata.name)
fi

while read -r line; do
  if [ -z "$line" ]; then continue; fi

  POD_NAME=$(echo "$line" | awk '{print $1}')
  
  if [ "$METRICS_AVAILABLE" = true ]; then
    CPU_USAGE=$(echo "$line" | awk '{print $2}' | sed 's/m//')
    MEM_USAGE=$(echo "$line" | awk '{print $3}' | sed 's/Mi//')
  fi

  # Fetching limits and requests for the pod
  RESOURCES=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.spec.containers[*].resources}')
  echo "Pod: $POD_NAME"
  
  if [ -n "$RESOURCES" ]; then
    CPU_LIMIT=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.spec.containers[0].resources.limits.cpu}' | sed 's/m//')
    MEM_LIMIT=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.spec.containers[0].resources.limits.memory}' | sed 's/Mi//' | sed 's/Gi/ * 1024/' | bc 2>/dev/null)
    
    CPU_REQUEST=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.spec.containers[0].resources.requests.cpu}' | sed 's/m//')
    MEM_REQUEST=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.spec.containers[0].resources.requests.memory}' | sed 's/Mi//' | sed 's/Gi/ * 1024/' | bc 2>/dev/null)

    echo "  Limits:   CPU: ${CPU_LIMIT:-N/A}m, Memory: ${MEM_LIMIT:-N/A}Mi"
    echo "  Requests: CPU: ${CPU_REQUEST:-N/A}m, Memory: ${MEM_REQUEST:-N/A}Mi"

    # If it's something like "1", convert to 1000. If it has 'm', it was already stripped.
    if [[ "$CPU_LIMIT" =~ ^[0-9]+$ ]] && [ "$CPU_LIMIT" -lt 100 ]; then
        CPU_LIMIT=$((CPU_LIMIT * 1000))
    fi

    if [ "$METRICS_AVAILABLE" = true ]; then
      if [ -n "$CPU_LIMIT" ] && [ "$CPU_LIMIT" -gt 0 ]; then
        CPU_PERC=$(( (CPU_USAGE * 100) / CPU_LIMIT ))
        if [ "$CPU_PERC" -gt "$CPU_THRESHOLD" ]; then
          echo "  WARNING: Pod $POD_NAME is using $CPU_PERC% of CPU limit ($CPU_USAGE m / $CPU_LIMIT m)"
          EXIT_CODE=1
        fi
      fi

      if [ -n "$MEM_LIMIT" ] && [ "$MEM_LIMIT" -gt 0 ]; then
        MEM_PERC=$(( (MEM_USAGE * 100) / MEM_LIMIT ))
        if [ "$MEM_PERC" -gt "$MEM_THRESHOLD" ]; then
          echo "  WARNING: Pod $POD_NAME is using $MEM_PERC% of Memory limit ($MEM_USAGE Mi / $MEM_LIMIT Mi)"
          EXIT_CODE=1
        fi
      fi
    fi
  else
    echo "  No resource limits/requests defined."
  fi
  echo "---------------------------------------------------"

done <<< "$USAGE_DATA"

if [ "$EXIT_CODE" -eq 0 ]; then
  echo "Resource usage is within thresholds."
fi

exit $EXIT_CODE
