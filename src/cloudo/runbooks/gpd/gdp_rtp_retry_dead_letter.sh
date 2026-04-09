#!/bin/sh
set -e

BASE_URL="https://weudev.gps.internal.dev.platform.pagopa.it/gpd-rtp-service"
if [ "$CLOUDO_ENVIRONMENT" = "uat" ]; then
  BASE_URL="https://weuuat.gps.internal.uat.platform.pagopa.it/gpd-rtp-service"
elif [ "$CLOUDO_ENVIRONMENT" = "prod" ]; then
  BASE_URL="https://weuprod.gps.internal.platform.pagopa.it/gpd-rtp-service"
fi

# Retrieve Dead Letter messages to retry
RESPONSE=$(curl -s -k "${BASE_URL}/error-messages")

if [ -z "$RESPONSE" ] || [ "$RESPONSE" = "[]" ]; then
  echo "No messages to retry"
  exit 0
fi

# Send retry request for the retrieved messages
curl -s -k -X POST \
  -H "Content-Type: application/json" \
  -d "$RESPONSE" \
  "${BASE_URL}/error-messages/retry"