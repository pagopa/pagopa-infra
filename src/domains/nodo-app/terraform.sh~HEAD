#!/bin/bash
############################################################
# Terraform script for managing infrastructure on Azure
# Fingerprint: d2hhdHlvdXdhbnQ/Cg==
############################################################
# Global variables
# Version format x.y accepted
vers="1.1"
script_name=$(basename "$0")
git_repo="https://raw.githubusercontent.com/pagopa/eng-common-scripts/main/azure/${script_name}"
tmp_file="${script_name}.new"

# Define functions
function clean_environment() {
  rm -rf .terraform*
  rm tfplan 2>/dev/null
  echo "cleaned!"
}

function help_usage() {
  echo "terraform.sh Version ${vers}"
  echo
  echo "Usage: ./script.sh [ACTION] [ENV] [OTHER OPTIONS]"
  echo "es. ACTION: init, apply, plan, etc."
  echo "es. ENV: dev, uat, prod, etc."
  echo
  echo "Available actions:"
  echo "  clean         Remove .terraform* folders and tfplan files"
  echo "  help          This help"
  echo "  list          List every environment available"
  echo "  summ          Generate summary of Terraform plan"
  echo "  *             any terraform option"
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
    terraform "$action" -var-file="./env/$env/terraform.tfvars" -compact-warnings $other
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
    tf-summarize -separate-tree tfplan  && rm tfplan 2>/dev/null
  else
    echo "tf-summarize is not installed"
  fi
}

function update_script() {
  # Check if the repository was cloned successfully
  if ! curl -sL "$git_repo" -o "$tmp_file"; then
    echo "Error cloning the repository"
    rm "$tmp_file" 2>/dev/null
    return 1
  fi

  # Check if a newer version exists
  remote_vers=$(sed -n '8s/vers="\(.*\)"/\1/p' "$tmp_file")
  if [ "$(printf '%s\n' "$vers" "$remote_vers" | sort -V | tail -n 1)" == "$vers" ]; then
    echo "The local script version is equal to or newer than the remote version."
    rm "$tmp_file" 2>/dev/null
    return 0
  fi

  # Check the fingerprint
  local_fingerprint=$(sed -n '4p' "$0")
  remote_fingerprint=$(sed -n '4p' "$tmp_file")

  if [ "$local_fingerprint" != "$remote_fingerprint" ]; then
    echo "The local and remote file fingerprints do not match."
    rm "$tmp_file" 2>/dev/null
    return 0
  fi

  # Show the current and available versions to the user
  echo "Current script version: $vers"
  echo "Available script version: $remote_vers"

  # Ask the user if they want to update the script
  read -rp "Do you want to update the script to version $remote_vers? (y/n): " answer

  if [ "$answer" == "y" ] || [ "$answer" == "Y" ]; then
    # Replace the local script with the updated version
    cp "$tmp_file" "$script_name"
    chmod +x "$script_name"
    rm "$tmp_file" 2>/dev/null

    echo "Script successfully updated to version $remote_vers"
  else
    echo "Update canceled by the user"
  fi

  rm "$tmp_file" 2>/dev/null
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
  # shellcheck source=/dev/null
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
    init_terraform "$other"
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
    tfsummary "$other"
    ;;
  update)
    update_script
    ;;
  *)
    # [ -z "$TF_INIT" ] && terraform init
    other_actions "$other"
    ;;
esac
