import os
import subprocess
import json


def get_namespace_info(namespace):
    try:
        # Get namespace details
        ns_info = subprocess.check_output(
            ['kubectl', 'get', 'namespace', namespace, '-o', 'json'],
            universal_newlines=True
        )

        # Get resource quotas
        quotas = subprocess.check_output(
            ['kubectl', 'get', 'resourcequota', '-n', namespace, '-o', 'json'],
            universal_newlines=True
        )

        # Get pod count
        pods = subprocess.check_output(
            ['kubectl', 'get', 'pods', '-n', namespace, '-o', 'json'],
            universal_newlines=True
        )

        # Get deployments
        deployments = subprocess.check_output(
            ['kubectl', 'get', 'deployments', '-n', namespace, '-o', 'json'],
            universal_newlines=True
        )

        # Parse the JSON outputs
        ns_data = json.loads(ns_info)
        quota_data = json.loads(quotas)
        pod_data = json.loads(pods)
        deployment_data = json.loads(deployments)

        print(f"\nNamespace Information for: {namespace}")
        print("-" * 50)
        print(f"Status: {ns_data['status']['phase']}")
        print(f"Created: {ns_data['metadata']['creationTimestamp']}")

        print(f"\nPods Total: {len(pod_data['items'])}")
        running_pods = sum(1 for pod in pod_data['items'] if pod['status']['phase'] == 'Running')
        print(f"Pods Running: {running_pods}")

        print(f"\nDeployments Total: {len(deployment_data['items'])}")
        for deploy in deployment_data['items']:
            print(f"Deployment: {deploy['metadata']['name']}")
            print(f"  Replicas: {deploy['status'].get('replicas', 0)}/{deploy['status'].get('availableReplicas', 0)}")

        if quota_data['items']:
            print("\nResource Quotas:")
            for quota in quota_data['items']:
                print(f"\nQuota Name: {quota['metadata']['name']}")
                if 'hard' in quota['status']:
                    for resource, limit in quota['status']['hard'].items():
                        print(f"  {resource}: {limit}")

    except subprocess.CalledProcessError as e:
        print(f"Error executing kubectl command: {e}")
        return None
    except json.JSONDecodeError as e:
        print(f"Error parsing JSON response: {e}")
        return None
    except Exception as e:
        print(f"Unexpected error: {e}")
        return None


if __name__ == "__main__":
    namespace = os.getenv('AKS_NAMESPACE')

    if not namespace:
        print("Error: AKS_NAMESPACE environment variable not set")
        exit(1)

    get_namespace_info(namespace)
