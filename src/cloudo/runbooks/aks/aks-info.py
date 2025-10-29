import os
import subprocess
import json


def run_kubectl(cmd, env=None):
    print(f"Running: {' '.join(cmd)}")
    result = subprocess.run(
        cmd,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        universal_newlines=True,
        env=env
    )
    if result.returncode != 0:
        raise subprocess.CalledProcessError(result.returncode, cmd, output=result.stdout, stderr=result.stderr)
    return result.stdout


def get_namespace_info(namespace):
    try:
        env = os.environ.copy()
        print(f"KUBECONFIG={env.get('KUBECONFIG')}, AKS_NAMESPACE={namespace}")

        ns_info = run_kubectl(['kubectl', 'get', 'namespace', namespace, '-o', 'json'], env=env)
        quotas = run_kubectl(['kubectl', 'get', 'resourcequota', '-n', namespace, '-o', 'json'], env=env)
        pods = run_kubectl(['kubectl', 'get', 'pods', '-n', namespace, '-o', 'json'], env=env)
        deployments = run_kubectl(['kubectl', 'get', 'deployments', '-n', namespace, '-o', 'json'], env=env)

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
        print(f"Error executing kubectl command: {e}\nstderr: {e.stderr.strip()}")
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

    if get_namespace_info(namespace) is None:
        exit(1)
    else:
        exit(0)