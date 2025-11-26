#!/bin/bash

# Check if the required parameters are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <your-registry-server> <your-name> <your-password> <your-email>"
    exit 1
fi

# Assign parameters to variables
DOCKER_SERVER=$1        # acr url pagopa<env>commonacr.azurecr.io
DOCKER_USERNAME=$2      # acr usr pagopa<env>commonacr
DOCKER_PASSWORD=$3      # acr pwd 
# DOCKER_EMAIL=$4

# Create the Docker registry secret using kubectl
kubectl -n gps create secret docker-registry acr-credential \
    --docker-server="$DOCKER_SERVER" \
    --docker-username="$DOCKER_USERNAME" \
    --docker-password="$DOCKER_PASSWORD"
    # --docker-email="$DOCKER_EMAIL"

# Check if the secret was created successfully
if [ $? -eq 0 ]; then
    echo "Docker registry secret 'registry-credential' created successfully."
else
    echo "Failed to create Docker registry secret."
fi
