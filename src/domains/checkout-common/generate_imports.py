import json
import os
import sys
import subprocess
from pathlib import Path
import logging

"""
Returns an array of child resource addresses declared inside the module corresponding to `module_address` to be imported
"""
def import_module(module_address, state_file):
    search_query = f"jq '[.values.root_module.child_modules[]]' {state_file} | jq 'map(select(.address == \"{module_address}\"))' | jq \".[0].resources | map(.address)\""

    logging.debug("Executing command %s", search_query)

    p = subprocess.run(search_query, shell=True, check=True, capture_output=True)
    process_output = str(p.stdout, "utf-8")

    logging.debug("Command output: %s", process_output)

    module_resources = json.loads(process_output)

    return module_resources


"""
Searches for resource data inside a JSON Terraform state file.
If `exact_search` is True don't try to guess the resource name from the address but use the provided address for searching.

Returns a triple (search_address, core_address, id) where:
 * `search_address` is the resource name used when searching for the resource to be imported
 * `core_address` is the proper address of the resource to be imported
 * `id` is the id of the resource assigned by the resource provider
"""
def import_resource(resource_address, state_file, exact_search=False):

    if exact_search:
        search_address = resource_address
    else:
        search_address = resource_address.split(".")[-1]

    search_query = f"jq '[.values.root_module.child_modules[].resources[], .values.root_module.resources[]] | map({{address, id: .values.id}})' {state_file} | jq 'map(select(.address | contains(\"{search_address}\")))'"

    logging.debug(f"Executing {search_query}")

    p = subprocess.run(search_query, shell=True, check=True, capture_output=True)
    process_output = str(p.stdout, "utf-8")

    search_results = json.loads(process_output)
    core_address = search_results[0]["address"]
    id = search_results[0]["id"]

    return (search_address, core_address, id)


def generate_import_command(address, core_address, id, env):
    result = f"# {address}\n"
    result += f"echo 'Importing {core_address}'\n"
    result += f"./terraform.sh import weu-{env} '{core_address}' '{id}'\n\n"

    return result


def main():
    logging.basicConfig(format="%(levelname)s:\t %(message)s", level=os.getenv("LOG_LEVEL", "INFO"))

    if len(sys.argv) != 3:
        logging.error(f"Invalid number of arguments.\nSyntax: {sys.argv[0]} ENV STATE_FILE < RESOURCE_FILE_LIST\n\
\t\twhere ENV is one of: dev, uat, prod\n\
\t\tSTATE_FILE is a path to the output of `terraform show -json`\n\
\t\tand RESOURCE_FILE_LIST contains a list of resource addresses to import")
        exit(1)

    data = list(map(lambda s: s.strip(), sys.stdin.readlines()))
    env = sys.argv[1]
    state_file = Path(sys.argv[2])

    if env not in {"dev", "uat", "prod"}:
        logging.error("Must specify valid environment. Choices: dev, uat, prod")
        exit(1)

    if not state_file.exists():
        logging.error(f"State file at {state_file} does not exits. Exiting...")
        exit(1)

    output_file_path = f"import_{env}.sh"
    logging.info(f"Writing import script at {output_file_path}")

    with open(output_file_path, "w") as output_import_file:
        output_import_file.write("#!/bin/bash\n")

        output_import_file.write("# Generated with `generate_imports.py`\n\n")

        for address in data:
            resources_to_import = []

            try:
                # Check whether we are importing a module and transitively import resources
                if address.startswith("module"):
                    child_resources = import_module(address, state_file)

                    for child_resource_address in child_resources:
                        logging.info(f"Importing child resource {child_resource_address}")
                        (search_address, core_address, id) = import_resource(child_resource_address, state_file, exact_search=True)
                        resources_to_import.append((search_address, core_address, id))
                else:
                    (search_address, core_address, id) = import_resource(address, state_file)
                    resources_to_import.append((search_address, core_address, id))
                    
            except Exception as e:
                logging.info(f"Error while getting resource search results for resource {search_address}\n{e}")
                continue

            logging.info(f"Writing import for resource {address} with id {id}")

            for (search_address, core_address, id) in resources_to_import:
                output_import_file.write(f"{generate_import_command(address, core_address, id, env)}\n")
        
        output_import_file.write(f"echo 'Import executed succesfully on {env} environment! ⚡'\n")
    

if __name__ == '__main__':
    main()
