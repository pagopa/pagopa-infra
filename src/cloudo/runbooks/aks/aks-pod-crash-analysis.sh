#!/bin/bash

# Script to analyze and mitigate crashing pods in a namespace
# Required environment variables:
# - AKS_NAMESPACE

NAMESPACE=${AKS_NAMESPACE:-"default"}

if [ "$MONITOR_CONDITION" == "Resolved" ]; then
  echo "Alert mitigated!"
  exit 0
fi

echo "Analyzing pods in namespace: $NAMESPACE"

EXIT_CODE=0

# Get pods that are not Running or Succeeded
CRASHING_PODS=$(kubectl get pods -n "$NAMESPACE" --no-headers | grep -vE "Running|Completed" | awk '{print $1}')

if [ -z "$CRASHING_PODS" ]; then
  echo "No crashing pods found in namespace $NAMESPACE."
  exit 0
fi

EXIT_CODE=1

for POD in $CRASHING_PODS; do
  echo "---------------------------------------------------"
  echo "Analyzing POD: $POD"
  
  STATUS=$(kubectl get pod "$POD" -n "$NAMESPACE" -o jsonpath='{.status.phase}')
  REASON=$(kubectl get pod "$POD" -n "$NAMESPACE" -o jsonpath='{.status.containerStatuses[0].state.waiting.reason}')
  MESSAGE=$(kubectl get pod "$POD" -n "$NAMESPACE" -o jsonpath='{.status.containerStatuses[0].state.waiting.message}')
  
  echo "Status: $STATUS"
  echo "Reason: $REASON"
  echo "Message: $MESSAGE"
  
  if [[ "$REASON" == "CrashLoopBackOff" || "$REASON" == "Error" ]]; then
    echo "Logs for $POD (last 20 lines):"
    kubectl logs "$POD" -n "$NAMESPACE" --tail=20
    
    echo "Previous logs for $POD (last 20 lines):"
    kubectl logs "$POD" -n "$NAMESPACE" --previous --tail=20
    
    # Mitigation: try to delete the pod to trigger a restart from the Controller
    echo "Attempting mitigation: Deleting pod $POD to trigger restart..."
    kubectl delete pod "$POD" -n "$NAMESPACE" --wait=false
  fi
  
  if [[ "$REASON" == "ImagePullBackOff" || "$REASON" == "ErrImagePull" ]]; then
    IMAGE=$(kubectl get pod "$POD" -n "$NAMESPACE" -o jsonpath='{.spec.containers[0].image}')
    echo "Mitigation failed: Cannot pull image $IMAGE. Please check if the image exists and registry credentials."
  fi
done

exit $EXIT_CODE
