#!/bin/sh
set -e

BASE_URL="https://weudev.gps.internal.dev.platform.pagopa.it/gpd-rtp-service"

RESPONSE=$(curl -s -k "${BASE_URL}/error-messages")

if [ -z "$RESPONSE" ] || [ "$RESPONSE" = "[]" ]; then
  echo "No messages to retry"
  exit 0
fi

curl -s -k -X POST \
  -H "Content-Type: application/json" \
  -d "$RESPONSE" \
  "${BASE_URL}/error-messages/retry"