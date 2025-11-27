import json
import os
import sys
import subprocess
from pathlib import Path
import logging
import traceback

# How to use:
#
# 1. Link this file inside the new domain folder, e.g.:
#    `ln -s ../../../scripts/generate_imports.sh .`
#
# 2. Write a file with a Terraform resource address for each line,
#    where plain resources have a heading `resource.` and modules have
#    a trailing `module.`
#
# 3. Run this script passing the file at step 2 as input and the env as a CLI
#    parameter, e.g.:
#    `python generate_imports.py dev < file_at_step_2`
#
# 4. This script generates an import script in the same folder.
#    Run the generated script to import Terraform resources, e.g.:
#    `bash ./import_dev.sh`


def import_resource(address, resource_object):
    return [(address, resource_object["values"]["id"])]


def import_any(address, state_file_object):
    if address.startswith("resource."):
        address = address[len("resource."):]

    resources = []
    parent_address = state_file_object.get('address', 'root')

    logging.debug(f"state_file_object: {parent_address}")

    if address.startswith("module"):
        # Module

        if "child_modules" in state_file_object.keys():
            root_search_resource = list(filter(lambda r: r["address"] == address, state_file_object["child_modules"]))[0]
        else:
            root_search_resource = state_file_object
        
        for resource in root_search_resource["resources"]:
            logging.info(f"Importing {resource['address']} at {address}")
            resources += import_resource(resource["address"], resource)
        
        for child_module in root_search_resource.get("child_modules", []):
            resources += import_any(child_module["address"], child_module)
    else:
        # Plain resource
        logging.debug(f"Looking for resource {address} in {parent_address}")
        logging.debug(f"Keys: {state_file_object.keys()}")
        root_search_resource = list(filter(lambda r: r["address"] == address, state_file_object["resources"]))[0]

        resources = import_resource(address, root_search_resource)

    return resources


def generate_import_command(parent_resource_address, resource_address, id, env):
    result = f"# {parent_resource_address}\n"
    result += f"echo 'Importing {resource_address}'\n"
    result += f"./terraform.sh import weu-{env} '{resource_address}' '{id}'\n\n"

    return result


def main():
    logging.basicConfig(format="%(levelname)s:\t %(message)s", level=os.getenv("LOG_LEVEL", "INFO"))

    if len(sys.argv) != 2:
        logging.error(f"Invalid number of arguments.\nSyntax: {sys.argv[0]} ENV < RESOURCE_FILE_LIST\n\
\t\twhere ENV is one of: dev, uat, prod\n\
\t\tand RESOURCE_FILE_LIST contains a list of resource addresses to import")
        exit(1)

    data = list(map(lambda s: s.strip(), sys.stdin.readlines()))
    env = sys.argv[1]

    if env not in {"dev", "uat", "prod"}:
        logging.error("Must specify valid environment. Choices: dev, uat, prod")
        exit(1)

    core_terraform_script = Path("..") / ".." / "core" / "terraform.sh"

    if not core_terraform_script.exists():
        logging.error(f"Cannot find core terraform script at {core_terraform_script}! Exiting...")
        exit(1)
    
    logging.info(f"Initializing Terraform in Core for env {env}")

    cwd = os.getcwd()
    os.chdir(str(core_terraform_script.parent))

    p = subprocess.run(["./terraform.sh", "init", f"weu-{env}"], capture_output=True, encoding="utf-8")
    print(p.stdout)

    if p.returncode != 0:
        print(p.stderr)
        logging.error("Bad return code from terraform, exiting...")
        exit(1)
    
    logging.info("Getting Terraform state file dump...")

    p = subprocess.run(["terraform", "show", "-json"], capture_output=True, encoding="utf-8")

    if p.returncode != 0:
        print(p.stdout)
        print(p.stderr)
        logging.error("Bad return code from terraform, exiting...")
        exit(1)

    os.chdir(cwd)
    output_file_path = f"import_{env}.sh"
    logging.info(f"Writing import script at {output_file_path}")

    with open(output_file_path, "w") as output_import_file:
        state_file_object = json.loads(p.stdout)

        output_import_file.write("#!/bin/bash\n")

        output_import_file.write("# Generated with `generate_imports.py`\n\n")

        for address in data:
            resources_to_import = []

            try:
                import_data = import_any(address, state_file_object["values"]["root_module"])
                resources_to_import += import_data
            except Exception as e:
                logging.error(f"Error while getting resource search results for resource {address}\n{e}")
                logging.debug(traceback.format_exc())
                continue
    
            logging.info(f"resources: {list(map(lambda s: s[0], resources_to_import))}")

            for (child_resource_address, id) in resources_to_import:
                output_import_file.write(f"{generate_import_command(address, child_resource_address, id, env)}\n")
        
        output_import_file.write(f"echo 'Import executed succesfully on {env} environment! ⚡'\n")
    
    logging.info(f"Written import script at {output_file_path}! 🙂")
    

if __name__ == '__main__':
    main()
