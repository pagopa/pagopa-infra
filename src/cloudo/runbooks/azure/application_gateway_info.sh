#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage:"
  echo "  $0 <APPGW_NAME> <APPGW_RG> [--metric NAME] [--aggregation TYPE] [--interval ISO8601]"
  echo
  echo "Examples:"
  echo "  $0 my-appgw my-rg"
  echo "  $0 my-appgw my-rg --metric TotalRequests --aggregation Total --interval PT5M"
}

# Require at least 2 positional args
if [[ $# -lt 2 ]]; then
  usage
  exit 1
fi

APPGW_NAME="$1"; shift
APPGW_RG="$1"; shift

# Defaults
METRIC="TotalRequests"
AGGREGATION="Total"
TIMESPAN="PT1H"
INTERVAL="PT5M"

require_value() {
  if [[ $# -lt 1 || -z "${1:-}" || "${1:-}" == --* ]]; then
    echo "Missing value for option." >&2
    usage
    exit 1
  fi
}

# Parse options
while [[ $# -gt 0 ]]; do
  case "$1" in
    --metric) shift; require_value "${1:-}"; METRIC="$1"; shift ;;
    --aggregation) shift; require_value "${1:-}"; AGGREGATION="$1"; shift ;;
    --interval) shift; require_value "${1:-}"; INTERVAL="$1"; shift ;;
    -h|--help) usage; exit 0 ;;
    *)
      echo "Unknown option: $1" >&2
      usage
      exit 1
      ;;
  esac
done

if ! az account show >/dev/null 2>&1; then
  echo "Logging into Azure..."
  az login --identity --client-id "$AZURE_CLIENT_ID" >/dev/null
fi

APPGW_ID="$(az network application-gateway show \
  --name "$APPGW_NAME" \
  --resource-group "$APPGW_RG" \
  --query id -o tsv)"

if [[ -z "${APPGW_ID:-}" ]]; then
  echo "Could not find Application Gateway '$APPGW_NAME' in resource group '$APPGW_RG'." >&2
  exit 1
fi

# Fetch metrics (use --metrics for latest az; fallback to --metric if needed)
if az monitor metrics list --help | grep -q "\--metrics"; then
  METRICS_CMD=(az monitor metrics list --resource "$APPGW_ID" --metrics "$METRIC" --aggregation "$AGGREGATION" --interval "$INTERVAL" -o json)
else
  METRICS_CMD=(az monitor metrics list --resource "$APPGW_ID" --metric "$METRIC" --aggregation "$AGGREGATION" --interval "$INTERVAL" -o json)
fi

METRICS_JSON="$("${METRICS_CMD[@]}")"

# Summary output
echo "Application Gateway: $APPGW_NAME"
echo "Resource Group:      $APPGW_RG"
echo "Metric:              $METRIC"
echo "Aggregation:         $AGGREGATION"
echo "Timespan:            $TIMESPAN"
echo "Interval:            $INTERVAL"
echo

# Print data points
if command -v jq >/dev/null 2>&1; then
  COUNT=$(echo "$METRICS_JSON" | jq -r '.value[0].timeseries[0].data | length // 0')
  if [[ "$COUNT" -eq 0 ]]; then
    echo "No data available for the selected period."
    exit 0
  fi
  echo "Timestamp, Value"
  echo "$METRICS_JSON" | jq -r --arg agg "$AGGREGATION" '
    .value[0].timeseries[0].data[]
    | [.timeStamp, .[($agg | ascii_downcase)]]
    | @csv'
else
  echo "jq not found: printing raw JSON output."
  echo "$METRICS_JSON"
fi
