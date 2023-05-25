#!/bin/bash
# Terraform script for managing infrastructure on Azure
# Version 1.0 (version format x.y accepted)
#
# Define functions
function clean_environment() {
  rm -rf .terraform*
  rm tfplan
  echo "cleaned!"
}

function help_usage() {
  echo "terraform.sh Version $(sed -n '3p' "$0" | awk '{print $3}')"
  echo "Usage: ./script.sh [ACTION] [ENV] [OTHER OPTIONS]"
  echo "es. ACTION: init, apply, plan, etc."
  echo "es. ENV: dev, uat, prod, etc."
  echo "Available actions:"
  echo "  clean         Remove .terraform* folders and tfplan files"
  echo "  help          This help"
  echo "  init          Initialize Terraform backend and modules"
  echo "  list          List every environment available"
  echo "  plan          Generate Terraform plan"
  echo "  apply         Apply Terraform plan"
  echo "  output        Show Terraform output"
  echo "  state         Show Terraform state"
  echo "  taint         Taint Terraform resource"
  echo "  destroy       Destroy Terraform-managed infrastructure"
  echo "  summ          Generate summary of Terraform plan"
}

function init_terraform() {
  if [ -n "$env" ]; then
    terraform init -reconfigure -backend-config="./env/$env/backend.tfvars"
  else
    echo "ERROR: no env configured!"
    exit 1
  fi
}

function list_env() {
  # Check if env directory exists
  if [ ! -d "./env" ]; then
    echo "No environment directory found"
    exit 1
  fi

  # List subdirectories under env directory
  env_list=$(ls -d ./env/*/ 2>/dev/null)

  # Check if there are any subdirectories
  if [ -z "$env_list" ]; then
    echo "No environments found"
    exit 1
  fi

  # Print the list of environments
  echo "Available environments:"
  for env in $env_list; do
    env_name=$(echo "$env" | sed 's#./env/##;s#/##')
    echo "- $env_name"
  done
}

function other_actions() {
  if [ -n "$env" ] && [ -n "$action" ]; then
    terraform $action -var-file="./env/$env/terraform.tfvars" -compact-warnings $other
  else
    echo "ERROR: no env or action configured!"
    exit 1
  fi
}

function state_output_taint_actions() {
  terraform $action $other
}

function tfsummary() {
  action="plan"
  other="-out=tfplan"
  other_actions
  if [ -n "$(command -v tf-summarize)" ]; then
    tf-summarize -separate-tree tfplan && rm tfplan
  else
    echo "tf-summarize is not installed"
  fi
}

function update_script() {
  set -x
  # Check if update is needed
  if [ -z "$(command -v curl)" ]; then
    echo "curl not found, cannot update script"
    exit 1
  fi

  current_version=$(sed -n '3p' "$0" | awk '{print $3}')
  repo_url="https://raw.githubusercontent.com/pagopa/eng-common-scripts/main/azure/terraform.sh"
  response=$(curl -s -w "%{http_code}" "$repo_url")

  if [ "${response: -3}" == "404" ]; then
    echo "Script not found in the repository!"
    exit 1
  else
    new_version=$(echo "$response" | sed -n '1p')
    new_script=$(curl -s "$repo_url")
  fi

  exit 0
  ###
  ### it will be modified in the future releases
  ###
  if [ "$(printf '%s\n' "$new_version" "$current_version" | sort -V | head -n 1)" != "$new_version" ]; then
    # Ask for confirmation
    read -p "New version $new_version available. Do you want to update? (y/n) " choice
    case "$choice" in
      y|Y )
        echo "Updating script to version $new_version"
        ;;
      * )
        echo "Update canceled"
        exit 0
        ;;
    esac
  elif [ "$current_version" == "$new_version" ]; then
    echo "Script is up to date"
    exit 0
  fi


  # Download new version
  new_script=$(curl -s "$repo_url")
  if [ -n "$new_script" ]; then
    echo "$new_script" > "$0"
    echo "Script updated to version $new_version"
  else
    echo "Failed to download new script"
    exit 1
  fi
}

# Check arguments number
if [ "$#" -lt 1 ]; then
  help_usage
  exit 0
fi

# Parse arguments
action=$1
env=$2
shift 2
other=$@

if [ -n "$env" ]; then
  source "./env/$env/backend.ini"
  if [ -z "$(command -v az)" ]; then
    echo "az not found, cannot proceed"
    exit 1
  fi
  az account set -s "${subscription}"
fi

# Call appropriate function based on action
case $action in
  clean)
    clean_environment
    ;;
  ?|help)
    help_usage
    ;;
  init)
    init_terraform
    init_terraform $other
    ;;
  list)
    list_env
    ;;
  output|state|taint)
    init_terraform
    state_output_taint_actions $other
    ;;
  summ)
    init_terraform
    tfsummary $other
    ;;
  update_script)
    update_script
    ;;
  *)
    init_terraform
    other_actions $other
    ;;
esac
