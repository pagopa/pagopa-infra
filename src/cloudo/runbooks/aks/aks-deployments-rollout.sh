#!/bin/bash

# Script to log into AKS and perform a deployment rollout
# Required parameters:
# - Resource group name
# - AKS cluster name
# - Namespace
# - Deployment name


NAMESPACE=$AKS_NAMESPACE
DEPLOYMENT_NAME=$AKS_DEPLOYMENT

# Perform deployment rollout
echo "Performing rollout for deployment $DEPLOYMENT_NAME in namespace $NAMESPACE..."
kubectl rollout restart deployment/$DEPLOYMENT_NAME -n $NAMESPACE

# Check rollout status
echo "Checking rollout status..."
kubectl rollout status deployment/$DEPLOYMENT_NAME -n $NAMESPACE
