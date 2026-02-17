#!/bin/bash

# Runbook: fdr_health_check.sh
# Descrizione: Consolida i controlli per il namespace 'fdr' e mitiga i problemi 
#              riavviando la cache di PostgreSQL.
#
# Controlli inclusi:
# 1. Stato dei Pod (Running/Completed) nel namespace 'fdr'.
# 2. Errore "Unrecognized field \"title\"" nei log (indica errore di config).
# 3. Errore "Pool shutdown unexpectedly" nei log (indica chiusura connection pool).
#
# Mitigazione:
# - Restart del deployment 'cache-postgresql' nel namespace 'apiconfig'.

set -euo pipefail

FDR_NAMESPACE="fdr"
APICONFIG_NAMESPACE="apiconfig"
CACHE_DEPLOYMENT="cache-postgresql"
RESTART_NEEDED=false
REASON=""

echo "Starting health check for namespace: $FDR_NAMESPACE"

# 1. Verifica stato dei Pod
echo "Checking pods status..."
NOT_OK_PODS=$(kubectl get pods -n "$FDR_NAMESPACE" --no-headers | grep -vE "Running|Completed" | awk '{print $1}' || true)
if [ -n "$NOT_OK_PODS" ]; then
  RESTART_NEEDED=true
  REASON="Pods not OK: $(echo $NOT_OK_PODS | xargs)"
fi

# 2. Verifica log per "Unrecognized field \"title\""
if [ "$RESTART_NEEDED" = false ]; then
  echo "Checking logs for 'Unrecognized field \"title\"'..."
  ERROR_CONFIG=$(kubectl logs -n "$FDR_NAMESPACE" -l "app.kubernetes.io/name=pagopa-fdr-nodo" --since=15m 2>/dev/null | grep -i "Unrecognized field \"title\"" | head -n 1 || true)
  if [ -z "$ERROR_CONFIG" ]; then
    ERROR_CONFIG=$(kubectl logs -n "$FDR_NAMESPACE" --all-containers=true --since=15m 2>/dev/null | grep -i "Unrecognized field \"title\"" | head -n 1 || true)
  fi
  
  if [ -n "$ERROR_CONFIG" ]; then
    RESTART_NEEDED=true
    REASON="Found config deserialization error in logs"
  fi
fi

# 3. Verifica log per "Pool shutdown unexpectedly"
if [ "$RESTART_NEEDED" = false ]; then
  echo "Checking logs for 'Pool shutdown unexpectedly'..."
  ERROR_POOL=$(kubectl logs -n "$FDR_NAMESPACE" -l "app.kubernetes.io/name=pagopa-fdr-nodo" --since=15m 2>/dev/null | grep -i "Pool shutdown unexpectedly" | head -n 1 || true)
  if [ -z "$ERROR_POOL" ]; then
    ERROR_POOL=$(kubectl logs -n "$FDR_NAMESPACE" --all-containers=true --since=15m 2>/dev/null | grep -i "Pool shutdown unexpectedly" | head -n 1 || true)
  fi
  
  if [ -n "$ERROR_POOL" ]; then
    RESTART_NEEDED=true
    REASON="Found pool shutdown error in logs"
  fi
fi

if [ "$RESTART_NEEDED" = false ]; then
  echo "FDR Health Check: OK. No issues detected."
  exit 0
fi

echo "FDR Health Check: ISSUE DETECTED ($REASON)"
echo "---------------------------------------------------"
echo "Mitigation: Restarting '$CACHE_DEPLOYMENT' in '$APICONFIG_NAMESPACE'..."

if ! kubectl get deployment "$CACHE_DEPLOYMENT" -n "$APICONFIG_NAMESPACE" > /dev/null 2>&1; then
  echo "Error: Deployment '$CACHE_DEPLOYMENT' not found in namespace '$APICONFIG_NAMESPACE'."
  exit 1
fi

kubectl rollout restart deployment/"$CACHE_DEPLOYMENT" -n "$APICONFIG_NAMESPACE" || exit 1
kubectl rollout status deployment/"$CACHE_DEPLOYMENT" -n "$APICONFIG_NAMESPACE" || exit 1

echo "Mitigation action completed successfully."
exit 0
