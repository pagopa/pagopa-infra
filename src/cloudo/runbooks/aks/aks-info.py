import os
import subprocess
import json


def run_kubectl(cmd, env=None):
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
        print(env)
        print(run_kubectl(['kubectl', 'config', 'view'], env=env).strip())
        print(run_kubectl(['cat', '$HOME/kube/.config'], env=env).strip())
        pods = run_kubectl(['kubectl', 'get', 'pods', '-n', namespace, '-o', 'json'], env=env)
        deployments = run_kubectl(['kubectl', 'get', 'deployments', '-n', namespace, '-o', 'json'], env=env)

        pod_data = json.loads(pods)
        deployment_data = json.loads(deployments)

        print(f"\nNamespace Information for: {namespace}")
        print("-" * 50)

        print(f"\nPods Total: {len(pod_data['items'])}")
        running_pods = sum(1 for pod in pod_data['items'] if pod['status']['phase'] == 'Running')
        print(f"Pods Running: {running_pods}")

        print(f"\nDeployments Total: {len(deployment_data['items'])}")
        for deploy in deployment_data['items']:
            print(f"Deployment: {deploy['metadata']['name']}")
            print(f"  Replicas: {deploy['status'].get('replicas', 0)}/{deploy['status'].get('availableReplicas', 0)}")

        return True
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