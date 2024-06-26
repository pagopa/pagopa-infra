#!/usr/bin/env bash
set -e
############################################################
# Remove and import a Terraform resource from the tfstate
############################################################
# Global variables
VERS="1.0"

############################################################
# Print usage information                                                     #
############################################################
function print_usage() {
  me=`basename "$0"`
  echo "Setup v."${VERS} "sets up a configuration relative to a specific subscription"
  echo "  ./${me} <resource name to remove> <resource name to add> <ENV>"
  for thisenv in $(ls "env/")
  do
      echo "  Example: ./${me} \"module.function_lollipop[0].azurerm_function_app.this\" \"module.function_lollipop[0].azurerm_linux_function_app.this\" ${thisenv}"
  done
  echo
  echo "Syntax: setup.sh [-l|h]"
  echo "  options:"
  echo "  h     Print this Help."
  echo "  l     List available environments."
  echo
}

function removeAndImport() {
    local old_resource_name="$1"
    # Square brackets are not processed normally by grep, otherwise
    esc_old_resource_name=$(echo "$old_resource_name" | sed 's/\[/\\[/g; s/\]/\\]/g')

    local new_resource_name="$2"

    local myenv="$3"

    # Check if terraform.sh exists in the current folder
    if ! which ./terraform.sh &> /dev/null; then
        echo "No terraform.sh found!"
        exit 1
    fi

    # Check if the "Terraform" and "jq" commands are available
    if ! which terraform &> /dev/null && which jq &> /dev/null; then
        echo "Please install terraform and jq before proceeding."
        exit 1
    fi

    if [ -z "$old_resource_name" ] || [ -z "$new_resource_name" ] || [ -z "$myenv" ]; then
        echo "You need to define the resources to be removed and imported in order to proceed and the environment to be used!!"
        exit 1
    fi
    if [ "$(terraform show | grep $esc_old_resource_name)" ]; then
        # Get the resource ID
        function_app_id=$(terraform show -json | jq --arg resource "$old_resource_name" '.values.root_module.child_modules[].resources[] | select(.address==$resource).values.id' | tr -d '"')
        echo "function_app_id: ${function_app_id}"
        # Import the resource
        echo "Importing the resource ${new_resource_name}"
        ./terraform.sh import $myenv $new_resource_name $function_app_id 
        if [ $? -eq 0 ]; then
            echo "Successfully imported the resource ${new_resource_name} with ID: ${function_app_id}!"
            # Remove the resource from the state file
            echo "Removing the resource ${old_resource_name}"
            terraform state rm "$old_resource_name"
            if [ $? -eq 0 ]; then
                echo "$old_resource_name removed!"
            else
                echo "I can't remove the resource $old_resource_name from your Terraform state!"
            fi
        else
            echo "I can't import the resource $new_resource_name"
        fi
    else
        echo "I can't find the resource $old_resource_name in your Terraform state"
    fi
}

############################################################
# Main program                                             #
############################################################
# Get the options
while getopts ":hl-:" option; do
   case $option in
      h) # display Help
         print_usage
         exit;;
      l) # list available environments
         echo "Available environment(-s):"
         ls -1 "env/"
         exit;;
      *) # Invalid option
         echo "Error: Invalid option"
         exit;;
   esac
done

if [[ $3 ]]; then
  removeAndImport $1 $2 $3
else
  print_usage
fi
exit 0


