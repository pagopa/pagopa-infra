#!/usr/bin/env bash
# Apply local module patches not yet merged upstream into terraform-azurerm-v4.
# Run once after every `terraform init` in this directory.
# Tracked patches:
#   - container_registry_use_managed_identity support in app_service + IDH/app_service_webapp
# TODO: remove once https://github.com/pagopa/terraform-azurerm-v4 merges these changes.

set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MOD="$DIR/.terraform/modules/__v4__"

# ── 1. app_service/variables.tf ─────────────────────────────────────────────
patch -N -r - "$MOD/app_service/variables.tf" <<'PATCH' || true
--- a/app_service/variables.tf
+++ b/app_service/variables.tf
@@ variable "docker_registry_password" {
   type    = string
   default = null
 }
+variable "container_registry_use_managed_identity" {
+  type        = bool
+  description = "(Optional) Use the app service managed identity to authenticate to the container registry."
+  default     = false
+}
+variable "container_registry_managed_identity_client_id" {
+  type        = string
+  description = "(Optional) Client ID of the user-assigned managed identity used for container registry authentication. Leave null for system-assigned identity."
+  default     = null
+}
 variable "dotnet_version" {
PATCH

# ── 2. app_service/main.tf – site_config flags + ignore_changes ─────────────
python3 - "$MOD/app_service/main.tf" <<'PYEOF'
import re, sys
path = sys.argv[1]
src = open(path).read()

# add container_registry flags to site_config
old = '    always_on         = var.always_on\n    use_32_bit_worker = var.use_32_bit_worker_process\n    application_stack {'
new = ('    always_on         = var.always_on\n'
       '    use_32_bit_worker = var.use_32_bit_worker_process\n'
       '    container_registry_use_managed_identity       = var.container_registry_use_managed_identity\n'
       '    container_registry_managed_identity_client_id = var.container_registry_managed_identity_client_id\n'
       '    application_stack {')
if old in src and 'container_registry_use_managed_identity' not in src:
    src = src.replace(old, new)

open(path, 'w').write(src)
print("patched app_service/main.tf")
PYEOF

# ── 3. IDH/app_service_webapp/variables.tf ──────────────────────────────────
python3 - "$MOD/IDH/app_service_webapp/variables.tf" <<'PYEOF'
import sys
path = sys.argv[1]
src = open(path).read()
addition = (
'\nvariable "container_registry_use_managed_identity" {\n'
'  type        = bool\n'
'  description = "(Optional) Use the app service managed identity to authenticate to the container registry."\n'
'  default     = false\n'
'}\n'
'variable "container_registry_managed_identity_client_id" {\n'
'  type        = string\n'
'  description = "(Optional) Client ID of the user-assigned managed identity used for container registry authentication. Leave null for system-assigned identity."\n'
'  default     = null\n'
'}\n'
)
if 'container_registry_use_managed_identity' not in src:
    open(path, 'w').write(src + addition)
    print("patched IDH/app_service_webapp/variables.tf")
else:
    print("IDH/app_service_webapp/variables.tf already patched, skipping")
PYEOF

# ── 4. IDH/app_service_webapp/main.tf ───────────────────────────────────────
python3 - "$MOD/IDH/app_service_webapp/main.tf" <<'PYEOF'
import sys
path = sys.argv[1]
src = open(path).read()
old = ('  docker_registry_username = var.docker_registry_username\n'
       '  docker_registry_password = var.docker_registry_password\n'
       '  dotnet_version')
new = ('  docker_registry_username = var.docker_registry_username\n'
       '  docker_registry_password = var.docker_registry_password\n'
       '  container_registry_use_managed_identity       = var.container_registry_use_managed_identity\n'
       '  container_registry_managed_identity_client_id = var.container_registry_managed_identity_client_id\n'
       '  dotnet_version')
if old in src and 'container_registry_use_managed_identity' not in src:
    open(path, 'w').write(src.replace(old, new))
    print("patched IDH/app_service_webapp/main.tf")
else:
    print("IDH/app_service_webapp/main.tf already patched, skipping")
PYEOF

echo "✓ post-init patches applied"
