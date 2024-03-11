# Setup Script for AKS Configuration

This script is designed to set up a configuration related to a specific subscription for Azure Kubernetes Service (AKS). The script will check for the necessary tools, such as Azure CLI and kubectl, before proceeding with the configuration.

## Features

- Setup configuration for a given subscription
- Check for the existence of Azure CLI and kubectl
- Set the AKS credentials
- Optionally install and use kubelogin for converting kubeconfig to use Azure CLI login mode

## Usage

1. Change the current directory to the scripts folder:
**cd <scripts_folder>**

2. Run the script with the chosen environment:
**./k8setup.sh <ENV>**

Replace `<ENV>` with the desired environment. To list the available environments use **./k8setup.sh -l**


3. The script provides the following options:

- `-h`: Display help information
- `-l`: List available environments
- `-k`: Use kubelogin to convert kubeconfig to Azure CLI login mode
- `-s`: Setup all the requirements at once

Example:
**././k8setup.sh -k**


## Kubelogin

Sometimes you will get the following message:
```
I0428 16:55:52.111080   11139 versioner.go:58] no Auth Provider found for name "azure"
error: The azure auth plugin has been removed.
```
That means you need to convert your kubeconfig via `kubelogin` to use azurecli login mode.
In that case you have to use **././k8setup.sh -k** in order to use `kubectl` or your preferred K8s client.

## Notes

- The script assumes that the subscription configurations are stored in the `./subscription` directory.
- Make sure you have the necessary permissions and tools installed before running the script.
- The script will interactively ask for confirmation before installing the following packages using brew if they are not already present:
  - kubelogin
  - kubectl
  - azure-cli
  - jq
