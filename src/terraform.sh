#!/bin/bash

set -e

action=$1
env=$2
shift 2
other=$@

if [ -z "$action" ]; then
  echo "Missed action: init, apply, plan"
  exit 0
fi

if [ -z "$env" ]; then
  echo "env should be: dev, uat or prod."
  exit 0
fi

source "./env/$env/backend.ini"
az account set -s "${subscription}"

if echo "init plan apply refresh import output state taint destroy" | grep -w $action > /dev/null; then
  if [ $action = "init" ]; then
    terraform $action -backend-config="./env/$env/backend.tfvars" $other
  elif [ $action = "output" ] || [ $action = "state" ] || [ $action = "taint" ]; then
    # init terraform backend
    terraform init -reconfigure -backend-config="./env/$env/backend.tfvars"
    terraform $action $other
  else
    # init terraform backend
    terraform init -reconfigure -backend-config="./env/$env/backend.tfvars"
    terraform $action -var-file="./env/$env/terraform.tfvars" $other
  fi
else
    echo "Action not allowed."
    exit 1
fi
